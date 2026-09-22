---
name: z-catch-up
description: Rebuild the situation after days away from a project, so that the next task is resumed with its purpose and its current premises in mind instead of by following its text. Produces one page per return - for each stream of related work, what it is for, what the finished pieces actually changed, what the next task is, and what has moved since that task was written. Use it whenever the intent is to come back to work - "catch me up", "where was I", "what am I working on", 「戻ってきた」「状況を整理して」「今どこまで進んでる?」「何やってたっけ」. Not for choosing between unrelated tasks, not for standup notes, and not for starting the work itself (`z-start-task`).
argument-hint: "[repository or project name] [extra instructions](optional)"
allowed-tools: Bash(python3 *), Bash(gh *), Bash(git *), Read, Glob, Grep
---

# Catch up

A task's text was written from what its author understood at the time. By the time it is
picked up, the tasks before it have been done, and doing them changed the understanding.
Resuming by following the text does work that no longer makes sense. This skill exists so
that the person judges, before touching the task, whether its premises still hold.

The page it produces is read by someone who has been away for days and wants to be ready
in one read. It answers, for each stream of related work:

1. what the stream is for,
2. what the finished pieces actually changed,
3. what the next task is, and
4. what has moved since that task's text was written.

Everything else on the page exists to support those four. Everything that does not is left
out.

## What the page is not

- Not the board restated. A list of numbers and status names tells the reader nothing they
  could not get from the tracker. Status names appear only as small labels beside a row,
  in the tracker's own spelling.
- Not a description of the code. The reader wants to know what a finished piece
  established or changed about the plan, not which files it touched.
- Not a review queue. Failing checks, requested changes, and who owes whom a review are
  visible in the tracker and will be raised by the team. Mention a pull request only as
  the evidence that a piece of work is done or waiting.
- Not a task picker. When the assigned work is unrelated pieces with nothing in common,
  say so in one line and stop; this skill has nothing to add.

## Whose hands it is in

The page is written for the person who resumes, so every piece is sorted by whose hands it
is in. Done: closed. In Review: off their hands, waiting for a review or for someone
else's decision. Todo: theirs, whether not started, in progress, or sent back by a review
asking for changes. The header says whether any review has come back, so the reader knows
that was checked. Done and In Review are context; Todo is what the page is for.

## Streams are not always clean

A container is a hint, not the truth. Read the bodies: a task filed under one container
may serve another's purpose, a container may hold two unrelated purposes, and a task with
no container may belong to a stream by what it says it is for. Group by purpose, keep the
container's name when it matches, and say on the page when a piece was moved or a
container was split.

## Sources

Where the facts live differs from project to project and will change over time. Discover
them each run; never assume a tracker, a hierarchy, or a plan document.

Work down this ladder for each of the four questions and stop at the first rung that
answers it. Say on the page which rung a claim rests on when it is not the top one.

1. An explicit container: a parent issue (Epic), a milestone, a project, a plan document
   linked from the issues. Its body gives the purpose and the intended order.
2. The finished pieces themselves: merged pull request descriptions, closing comments on
   issues. These say what was actually done, which is often narrower or different from the
   task text.
3. The person's own trail: commits, branch names, worktrees, notes.
4. Inference. When none of the above states the purpose, write what the trail suggests and
   mark it as inferred.

`references/sources.md` lists the collectors that exist and the JSON shape a new one must
produce. `scripts/github.py` is the GitHub collector: assigned issues with their native
hierarchy (issue types, parent and sub-issues, Projects v2 status), the pull requests that
close them, the last comments, and the events on each issue's timeline. Run it first when
the work is on GitHub; write a sibling for another tracker rather than bending the
procedure.

Plan documents referenced from issue bodies (paths under `docs/`) are read from the
repository's default branch, fetched fresh - a local checkout may be weeks behind.

## Procedure

### 1. Collect

Run the collectors that apply. Read the bodies of every container and every task that is
open or waiting, and the descriptions of every merged pull request under them. Note for
each open task when its body was written or last edited.

### 2. Form the streams

A stream is a set of tasks that serve one purpose. Use the explicit container when one
exists and keep its name and its vocabulary (Epic, Task, Bug, whatever the organisation
registered; never invent a word). Tasks with no container go in one stream at the end,
titled in plain words, and only those that are moving are listed.

