---
name: z-wrap-up
description: End the session properly. Write down what this session was doing, what it settled, what is half-done, and the first thing to do next, so a fresh session starts informed; then clear the conversation. Use when the user says "wrap up", "wrap it up", "let's stop here", "end the session", 「wrap up して」「ここで終わり」「一旦区切る」「セッション終わらせて」「コンテキスト整理して clear」. Not for saving a durable fact (that is memory), not for a standup note, and not for coming back after days away (`z-catch-up`).
argument-hint: "[what to emphasise in the handoff](optional)"
disable-model-invocation: true
allowed-tools: Bash(git *), Bash(cmux *), Bash(ls *), Read, Write, Edit
---

# Wrap up

A session that ends with `/clear` alone throws away everything that was decided in
conversation and never reached a file: the reason a design was chosen, the alternative
that was rejected, the question still waiting for an answer, the branch left half-done.
The next session then reconstructs it from git and the tracker, badly. This skill writes
that state down first, in one place the next session reads automatically, and only then
clears.

The reader of the handoff is the next session's model, and through it the same person.
It is state, not a report: what is true now and what to do first.

## What gets written where

The handoff goes to `~/.claude/projects/<project slug>/handoff.md`, one file per
project directory, overwritten every time. `scripts/handoff-inject.py`, registered on
`SessionStart`, puts it back into context when the next session starts in the same
directory, for seven days; after that the situation has moved on and `z-catch-up` is the
way back in.

Durable facts do not belong in the handoff. A preference the person stated, a constraint
of the project, a pointer that will still matter next month: those go into memory, in the
directory the system prompt names, following its rules. The handoff is for what is true
today and will be stale in a week.

Nothing is written into the repository. A handoff in the working tree ends up in commits.

## Procedure

### 1. Collect what only this session knows

Before writing, look at the actual state rather than remembering it:

```bash
git -C "$PWD" status --short --branch
git -C "$PWD" log --oneline -5
git -C "$PWD" stash list
```

Then go through the conversation for the things git cannot show: decisions and the
alternatives they beat, questions the person has not answered, requests the person made
and then changed, anything promised to a third party (a message to relay, a review to
wait for), artifacts published (URLs), background tasks still running, and the argument
the person gave when they overruled you. If `$ARGUMENTS` names something to emphasise,
give it its own section.

### 2. Write the handoff

Write it in the language the conversation was in. Fixed sections, in this order; drop a
section only when it would be empty, and say so in one word rather than leaving it out
silently:

```markdown
# Handoff — <project> — <YYYY-MM-DD HH:MM>

## What this session was doing
One paragraph: the goal, and how far it got.

## Done
What was finished and where it lives (commit, URL, file). Facts, not effort.

## Half-done
What is started and not finished: branch, uncommitted files, a page published but not
reviewed, a script written but not run. For each, what "finished" would look like.

## Decided, and what it beat
Each decision with the alternative that was rejected and the reason. This is the part git
never records.

## Waiting on
Who or what the work is waiting for: a review, an answer from the person, a reply from
another machine or team. Include the exact message that was sent if there was one.

## Next
The first concrete action for the next session, and the second. Not a plan.

## Facts the next session will need
Paths, URLs, commands, identifiers, the state of the other side of a conversation. Only
what cannot be rediscovered cheaply.

## Open questions for the person
Things you were going to ask and did not.
```

Keep it under about eighty lines. A handoff nobody reads to the end is a handoff that
loses its "Next".

The writing rules are the usual ones: `z-writing-for-readers` for shape, and the
language pass it names. State facts; do not narrate the session in order.

### 3. Move durable facts into memory

Anything in the handoff that will still be true in a month is a memory, not a handoff
item: write it as a memory file and add its line to `MEMORY.md`, then leave a one-line
pointer in the handoff. Do this before clearing; after clearing, nobody remembers to.

### 4. Tell the person, briefly

One line saying where the handoff is and what "Next" says. No summary of the session;
the file has it.

### 5. Clear

Inside cmux (`CMUX_SURFACE_ID` is set), type the command into this session's own
terminal as the last tool call:

```bash
cmux send "/clear\n"
```

Claude Code queues input typed during a turn and runs it when the turn ends, so the
reply from step 4 is delivered first and the conversation clears right after it. This
was checked on 2026-09-26 with a scratch session.

Outside cmux there is no way for the model to clear the conversation. End the reply with
the line "Type /clear to finish." and stop.

## What not to do

- Do not compact instead of clearing. Compaction keeps a summary the model wrote for
  itself; the handoff is written for the next session on purpose.
- Do not commit or push. `sync-push.sh` handles `~/.claude`; a project repository is the
  person's to commit.
- Do not write the handoff as prose about what happened. It is the state now.
- Do not clear when step 1 shows something that will be lost by clearing and cannot be
  written down: a background task whose output has not arrived, a question the person
  is mid-way through answering. Say what is pending and stop before step 5.
