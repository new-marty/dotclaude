---
name: z-catch-up
description: Rebuild the whole picture of the work assigned to you after a gap — what each thread is for, how far it has got, and whose move it is now. Use it whenever the intent is to take stock rather than to start working — "where am I", "what was I doing", "catch me up", "what is the state of everything", 「今どうなってる?」「何やってたっけ」「状況整理して」「久しぶりに戻ってきた」「全体を把握したい」「今の状況をまとめて」. Use it as well when someone comes back after days away and does not say what they want. Not for choosing and starting a task (`z-start-task`), not for filing work (`z-write-task`).
argument-hint: "[repository or issue number](optional)"
allowed-tools: Bash(gh *), Bash(git *), Bash(python3 *), Read, Glob, Grep, Artifact
---

Give someone their own situation back. They have several threads running at once and have
been away long enough to lose the thread of all of them.

The reader to write for is a manager with no time: they read this once and must understand
everything, without opening a single issue. Grasping the whole picture is the deliverable.
Deciding what to work on is not — that is `z-start-task`, and this skill stops at the door.

Write in the language the user is writing in.

## Steps

### 1. Collect

```sh
python3 ${CLAUDE_SKILL_DIR}/scripts/collect.py
```

Takes about 15 seconds. Prints a digest and writes the whole payload to
`~/.claude/cache/z-catch-up/latest.json` — never inside a repository. When the user later
asks about one item, read that file rather than collecting again.

`$ARGUMENTS` narrows the briefing to one repository or one issue. It does not narrow the
collection: the point is the whole picture, and a thread left out is a thread forgotten.

The digest carries `hand` on every thread, already worked out — see "Whose move it is".
For where the fields come from and how to add another tracker, read `references/sources.md`.

### 2. Find out what the work is for

The tracker says what each item is, never why it exists. Without the why, the briefing is a
list of ticket titles and the reader learns nothing.

Look for planning documents — `docs/plans/`, `docs/specs/`, `ROADMAP.md`, a `README.md` in
a plan directory. Read the ones that cover the live threads. They carry two things worth
more than any field: the purpose, and the order the work was meant to go in.

That order is how you tell a deliberate Backlog from a forgotten one. An item sitting at
the bottom because the plan puts it last is not neglect, and saying so spares the reader a
false alarm.

Where no such document exists, fall back to the epic's own body, then the pull request
descriptions. Say nothing about purpose rather than inventing it.

### 3. Write the briefing

Conclusion first, evidence after — the reader may stop after the first paragraph, so the
first paragraph has to survive alone.

```
<Three or four sentences: how many streams of work are running, what they are for,
 how much is moving, and how much of it needs this person's own hands.>

▍<stream name> — <what it is for, one line>
  現在地  <where it has got to, against the plan's own order>
  あなた  <only what this person can finish alone; "なし" is a complete answer>
  待ち    <count, and nothing else unless something is genuinely wrong>

▍<next stream …>   ← three or four streams at most

<Anything that needs a decision. Two items at most. Nothing invented to fill the space.>
```

Budget: the whole thing fits in a terminal without scrolling. Three lines per stream. When
there are more streams than fit, group them and say how many were grouped.

Shape it by how long the gap was — `since_last_run.last_seen_days_ago` in the digest:

- **A week or more, or the first run** — lead with purpose. They have lost the why, not the
  where. Keep the streams, drop the commit-level detail.
- **A day or two** — lead with the last thing they touched, in time order, with the actual
  commits and files from `recent_commits` and `last_commit_stat`, and the path to the
  worktree. They still hold the context; give them the handle, not the story. This is what
  developers asked to resume an interrupted task preferred over any summary.

Whichever shape, close with what changed while they were away (`since_last_run`). "Nothing
moved" is worth saying — it answers a question they would otherwise ask.

## Whose move it is

The single rule that decides whether this briefing is worth reading:

**Never present work whose completion depends on someone else as something for this person
to do.** A pull request nobody has reviewed is not a blockage to clear. It has left their
hands. Telling them to "get it merged" asks for something they cannot deliver, and it is
the fastest way to make them close the report.

The digest already splits this:

- `hand: "mine"` — they can finish it alone: a conflict, a failing check, an unanswered
  review comment, a draft never opened, a branch with no pull request, uncommitted work.
  `mine_because` says which. These go in the briefing, with what is left to do.
- `hand: "theirs"` — open and waiting on other people. **Show the count. Nothing else.**
  Being behind the base branch counts as theirs: it does not stop a review.
- `hand: "idle"` — no branch, no pull request. Part of the picture, not of the day.

Chasing a reviewer is a decision, not a task. If a wait has gone long enough to be worth
raising, put it under the decisions at the end — never in a list of work.

When nothing at all is in their hands, say so plainly, name one candidate from the waiting
items with a one-line reason, and stop. Choosing is `/z-start-task`'s job; do not open the
issue, do not compare options, do not start.

## When the terminal is not enough

Default to the terminal. Reach for an Artifact when the shape itself is the message —
several streams at once, or a board of stages where the pile-up is the point. Read
`artifact-design` first. Terminal briefing first, then offer the board in one line.

## Do not

- Do not open a worktree, switch a branch, or change any state. This skill only reads.
- Do not rewrite an issue's status to match reality. Point out the mismatch in one line and
  leave it.
- Do not list stale worktrees or old branches as things to clean up. They were not asked
  about.
- Do not pad a stream that has nothing happening in it. "動きなし" is the whole entry.