When there is an intended order between streams, keep it. A stream that cannot start until
another finishes is not what the reader resumes; it gets one line saying so.

### 3. Write each stream

The summary carries the page. It comes first, in three labelled lines: the whole (what the
streams together are for, and how they depend on each other), now (where each stream
stands and what is the reader's), next (the task and its one caveat). Each stream then
opens with its own verdict paragraph before any row; the rows are evidence for the
verdict, not the content. A page that reads as a task list has lost this order.

A stream is a heading with its fraction, a bar, a verdict paragraph, the grouped rows, and
two boxes. Two streams fit in about two screens.

- **Heading.** The container's title as the tracker shows it, closed over total, and its
  number as a link. Under it a thin three-segment bar (Done, In Review, Todo) with the
  three counts printed beside it.
- **Verdict paragraph.** One muted sentence or two on what it is for and the intended
  order, then in normal weight: what is done, what is off the reader's hands, what is
  theirs, and which of those is next and why. This paragraph must answer the reader who
  reads nothing else in the section.
- **The pieces, grouped by where they stand**: Todo, In Review, Done, in that order,
  each group headed by its name and count. Inside a group the plan's order. Todo rows are
  the reader's; the next one is the only row with the accent dot and tint, and a row that
  cannot start yet carries the blocked glyph and "after X". In Review rows are off the
  reader's hands: their open sub-pieces are shown inline as short chips with the PR
  glyph, and a stacked PR carries the stack glyph plus a line saying it will not close
  its issue on merge. Done rows are one greyed line each with the merge date. A row with
  sub-pieces shows "n / m" after its number.
- **Next.** One line: the next task and what its text says to do first.
- **What moved since the text was written.** Dated facts as short bullets: the body's
  date, then what happened on sibling tasks, on the container, and in the plan since then.
  Where a fact casts doubt on the task's premises, the bullet ends with what to check.
  Facts first, the doubt after; never the doubt alone.

The page is about the situation, not the tasks. A row exists because it is what stands
between the stream and its goal, and its line says what is still missing, not what the task
is called. When a row would only restate its title and status, drop the line and keep the
title.

Identify a row by its title. Numbers are links beside the title, never the thing the reader
is expected to recognise.

### 4. Publish

One page, as an Artifact, in the language the person writes in. Short paragraphs for the
summary and the verdicts, rows for everything else; no interactive controls; nothing
folded away, because collapsing detail broke the reader's picture of the whole when it
was tried. Plain system sans-serif at normal size; no display typeface, no decoration.

State is shown with a small fixed vocabulary so it is recognised, not read:
`references/visual.md` lists the devices (three state circles for Todo, In Review, Done
plus one accent dot for next; a three-segment bar per stream; GitHub's own PR and merge
glyphs for "there is a PR" and "it is merged"; a blocked glyph for "after X"; a stack
glyph for stacked PRs; Done rows greyed) and where each was borrowed from. Borrow the
tracker's glyphs only for what the tracker does well; GitHub's open-versus-closed icons
are not used, because "open" lumps Todo and In Review together and that is the one
distinction this page exists to make. The icon paths are in
`assets/octicons.svg`; `assets/example-2026-09-22.html` is a finished page to copy the
markup from. Read `artifact-design` before writing it, and `z-japanese-proofreading` when
the page is in Japanese.

The page opens with the three-line summary, then the streams in the plan's order, then
the loose pieces that are moving, then one line on what comes after the streams. Exactly
one row on the whole page carries the "next" mark.

Close with the sources and the collection time.

### 5. Check before handing it over

- Could a reader who stops after the first paragraph act correctly? If not, the verdict
  is missing something.
- Is the reader's own next piece the only thing in the accent colour? Everything is
  listed under its group, but only the next piece is emphasised.
- Is there a status name, a count, or a percentage carrying meaning that a sentence should
  carry instead?
- Is every "what moved" item a dated fact, with its doubt stated as a separate sentence?
- Is anything on the page there because the data had it rather than because the reader
  needs it?

## Trigger phrases

"catch me up", "where was I", "what was I doing", "what am I working on", "back from a
break", 「戻ってきた」「久しぶりに戻った」「今どこまで進んでる」「状況を整理して」「何やってたっけ」
「次何をやるべきか思い出したい」.
