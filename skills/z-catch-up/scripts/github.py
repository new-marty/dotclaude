#!/usr/bin/env python3
"""GitHub source for z-catch-up. Collects facts; writes one JSON file; makes no judgement.

This is one source among several the skill may draw on. It knows GitHub's native
hierarchy (issue types, parent / sub-issues, Projects v2 status) and pull requests. When
the work is tracked elsewhere, write a sibling script that emits the same shape
(see references/sources.md) and the skill's procedure does not change.

Usage:
    github.py [--repo OWNER/NAME] [--merged-days N] [--out PATH]

--repo          restrict to one repository (default: every repository the search hits)
--merged-days   how far back to look for your merged pull requests (default 90)
--out           where to write the JSON (default ~/.claude/cache/z-catch-up/github.json)

Nothing is written inside a repository. Needs `gh` logged in; Projects v2 status needs
the `project` scope (`gh auth refresh -s project` if every status comes back empty).
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path

CACHE = Path.home() / ".claude" / "cache" / "z-catch-up"

ISSUE_FIELDS = """
  number title url state body createdAt lastEditedAt updatedAt closedAt
  repository { nameWithOwner }
  issueType { name }
  milestone { title }
  labels(first: 20) { nodes { name } }
  assignees(first: 5) { nodes { login } }
  parent { number title url }
  subIssuesSummary { total completed }
  subIssues(first: 50) {
    nodes { number title url state closedAt issueType { name } subIssuesSummary { total completed }
            assignees(first: 5) { nodes { login } } }
  }
  closedByPullRequestsReferences(first: 10, includeClosedPrs: true) {
    nodes { number title url state isDraft merged mergedAt baseRefName headRefName body }
  }
  comments(last: 3) { nodes { createdAt author { login } body } }
  timelineItems(last: 60, itemTypes: [CLOSED_EVENT, REOPENED_EVENT, CROSS_REFERENCED_EVENT,
      SUB_ISSUE_ADDED_EVENT, SUB_ISSUE_REMOVED_EVENT, PARENT_ISSUE_ADDED_EVENT,
      PARENT_ISSUE_REMOVED_EVENT, PROJECT_V2_ITEM_STATUS_CHANGED_EVENT, RENAMED_TITLE_EVENT]) {
    nodes {
      __typename
      ... on ClosedEvent { createdAt actor { login } }
      ... on ReopenedEvent { createdAt actor { login } }
      ... on RenamedTitleEvent { createdAt previousTitle currentTitle }
      ... on CrossReferencedEvent { createdAt willCloseTarget
        source { __typename ... on PullRequest { number title merged } ... on Issue { number title } } }
      ... on SubIssueAddedEvent { createdAt subIssue { number title } }
      ... on SubIssueRemovedEvent { createdAt subIssue { number title } }
      ... on ParentIssueAddedEvent { createdAt parent { number title } }
      ... on ParentIssueRemovedEvent { createdAt parent { number title } }
      ... on ProjectV2ItemStatusChangedEvent { createdAt status previousStatus }
    }
  }
  projectItems(first: 5) {
    nodes {
      project { title number url }
      fieldValues(first: 30) {
        nodes {
          ... on ProjectV2ItemFieldSingleSelectValue {
            name field { ... on ProjectV2SingleSelectField { name options { name } } }
          }
        }
      }
    }
  }
