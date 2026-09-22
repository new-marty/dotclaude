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

The page is written for the person who resumes, so "done" means done from their side.
A piece is off their hands when it is closed, or when its pull request is waiting for
review, or when it is waiting on someone else's decision. Those are summed up, never
listed. A piece is theirs when it is not started, in progress, or a review has come back
asking for changes. The page shows only what is theirs, and says in the header whether any
review has come back, so the reader knows that was checked.

The heading carries two fractions: closed over total, and in small type off-their-hands
over total. Both matter; the first says how far the stream is, the second how much of the
rest is theirs.

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

Keep it short. A stream is a heading, one line, a list of rows, and two boxes. The whole
page for two streams fits in about one and a half screens; if it runs longer, cut words,
not parts.

- **Heading.** The container's title as the tracker shows it, the fraction of its pieces
  off the reader's hands (2 / 4, with the split in small type), and its number as a link.
- **One line on what it is for.** The problem and the approach, and the intended order,
  because the order is what makes the next task the next task. One or two sentences, muted.
- **One line on what is theirs**, or that nothing is.
- **What is not closed.** A muted list, in the plan's order, of every piece that is not
  closed, whether or not it is theirs: title, its own closed fraction when it has
  sub-pieces, its state in the tracker's spelling, and the names of the sub-pieces still
  open in one short phrase. Mark the one the reader will pick up next in the accent
  colour. This list is secondary, set small and muted, but it is there so the reader can
  see how much is left and what it is called; the judgement about the next task depends
  on it. Closed pieces are not listed.
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

One page, as an Artifact, in the language the person writes in. Rows and one-liners, not
paragraphs; no interactive controls; nothing folded away, because collapsing detail broke
the reader's picture of the whole when it was tried. Plain system sans-serif at normal
size; no display typeface, no decoration. Read `artifact-design` before writing it, and
`z-japanese-proofreading` when the page is in Japanese.

The page opens with a two-sentence summary across all streams, the second sentence in bold
naming what the reader will do next and its one caveat. Then the streams in the plan's
order, then the loose pieces that are moving. Mark the next row so it can be found by eye,
but never let state decide where a row sits; the plan's order does.

Close with the sources and the collection time.

### 5. Check before handing it over

- Could a reader who stops after the first paragraph act correctly? If not, the verdict
  is missing something.
- Is the reader's own next piece the only thing in the accent colour? Everything not
  closed is listed, but only what is theirs is emphasised.
- Is there a status name, a count, or a percentage carrying meaning that a sentence should
  carry instead?
- Is every "what moved" item a dated fact, with its doubt stated as a separate sentence?
- Is anything on the page there because the data had it rather than because the reader
  needs it?

## Trigger phrases

"catch me up", "where was I", "what was I doing", "what am I working on", "back from a
break", 「戻ってきた」「久しぶりに戻った」「今どこまで進んでる」「状況を整理して」「何やってたっけ」
「次何をやるべきか思い出したい」.
