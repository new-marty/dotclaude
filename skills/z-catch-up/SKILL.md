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

Open with the verdict, two or three sentences: where the stream stands, what the reader
will do next, and the one caveat about the next task's premises if there is one. The reader
who stops here must have the answer.

Then, under plain headings in the reader's language:

- **What it is for.** The problem and the approach in the container's own words, compressed
  to a paragraph. Include the intended order and why it is that order, because the order
  is what makes the next task the next task.
- **What is done.** One row per piece, in the order the plan gave them, each row carrying
  the piece's title as the tracker shows it, its state in the tracker's spelling, and one
  or two sentences on what doing it established or changed. Chronology matters: the reader
  restores what they were thinking by reading what happened in order. A piece that was
  split has its parts summarised on its row, not listed.
- **Next.** The next task and what its text tells the reader to do first.
- **What moved since the text was written.** Dated facts: the body's date, and what
  happened on sibling tasks, on the container, and in the plan since then. Where a fact
  casts doubt on the task's premises, add one sentence saying what to check before
  starting. Facts first, the doubt after; never the doubt alone.

Identify a row by its title. Numbers are links beside the title, never the thing the reader
is expected to recognise.

### 4. Publish

One page, as an Artifact, in the language the person writes in. Prose and short rows, no
interactive controls, nothing folded away: collapsing detail has been tried and it broke the
reader's picture of the whole. Read `artifact-design` before writing it, and
`z-japanese-proofreading` when the page is in Japanese.

Design for one read from the top: the lead paragraph of the page is the verdict across all
streams, each stream's opening is its verdict, and the four parts follow in the order above.
Encode state in a small marker beside each row so the reader can find "where am I" by eye,
but never let the state decide where a row sits; the plan's order does.

Close with the sources and the collection time.

### 5. Check before handing it over

- Could a reader who stops after the first paragraph act correctly? If not, the verdict
  is missing something.
- Does every row say what the piece changed, not what it is called or which files moved?
- Is there a status name, a count, or a percentage carrying meaning that a sentence should
  carry instead?
- Is every "what moved" item a dated fact, with its doubt stated as a separate sentence?
- Is anything on the page there because the data had it rather than because the reader
  needs it?

## Trigger phrases

"catch me up", "where was I", "what was I doing", "what am I working on", "back from a
break", 「戻ってきた」「久しぶりに戻った」「今どこまで進んでる」「状況を整理して」「何やってたっけ」
「次何をやるべきか思い出したい」.