"""

SEARCH_ISSUES = ("query($q:String!,$after:String){search(query:$q,type:ISSUE,first:25,after:$after)"
                 "{pageInfo{hasNextPage endCursor} nodes{... on Issue{%s}}}}" % ISSUE_FIELDS)

SEARCH_PRS = """
query($q:String!,$after:String){
  search(query:$q,type:ISSUE,first:50,after:$after){
    pageInfo{hasNextPage endCursor}
    nodes{... on PullRequest{
      number title url state isDraft merged mergedAt createdAt updatedAt baseRefName headRefName body
      repository{nameWithOwner}
      reviewDecision
      closingIssuesReferences(first:10){nodes{number title}}
    }}
  }
}
"""


def gh_graphql(query: str, **variables):
    cmd = ["gh", "api", "graphql", "-f", f"query={query}"]
    for k, v in variables.items():
        if v is not None:
            cmd += ["-f", f"{k}={v}"]
    p = subprocess.run(cmd, capture_output=True, text=True)
    if p.returncode != 0:
        sys.stderr.write(p.stderr)
        raise SystemExit(f"gh api graphql failed ({variables})")
    data = json.loads(p.stdout)
    if data.get("errors"):
        sys.stderr.write(json.dumps(data["errors"], ensure_ascii=False, indent=1) + "\n")
    return data["data"]


def search_all(query: str, q: str) -> list[dict]:
    out, after = [], None
    while True:
        d = gh_graphql(query, q=q, after=after)["search"]
        out += [n for n in d["nodes"] if n]
        if not d["pageInfo"]["hasNextPage"]:
            return out
        after = d["pageInfo"]["endCursor"]


def fetch_by_number(repo: str, numbers: list[int]) -> list[dict]:
    owner, name = repo.split("/")
    out = []
    for i in range(0, len(numbers), 10):
        aliases = " ".join(f"i{n}: issue(number:{n}) {{ {ISSUE_FIELDS} }}" for n in numbers[i:i + 10])
        d = gh_graphql('query{repository(owner:"%s",name:"%s"){%s}}' % (owner, name, aliases))["repository"]
        out += [v for v in d.values() if v]
    return out


def status_of(issue: dict) -> dict | None:
    """Projects v2 single-select named Status; options kept in board order, untranslated."""
    for item in issue.get("projectItems", {}).get("nodes", []):
        for fv in item.get("fieldValues", {}).get("nodes", []):
            f = fv.get("field") or {}
            if f.get("name", "").lower() == "status":
                options = [o["name"] for o in f.get("options", [])]
                name = fv.get("name")
                return {"project": item["project"]["title"], "name": name,
                        "position": options.index(name) if name in options else None, "options": options}
    return None


def slim_event(ev: dict) -> dict:
    t = ev["__typename"]
    e = {"at": ev.get("createdAt"), "kind": t}
    if t == "CrossReferencedEvent":
        s = ev.get("source") or {}
        e["source"] = {"kind": s.get("__typename"), "number": s.get("number"), "title": s.get("title"),
                       "merged": s.get("merged"), "will_close": ev.get("willCloseTarget")}
    elif t in ("SubIssueAddedEvent", "SubIssueRemovedEvent"):
        e["issue"] = ev.get("subIssue")
    elif t in ("ParentIssueAddedEvent", "ParentIssueRemovedEvent"):
        e["issue"] = ev.get("parent")
    elif t == "ProjectV2ItemStatusChangedEvent":
        e["from"], e["to"] = ev.get("previousStatus"), ev.get("status")
    elif t == "RenamedTitleEvent":
        e["from"], e["to"] = ev.get("previousTitle"), ev.get("currentTitle")
    return e


def slim(issue: dict) -> dict:
    return {
        "repo": issue["repository"]["nameWithOwner"],
        "number": issue["number"],
        "title": issue["title"],
        "url": issue["url"],
        "state": issue["state"],
        "type": (issue.get("issueType") or {}).get("name"),
        "milestone": (issue.get("milestone") or {}).get("title"),
        "labels": [l["name"] for l in issue.get("labels", {}).get("nodes", [])],
        "assignees": [a["login"] for a in issue.get("assignees", {}).get("nodes", [])],
        "created_at": issue["createdAt"],
        "body_last_edited_at": issue.get("lastEditedAt"),
        "updated_at": issue["updatedAt"],
        "closed_at": issue.get("closedAt"),
        "status": status_of(issue),
        "parent": issue.get("parent"),
        "children_summary": issue.get("subIssuesSummary"),
        "children": [
            {"number": c["number"], "title": c["title"], "url": c["url"], "state": c["state"],
             "closed_at": c.get("closedAt"), "type": (c.get("issueType") or {}).get("name"),
             "children_summary": c.get("subIssuesSummary"),
             "assignees": [a["login"] for a in c.get("assignees", {}).get("nodes", [])]}
            for c in issue.get("subIssues", {}).get("nodes", [])
        ],
        "pull_requests": [
            {k: pr.get(k) for k in ("number", "title", "url", "state", "isDraft", "merged", "mergedAt",
                                    "baseRefName", "headRefName", "body")}
            for pr in issue.get("closedByPullRequestsReferences", {}).get("nodes", [])
        ],
        "last_comments": [
            {"at": c["createdAt"], "by": (c.get("author") or {}).get("login"), "body": c["body"]}
            for c in issue.get("comments", {}).get("nodes", [])
        ],
        "events": [slim_event(e) for e in issue.get("timelineItems", {}).get("nodes", []) if e],
        "body": issue.get("body") or "",
    }


def slim_pr(pr: dict) -> dict:
    return {
        "repo": pr["repository"]["nameWithOwner"],
        **{k: pr.get(k) for k in ("number", "title", "url", "state", "isDraft", "merged", "mergedAt", "createdAt",
                                  "updatedAt", "baseRefName", "headRefName", "reviewDecision", "body")},
        "closes": [c["number"] for c in pr.get("closingIssuesReferences", {}).get("nodes", [])],
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--repo")
    ap.add_argument("--merged-days", type=int, default=90)
    ap.add_argument("--out", default=str(CACHE / "github.json"))
    args = ap.parse_args()

    login = gh_graphql("query{viewer{login}}")["viewer"]["login"]
    scope = f" repo:{args.repo}" if args.repo else ""

    assigned = [slim(i) for i in search_all(SEARCH_ISSUES, f"is:issue is:open assignee:{login}{scope}")]
    tree = {(i["repo"], i["number"]): i for i in assigned}

    def expand(frontier, pick):
        while frontier:
            missing: dict[str, set[int]] = {}
            for i in frontier:
                for n in pick(i):
                    if (i["repo"], n) not in tree:
                        missing.setdefault(i["repo"], set()).add(n)
            frontier = []
            for repo, nums in missing.items():
                for raw in fetch_by_number(repo, sorted(nums)):
                    s = slim(raw)
                    tree[(s["repo"], s["number"])] = s
                    frontier.append(s)

    # Down: every child of an assigned issue, including closed ones and other people's.
    expand(list(assigned), lambda i: [c["number"] for c in i["children"]])
    # Up: the parent chain of every issue in the tree, so a Task always has its Epic.
    expand(list(tree.values()), lambda i: [i["parent"]["number"]] if i.get("parent") else [])

    since = (datetime.now(timezone.utc) - timedelta(days=args.merged_days)).date().isoformat()
    open_prs = [slim_pr(p) for p in search_all(SEARCH_PRS, f"is:pr is:open author:{login}{scope}")]
    merged_prs = [slim_pr(p) for p in search_all(SEARCH_PRS, f"is:pr is:merged author:{login} merged:>={since}{scope}")]

    payload = {
        "source": "github",
        "generated_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "login": login,
        "assigned": sorted([i["repo"] + "#" + str(i["number"]) for i in assigned]),
        "issues": sorted(tree.values(), key=lambda i: (i["repo"], i["number"])),
        "open_pull_requests": open_prs,
        "merged_pull_requests": merged_prs,
    }
    out = Path(args.out).expanduser()
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(payload, ensure_ascii=False, indent=1))

    roots = [i for i in payload["issues"] if not i.get("parent")]
    print(f"{login}: assigned {len(assigned)}, in tree {len(payload['issues'])}, open PRs {len(open_prs)}, "
          f"merged PRs since {since}: {len(merged_prs)}")
    for r in sorted(roots, key=lambda i: (i["type"] or "~", i["number"])):
        cs = r["children_summary"] or {}
        print(f"  [{r['type'] or 'no type'}] #{r['number']} {r['title']}  "
              f"children {cs.get('completed', 0)}/{cs.get('total', 0)}  status {(r.get('status') or {}).get('name')}")
    print(f"written: {out}")


if __name__ == "__main__":
    main()
