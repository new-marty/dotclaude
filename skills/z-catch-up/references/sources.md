# Sources

The procedure in `SKILL.md` does not depend on any one tracker. A collector gathers facts
from one place and writes them as JSON; the skill reads whatever collectors ran. This file
lists the collectors that exist, the shape they share, and what to add when the work moves
to another tool.

## GitHub: `scripts/github.py`

```
python3 ~/.claude/skills/z-catch-up/scripts/github.py [--repo OWNER/NAME] [--merged-days N] [--out PATH]
```

Writes `~/.claude/cache/z-catch-up/github.json` (never inside a repository) and prints a
digest of the root issues. About fifteen seconds for forty issues.

What it reads, all through `gh api graphql`:

- every open issue assigned to the logged-in user, then the whole subtree below each one
  (children of children, including closed ones and ones assigned to other people) and the
  parent chain above each one, so an assigned Task always arrives with its Epic;
- for each issue: type (`issueType`, the organisation's registered names), parent,
  sub-issue summary, milestone, labels, assignees, body, created and last-edited time,
  the Projects v2 field named Status with its options in board order, the pull requests
  that close it (with descriptions), the last three comments, and the last sixty timeline
  events of the kinds that mean something moved (closed, reopened, cross-referenced,
  sub-issue or parent added or removed, status changed, title renamed);
- the user's open pull requests, and the ones merged in the last `--merged-days` days
  (default 90), each with its description and the issues it closes.

Status names are kept as the project spells them ("In progress" and "In Progress" are
different projects, not different states). The option list is included so the skill can
place a status in board order without translating it.

Projects v2 fields need the `project` scope: `gh auth refresh -s project` when every
status comes back empty.

## Plan documents

Issue bodies in this organisation link to plan documents by path (`docs/plans/...`). Read
them from the default branch of the repository, fetched fresh:

```
git -C <checkout> fetch -q origin <default-branch>
git -C <checkout> show origin/<default-branch>:docs/plans/.../README.md
```

A local checkout can be weeks behind the branch; do not read the working tree.

## The shape a collector produces

Top level:

```
{
  "source": "github",
  "generated_at": "...",
  "login": "...",
  "assigned": ["owner/repo#123", ...],
  "issues": [ ... ],
  "open_pull_requests": [ ... ],
  "merged_pull_requests": [ ... ]
}
```

Each entry in `issues`:

| field | meaning |
| --- | --- |
| `repo`, `number`, `title`, `url`, `state` | identity; `state` is OPEN or CLOSED |
| `type` | the tracker's own type name, or null |
| `status` | `{project, name, position, options}` from the board, or null |
| `parent` | `{number, title, url}` or null |
| `children` | `[{number, title, url, state, closed_at, type, children_summary, assignees}]` |
| `children_summary` | `{total, completed}` |
| `pull_requests` | the pull requests that close this issue, with `body` |
| `last_comments` | `[{at, by, body}]`, newest last |
| `events` | `[{at, kind, ...}]`, oldest first; used for "what moved since" |
| `created_at`, `body_last_edited_at`, `updated_at`, `closed_at` | timestamps |
| `body` | the full text |

Pull requests: `repo`, `number`, `title`, `url`, `state`, `isDraft`, `merged`, `mergedAt`,
`createdAt`, `updatedAt`, `baseRefName`, `headRefName`, `reviewDecision`, `body`,
`closes` (issue numbers).

## Adding another tracker

Write `scripts/<tracker>.py` that produces the same top-level shape. Map:

- the tracker's hierarchy to `parent` and `children` (Linear: project and parent issue;
  Jira: Epic link and subtasks);
- its workflow state to `status` with `options` in workflow order (Linear:
  `workflowState.position`; Jira: the workflow's status order);
- its type to `type` (Linear has no types; use labels or leave null);
- its change history to `events` with the same `kind` names where the meaning matches.

Do not translate state names into a common vocabulary. The skill uses `position` to order
rows and `name` to label them, and both must be what the person sees in the tool.

When there is no tracker at all, the trail is `git log --author`, branch names, and
`git worktree list`. Emit those as `merged_pull_requests` (one entry per commit range with
the commit message as `body`) and an empty `issues` list; the skill then works from rung 3
of the ladder in `SKILL.md`.
