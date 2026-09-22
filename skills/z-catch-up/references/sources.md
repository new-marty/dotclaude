# Where the material comes from

Read this when the digest looks wrong, when a field needs explaining, or when the work
lives somewhere other than GitHub. Everything below was checked against gh 2.100.0 on
2026-09-22.

## The shape everything is normalized into

`scripts/collect.py` joins three sources into one unit of work, keyed on the issue number.
A tracker that can fill these fields can be plugged in without touching `SKILL.md`.

| Field | Meaning |
| --- | --- |
| `issue`, `title`, `url` | the item itself |
| `status` | the tracker's own words. Never translated into a shared vocabulary |
| `epic` | the parent item, if there is one |
| `prs` | the changes attached to it, with review state, checks, merge state |
| `worktrees` | where the work sits on this machine, with its last three commits |
| `hand` | `mine` / `theirs` / `idle`, worked out from the fields above |

Status names are deliberately not mapped onto a common enum. `In Progress`, `In progress`
and `作業中` are the same stage and no mapping survives contact with a second project.
What is comparable across trackers is the *order* the tracker itself declares, and every
one of them declares it: GitHub Projects returns the options in board order
(`gh project field-list <n> --owner <org>`), Linear has `state.position`, Jira has the
workflow. Take position, not name.

## GitHub

Three GraphQL searches and one REST call, in `collect.py`:

| What | Query |
| --- | --- |
| Assigned issues | `search(query: "assignee:@me state:open type:issue", type: ISSUE)` |
| My pull requests | `search(query: "author:@me state:open type:pr", type: ISSUE)` |
| Reviews I owe | `search(query: "review-requested:@me state:open type:pr", type: ISSUE)` |
| Notifications | `gh api notifications --paginate` |

Worth knowing:

- One search returns the Project status, the parent issue and the sub-issue count for all
  of them at once. Per-issue calls are not needed and are much slower.
- `type: ISSUE` covers pull requests too — a pull request is an issue with extra fields.
  The inline fragment decides which one you get back.
- `mergeStateStatus` distinguishes the two cases that matter: `DIRTY` is a real conflict
  and is the author's to fix, `BEHIND` only means the base moved and stops no review.
- `reviewDecision` is `null` where branch protection requires no review. That is not "no
  reviewer yet"; it means the change can merge as it stands.
- A review thread counts as unanswered only when it is neither resolved nor outdated, and
  was opened by someone else. Own comments would otherwise read as feedback to act on.
- Epics are fetched separately, once, with aliased fields — `fetch_epics()`. Sub-issues
  are the native relationship (`parent` / `subIssues`), not a label convention.

Scopes needed on the token: `repo`, `read:org`, `project`.

## The local side

Discovery walks a few common parents (`--roots`) looking for a directory named after the
repository. For each one found, `git worktree list --porcelain`, then per worktree: the
last three commits, the file stat of the newest, uncommitted file count, and unpushed
commit count.

The last commits are the part that matters most on a short gap. Developers resuming an
interrupted task were twice as likely to succeed with an automated cue as with their own
notes, and strongly preferred seeing their activity in time order as real code over any
aggregated summary (Parnin & DeLine, CHI 2010).

Nothing is ever written inside a repository. The payload goes to
`~/.claude/cache/z-catch-up/latest.json`, and the previous run's fingerprints sit beside it
in `last-run.json` — that file is what makes "nothing moved while you were away" a fact
rather than a guess.

## Adding another tracker

Write a sibling of this section describing how to fill the table at the top, and how that
tracker declares the order of its states. Both Linear and Atlassian publish first-party MCP
servers, so a second collector script may not be needed at all — the mapping may be enough.

`SKILL.md` names no tracker anywhere. Keep it that way: the briefing does not change when
the source does.
