#!/usr/bin/env python3
"""Collect the raw material for a re-entry briefing and print it as JSON.

Everything here is fact gathering. Judgement — what to do next, what is waiting on
whom — belongs in SKILL.md, because it depends on what the person asked for.

Nothing about any particular repository is hard-coded. Status names, issue types and
labels are read back from the API as they are, so a project that renames "In Review"
or adds a column keeps working.

Usage:
    collect.py [--days N] [--roots DIR[,DIR...]] [--no-local] [--no-diff] [--out PATH]

Prints a digest; writes the whole payload to --out (default
~/.claude/cache/z-catch-up/latest.json). Nothing is ever written inside a repository.

--days N    a worktree or item untouched for longer than N days is marked stale
            (default 30). Nothing is filtered out; the flag only sets the mark.
--roots     where to look for local checkouts (default: a few common parents)
--no-local  skip the git side entirely (faster, GitHub only)
--no-diff   do not read or write the last-run file
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path

CACHE = Path.home() / ".claude" / "cache" / "z-catch-up"
DEFAULT_ROOTS = ["~/work", "~/dev", "~/src", "~/ghq", "~/work", "~/Projects", "~/repos", "~/ghq/github.com"]
NOW = datetime.now(timezone.utc)

ISSUE_QUERY = """
query($q: String!) {
  search(query: $q, type: ISSUE, first: 100) {
    nodes {
      ... on Issue {
        number title url updatedAt createdAt
        repository { nameWithOwner }
        issueType { name }
        labels(first: 10) { nodes { name } }
        parent { number title url }
        subIssuesSummary { total completed }
        comments(last: 2) { nodes { createdAt author { login } body } }
        projectItems(first: 5) {
          nodes {
            project { title number }
            fieldValues(first: 30) {
              nodes {
                ... on ProjectV2ItemFieldSingleSelectValue {
                  name field { ... on ProjectV2SingleSelectField { name } }
                }
              }
            }
          }
        }
      }
    }
  }
}
"""

PR_QUERY = """
query($q: String!) {
  search(query: $q, type: ISSUE, first: 60) {
    nodes {
      ... on PullRequest {
        number title url updatedAt createdAt isDraft headRefName baseRefName
        mergeable mergeStateStatus reviewDecision
        author { login }
        repository { nameWithOwner }
        commits(last: 1) { nodes { commit { committedDate statusCheckRollup { state } } } }
        reviewThreads(first: 60) {
          nodes {
            isResolved isOutdated
            comments(first: 1) { nodes { author { login } createdAt body path } }
          }
        }
        reviews(last: 10) { nodes { author { login } state submittedAt } }
        comments(last: 3) { nodes { author { login } createdAt body } }
        closingIssuesReferences(first: 5) { nodes { number title } }
      }
    }
  }
}
"""


def run(cmd: list[str], timeout: int = 90) -> tuple[int, str]:
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
        return p.returncode, (p.stdout if p.returncode == 0 else p.stdout + p.stderr)
    except (subprocess.TimeoutExpired, FileNotFoundError) as exc:
        return 1, str(exc)


def gh_graphql(query: str, q: str) -> list[dict]:
    code, out = run(["gh", "api", "graphql", "-F", f"q={q}", "-f", f"query={query}"])
    if code != 0:
        return [{"_error": out[:400]}]
    try:
        data = json.loads(out)
    except json.JSONDecodeError:
        return [{"_error": out[:400]}]
    if "errors" in data:
        return [{"_error": json.dumps(data["errors"])[:400]}]
    return [n for n in data.get("data", {}).get("search", {}).get("nodes", []) if n]


def days_since(ts: str | None) -> float | None:
    if not ts:
        return None
    try:
        return round((NOW - datetime.fromisoformat(ts.replace("Z", "+00:00"))).total_seconds() / 86400, 1)
    except ValueError:
        return None


def project_status(item: dict) -> list[dict]:
    """Every single-select field on every project the item sits in, names as stored."""
    out = []
    for pi in item.get("projectItems", {}).get("nodes", []) or []:
        proj = (pi.get("project") or {}).get("title")
        fields = {}
        for fv in pi.get("fieldValues", {}).get("nodes", []) or []:
            name = (fv.get("field") or {}).get("name")
            if name:
                fields[name] = fv.get("name")
        if proj:
            out.append({"project": proj, "fields": fields})
    return out


def shape_issue(n: dict, stale_days: int) -> dict:
    last = (n.get("comments", {}).get("nodes") or [])
    return {
        "kind": "issue",
        "key": f"{n['repository']['nameWithOwner']}#{n['number']}",
        "repo": n["repository"]["nameWithOwner"],
        "number": n["number"],
        "title": n["title"],
        "url": n["url"],
        "type": (n.get("issueType") or {}).get("name"),
        "labels": [l["name"] for l in n.get("labels", {}).get("nodes", [])],
        "parent": n.get("parent"),
        "sub_issues": n.get("subIssuesSummary"),
        "projects": project_status(n),
        "updated_days_ago": days_since(n.get("updatedAt")),
        "last_comment": (
            {
                "author": (last[-1].get("author") or {}).get("login"),
                "days_ago": days_since(last[-1].get("createdAt")),
                "excerpt": (last[-1].get("body") or "")[:300],
            }
            if last
            else None
        ),
        "stale": (days_since(n.get("updatedAt")) or 0) > stale_days,
    }


def shape_pr(n: dict, me: str, stale_days: int) -> dict:
    threads = n.get("reviewThreads", {}).get("nodes", []) or []
    open_threads = [t for t in threads if not t.get("isResolved") and not t.get("isOutdated")]
    others = []
    for t in open_threads:
        c = (t.get("comments", {}).get("nodes") or [{}])[0]
        login = (c.get("author") or {}).get("login")
        if login and login != me:
            others.append({"author": login, "path": c.get("path"), "excerpt": (c.get("body") or "")[:200]})
    commits = n.get("commits", {}).get("nodes") or []
    rollup = ((commits[0].get("commit") if commits else {}) or {}).get("statusCheckRollup") or {}
    reviews = [
        {"author": (r.get("author") or {}).get("login"), "state": r.get("state"), "days_ago": days_since(r.get("submittedAt"))}
        for r in n.get("reviews", {}).get("nodes", []) or []
        if (r.get("author") or {}).get("login") != me
    ]
    return {
        "kind": "pr",
        "key": f"{n['repository']['nameWithOwner']}#{n['number']}",
        "repo": n["repository"]["nameWithOwner"],
        "number": n["number"],
        "title": n["title"],
        "url": n["url"],
        "author": (n.get("author") or {}).get("login"),
        "branch": n.get("headRefName"),
        "base": n.get("baseRefName"),
        "is_draft": n.get("isDraft"),
        "review_decision": n.get("reviewDecision"),
        "mergeable": n.get("mergeable"),
        "merge_state": n.get("mergeStateStatus"),
        "checks": rollup.get("state"),
        "reviews_by_others": reviews,
        "open_threads_from_others": others,
        "closes_issues": [i["number"] for i in n.get("closingIssuesReferences", {}).get("nodes", [])],
        "updated_days_ago": days_since(n.get("updatedAt")),
        "stale": (days_since(n.get("updatedAt")) or 0) > stale_days,
    }


def fetch_epics(parents: dict[str, set[int]]) -> list[dict]:
    """Where each parent issue stands, and what is left under it.

    The person asked to see the epic, not only the task in hand: a task that looks
    finished can still be the third of seven, and that changes what comes next.
    """
    out = []
    for repo, numbers in parents.items():
        if not numbers:
            continue
        owner, name = repo.split("/", 1)
        fields = " ".join(
            f'e{n}: issue(number: {n}) {{ number title url state subIssuesSummary {{ total completed }} '
            f"subIssues(first: 40) {{ nodes {{ number title state assignees(first: 3) {{ nodes {{ login }} }} }} }} }}"
            for n in sorted(numbers)
        )
        query = f'query {{ repository(owner: "{owner}", name: "{name}") {{ {fields} }} }}'
        code, raw = run(["gh", "api", "graphql", "-f", f"query={query}"])
        if code != 0:
            continue
        try:
            data = json.loads(raw).get("data", {}).get("repository") or {}
        except json.JSONDecodeError:
            continue
        for value in data.values():
            if not value:
                continue
            subs = value.get("subIssues", {}).get("nodes", []) or []
            out.append(
                {
                    "repo": repo,
                    "number": value["number"],
                    "title": value["title"],
                    "url": value["url"],
                    "state": value["state"],
                    "progress": value.get("subIssuesSummary"),
                    "open_children": [
                        {"number": s["number"], "title": s["title"], "assignees": [a["login"] for a in s["assignees"]["nodes"]]}
                        for s in subs
                        if s["state"] == "OPEN"
                    ],
                }
            )
    return out


def notifications() -> dict:
    code, out = run(["gh", "api", "notifications", "--paginate"])
    if code != 0:
        return {"error": out[:200]}
    try:
        items = json.loads(out)
    except json.JSONDecodeError:
        return {"error": "unparsable"}
    by_reason: dict[str, int] = {}
    direct = []
    for it in items:
        reason = it.get("reason", "?")
        by_reason[reason] = by_reason.get(reason, 0) + 1
        if reason in {"review_requested", "mention", "team_mention", "assign"}:
            direct.append(
                {
                    "reason": reason,
                    "repo": it.get("repository", {}).get("full_name"),
                    "type": it.get("subject", {}).get("type"),
                    "title": it.get("subject", {}).get("title"),
                    "days_ago": days_since(it.get("updated_at")),
                }
            )
    return {"total": len(items), "by_reason": by_reason, "addressed_to_me": direct[:20]}


def find_repo(name_with_owner: str, roots: list[str]) -> str | None:
    repo = name_with_owner.split("/")[-1]
    patterns = [repo, f"*/{repo}", f"*/*/{repo}"]
    for root in roots:
        base = Path(os.path.expanduser(root))
        if not base.is_dir():
            continue
        for pattern in patterns:
            for cand in base.glob(pattern):
                if (cand / ".git").exists():
                    return str(cand)
    return None


def git(path: str, *args: str) -> str:
    code, out = run(["git", "-C", path, *args], timeout=30)
    return out.strip() if code == 0 else ""


def worktrees(repo_path: str, stale_days: int) -> list[dict]:
    raw = git(repo_path, "worktree", "list", "--porcelain")
    out, cur = [], {}
    for line in raw.splitlines() + [""]:
        if line.startswith("worktree "):
            cur = {"path": line.split(" ", 1)[1]}
        elif line.startswith("branch "):
            cur["branch"] = line.split("refs/heads/", 1)[-1]
        elif line.strip() == "" and cur:
            out.append(cur)
            cur = {}
    result = []
    for w in out:
        p = w["path"]
        if not Path(p).is_dir():
            continue
        recent = [l for l in git(p, "log", "-3", "--format=%cI\t%s").splitlines() if l]
        last = recent[0] if recent else ""
        date, _, subject = last.partition("\t")
        dirty = [l for l in git(p, "status", "--porcelain").splitlines() if l]
        ahead = git(p, "rev-list", "--count", "@{u}..HEAD")
        result.append(
            {
                "path": p,
                "branch": w.get("branch"),
                "last_commit_days_ago": days_since(date) if date else None,
                "last_commit": subject[:120],
                "recent_commits": [
                    {"days_ago": days_since(l.split("\t")[0]), "subject": l.split("\t")[-1][:100]} for l in recent
                ],
                "last_commit_stat": [l.strip()[:90] for l in git(p, "log", "-1", "--stat", "--format=").splitlines() if l.strip()][:6],
                "dirty_files": len(dirty),
                "dirty_sample": [l.strip()[:80] for l in dirty[:5]],
                "unpushed_commits": int(ahead) if ahead.isdigit() else None,
                "stale": (days_since(date) or 0) > stale_days if date else None,
            }
        )
    return result


def issue_numbers_in(text: str) -> set[int]:
    """Issue numbers a branch name or a PR title refers to. Three digits or more,
    because a two-digit run in a branch name is far more often a date than a number."""
    import re

    return {int(m) for m in re.findall(r"(?<!\d)(\d{3,})(?!\d)", text or "")}


def build_threads(issues: list[dict], prs: list[dict], local: list[dict]) -> tuple[list[dict], list[dict], dict]:
    """Join issue, pull request and worktree into one unit of work.

    The link is the issue number: GitHub's own link (closingIssuesReferences) first,
    then the number written into the branch name or the title, which is how most
    repositories tie the three together in practice.
    """
    by_number: dict[tuple[str, int], dict] = {}
    for i in issues:
        by_number[(i["repo"], i["number"])] = {
            "issue": {k: i[k] for k in ("key", "repo", "number", "title", "url", "type", "updated_days_ago", "last_comment")},
            "status": (i.get("projects") or [{}])[0].get("fields", {}).get("Status"),
            "epic": i.get("parent"),
            "sub_issues": i.get("sub_issues") if (i.get("sub_issues") or {}).get("total") else None,
            "prs": [],
            "worktrees": [],
            "signals": [],
        }

    loose_prs = []
    for p in prs:
        targets = set(p.get("closes_issues") or []) | issue_numbers_in(p.get("branch", "")) | issue_numbers_in(p["title"])
        hit = [by_number[(p["repo"], n)] for n in targets if (p["repo"], n) in by_number]
        if hit:
            for t in hit[:1]:
                t["prs"].append(p)
        else:
            loose_prs.append(p)

    other_worktrees: list[dict] = []
    for repo in local:
        for w in repo["worktrees"]:
            branch = w.get("branch") or ""
            targets = issue_numbers_in(branch)
            hit = [by_number[(repo["repo"], n)] for n in targets if (repo["repo"], n) in by_number]
            if hit:
                hit[0]["worktrees"].append(w)
            elif w["dirty_files"] or (w["unpushed_commits"] or 0) > 0:
                other_worktrees.append({"repo": repo["repo"], **w})

    for t in by_number.values():
        sig = t["signals"]
        for p in t["prs"]:
            tag = f"PR#{p['number']}"
            if p["is_draft"]:
                sig.append(f"{tag} draft")
            if p["open_threads_from_others"]:
                sig.append(f"{tag} unresolved comments from others: {len(p['open_threads_from_others'])}")
            if p["review_decision"] == "CHANGES_REQUESTED":
                sig.append(f"{tag} changes requested")
            if p["checks"] in {"FAILURE", "ERROR"}:
                sig.append(f"{tag} checks {p['checks']}")
            if p["review_decision"] == "REVIEW_REQUIRED" and not p["reviews_by_others"]:
                sig.append(f"{tag} no review yet, open {p['updated_days_ago']}d")
            if p["review_decision"] == "APPROVED":
                sig.append(f"{tag} approved, not merged")
            if p["merge_state"] in {"DIRTY", "BEHIND", "BLOCKED"}:
                sig.append(f"{tag} merge state {p['merge_state']}")
        for w in t["worktrees"]:
            if w["dirty_files"]:
                sig.append(f"worktree dirty: {w['dirty_files']} files")
            if (w["unpushed_commits"] or 0) > 0:
                sig.append(f"worktree unpushed: {w['unpushed_commits']} commits")
            if not t["prs"] and w["last_commit_days_ago"] is not None:
                sig.append(f"branch has no PR, last commit {w['last_commit_days_ago']}d ago")

    for t in by_number.values():
        # Waiting on a person is not the same as being blocked. Only the conditions
        # that the person can clear alone count as theirs to act on; a review that has
        # not happened is someone else's move, and listing it as work to do is the one
        # thing that makes this report useless.
        mine: list[str] = []
        for p in t["prs"]:
            tag = f"PR#{p['number']}"
            if p["is_draft"]:
                mine.append(f"{tag} still a draft")
            if p["open_threads_from_others"]:
                mine.append(f"{tag} {len(p['open_threads_from_others'])} unanswered review comments")
            if p["review_decision"] == "CHANGES_REQUESTED":
                mine.append(f"{tag} changes requested")
            if p["checks"] in {"FAILURE", "ERROR"}:
                mine.append(f"{tag} checks failing")
            if p["merge_state"] == "DIRTY":
                mine.append(f"{tag} conflicts with the base branch")
        for w in t["worktrees"]:
            if w["dirty_files"]:
                mine.append(f"uncommitted work: {w['dirty_files']} files")
            if (w["unpushed_commits"] or 0) > 0:
                mine.append(f"unpushed commits: {w['unpushed_commits']}")
            if not t["prs"]:
                mine.append(f"branch with no pull request, last commit {w['last_commit_days_ago']}d ago")
        t["hand"] = "mine" if mine else ("theirs" if t["prs"] else "idle")
        t["mine_because"] = mine

    threads = [t for t in by_number.values() if t["prs"] or t["worktrees"]]
    parked = [
        {"key": t["issue"]["key"], "title": t["issue"]["title"], "status": t["status"], "epic": (t["epic"] or {}).get("number"), "updated_days_ago": t["issue"]["updated_days_ago"]}
        for t in by_number.values()
        if not (t["prs"] or t["worktrees"])
    ]
    extra = {"loose_prs": loose_prs, "other_dirty_worktrees": other_worktrees}
    return threads, parked, extra


def load_last_run() -> dict:
    f = CACHE / "last-run.json"
    if f.exists():
        try:
            return json.loads(f.read_text())
        except json.JSONDecodeError:
            return {}
    return {}


def save_last_run(items: list[dict]) -> None:
    CACHE.mkdir(parents=True, exist_ok=True)
    snapshot = {
        "at": NOW.isoformat(),
        "items": {
            i["key"]: {
                "status": (i.get("projects") or [{}])[0].get("fields", {}).get("Status") if i["kind"] == "issue" else i.get("review_decision"),
                "updated_days_ago": i.get("updated_days_ago"),
            }
            for i in items
        },
    }
    (CACHE / "last-run.json").write_text(json.dumps(snapshot, ensure_ascii=False, indent=1))


def diff_against(prev: dict, items: list[dict]) -> dict:
    if not prev:
        return {"first_run": True}
    prev_items = prev.get("items", {})
    gap_days = days_since(prev.get("at"))
    new, moved = [], []
    for i in items:
        key = i["key"]
        now_status = (i.get("projects") or [{}])[0].get("fields", {}).get("Status") if i["kind"] == "issue" else i.get("review_decision")
        if key not in prev_items:
            new.append({"key": key, "title": i["title"], "status": now_status})
        elif prev_items[key].get("status") != now_status:
            moved.append({"key": key, "title": i["title"], "from": prev_items[key].get("status"), "to": now_status})
    gone = [k for k in prev_items if k not in {i["key"] for i in items}]
    return {"last_seen_days_ago": gap_days, "new": new, "status_moved": moved, "closed_or_unassigned": gone}


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--days", type=int, default=30)
    ap.add_argument("--roots", default=",".join(DEFAULT_ROOTS))
    ap.add_argument("--no-local", action="store_true")
    ap.add_argument("--no-diff", action="store_true")
    ap.add_argument("--full", action="store_true", help="also keep the unjoined issue / PR / worktree lists in the file")
    ap.add_argument("--out", default=None, help="where the full payload is written (default ~/.claude/cache/z-catch-up/latest.json). Never inside a repository")
    ap.add_argument("--stdout", action="store_true", help="print the full payload instead of the digest")
    args = ap.parse_args()

    code, me = run(["gh", "api", "user", "--jq", ".login"])
    me = me.strip() if code == 0 else "@me"

    issues = [shape_issue(n, args.days) for n in gh_graphql(ISSUE_QUERY, "assignee:@me state:open type:issue") if "_error" not in n]
    mine = [shape_pr(n, me, args.days) for n in gh_graphql(PR_QUERY, "author:@me state:open type:pr") if "_error" not in n]
    owed = [shape_pr(n, me, args.days) for n in gh_graphql(PR_QUERY, "review-requested:@me state:open type:pr") if "_error" not in n]

    local = []
    if not args.no_local:
        roots = [r for r in args.roots.split(",") if r]
        for repo in sorted({i["repo"] for i in issues} | {p["repo"] for p in mine}):
            path = find_repo(repo, roots)
            if path:
                local.append({"repo": repo, "path": path, "worktrees": worktrees(path, args.days)})

    parents: dict[str, set[int]] = {}
    for i in issues:
        if i.get("parent"):
            parents.setdefault(i["repo"], set()).add(i["parent"]["number"])
    epics = fetch_epics(parents)

    threads, parked, extra = build_threads(issues, mine, local)
    payload = {
        "generated_at": NOW.isoformat(),
        "login": me,
        "stale_after_days": args.days,
        "counts": {
            "assigned_issues": len(issues),
            "my_open_prs": len(mine),
            "reviews_i_owe": len(owed),
            "worktrees": sum(len(r["worktrees"]) for r in local),
        },
        "epics": epics,
        "threads": threads,
        "parked_issues": parked,
        "reviews_i_owe": owed,
        "loose_prs": extra["loose_prs"],
        "other_dirty_worktrees": extra["other_dirty_worktrees"],
        "notifications": notifications(),
        "repos": [{"repo": r["repo"], "path": r["path"], "worktrees": len(r["worktrees"])} for r in local],
    }
    if args.full:
        payload["raw"] = {"issues": issues, "my_prs": mine, "local": local}
    if not args.no_diff:
        payload["since_last_run"] = diff_against(load_last_run(), issues + mine)
        save_last_run(issues + mine)

    CACHE.mkdir(parents=True, exist_ok=True)
    out = Path(os.path.expanduser(args.out)) if args.out else CACHE / "latest.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(payload, ensure_ascii=False, indent=1))

    if args.stdout:
        json.dump(payload, sys.stdout, ensure_ascii=False, indent=1)
        print()
        return

    # The digest is what the briefing is written from. Everything else stays in the
    # file, one read away, so a question like "where does it conflict?" costs a read
    # rather than another fourteen seconds of API calls.
    digest = {k: payload[k] for k in ("generated_at", "login", "counts", "epics", "parked_issues", "since_last_run")}
    digest["full_data"] = str(out)
    digest["threads"] = [
        {
            "issue": t["issue"]["key"],
            "title": t["issue"]["title"],
            "url": t["issue"]["url"],
            "status": t["status"],
            "epic": (t["epic"] or {}).get("number"),
            "hand": t["hand"],
            "mine_because": t["mine_because"],
            "prs": [
                {"number": p["number"], "title": p["title"], "days_open": p["updated_days_ago"], "review": p["review_decision"], "merge_state": p["merge_state"], "checks": p["checks"], "reviewers_responded": len(p["reviews_by_others"])}
                for p in t["prs"]
            ],
            "worktrees": [
                {"path": w["path"], "branch": w["branch"], "recent_commits": w.get("recent_commits"), "last_commit_stat": w.get("last_commit_stat"), "dirty_files": w["dirty_files"]}
                for w in t["worktrees"]
            ],
        }
        for t in threads
    ]
    digest["notifications"] = {k: payload["notifications"].get(k) for k in ("total", "by_reason")}
    digest["reviews_i_owe"] = [{"number": p["number"], "repo": p["repo"], "title": p["title"]} for p in owed]
    json.dump(digest, sys.stdout, ensure_ascii=False, indent=1)
    print()


if __name__ == "__main__":
    main()
