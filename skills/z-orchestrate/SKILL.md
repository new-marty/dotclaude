---
name: z-orchestrate
description: Run work as several agents in parallel or in stages, from the decision to split through briefs, verification, a progress table and the final report. Use when one job has many independent units (documents, files, investigations, checks) or when the person asks to fan out, run in the background, or use subagents. Not for a single task (`z-start-task`), not for ending a session (`z-wrap-up`), and not for workers supervised by Orca, which has its own orchestration skill.
argument-hint: "[the job to split](optional)"
---

<!-- Ideas from Orca's orchestration skill (MIT, Lovecast Inc., stablyai/orca), obra/superpowers
     (MIT: dispatching-parallel-agents, subagent-driven-development) and Anthropic's engineering
     posts. The text is written from scratch; no passage is copied. Sources are listed at the end. -->

# Orchestrate

Fan-out multiplies cost and multiplies mistakes. Split only when it pays, make each agent's job
checkable, and keep the state in files so a new session can pick the work up.

## 1. Decide whether to split

Start with one agent. Cognition ("Don't Build Multi-Agents") shows parallel agents making
conflicting implicit decisions, and Anthropic's research-system post says coding has fewer
parallel parts than research. Split only when all of these hold:

- The pieces are independent: no piece needs another's output or shares a decision with it.
- Readers and checkers can run in parallel. Writers can run in parallel only on disjoint paths.
  Pieces that edit the same file, or must agree on a design, go to one agent or run in sequence.
- Each unit's result can be checked by something other than the agent that produced it.

Estimate the cost before launching. Anthropic measured about 15x the tokens of a chat for a
multi-agent run. Write down units x stages x rough size, plus any paid backend, and tell the
person the ceiling. If it is large, say what it buys.

Pilot before scaling. Run 1 to 3 units through every stage, then show the person the results
and the success criterion in plain words: what counts as better, how it was measured. Show a
real before and after from the pilot, not only the policy; a person cannot judge a rule they
have not seen applied. Wait for agreement before the full run. A document rewrite once ran
without a clear goal: of 12 rewrites, only 4 were judged clearly easier to read. The pilot is
the check against that.

Check the premise before the pilot. A job that was planned earlier may have been overtaken by
decisions made since; read the task and what changed, and say so before running the old plan.

Choose the mechanism. Subagents through the Agent tool suit short units whose results come
back to you. Background sessions suit long units that need their own context. Use the Workflow
tool only when the person opted in. Agent teams suit work where teammates must talk to each
other; the docs advise starting with 3 to 5 and giving each its own files. Note the limits:
subagents start without your conversation and may be capped in count and nesting depth.

## 2. Write the briefs

An agent that starts cold knows only what you give it. Write each stage's brief to a file in a
place the next session will also read (not a temporary directory), and tell the agent in the
prompt to read it. The prompt then carries only the unit's name and paths. A brief repeated in
every prompt drifts; a file is edited once.

Each brief names:

- Target: the files or component in scope.
- Change: the concrete result to produce, and the purpose, so the agent judges edge cases.
- Constraints: invariants and do-not-touch boundaries.
- Owned paths: the only paths this agent may write.
- Observable acceptance: the test, count or output that shows it is done.
- Output format: what to return, in what shape.

Add the rules every agent follows:

- Return findings as text. Some subagents cannot write report files; the orchestrator saves them.
- Commit only your own paths (`git commit -m ... -- <paths>`), never `git add -A` or `commit -a`,
  because the working tree is shared. Retry on an index lock.
- Sign commits with the model you ran on, as your own session instructions state. Do not
  hard-code a name in the brief; an agent on a different model would sign falsely.
- End with one status: DONE, DONE_WITH_CONCERNS, NEEDS_CONTEXT or BLOCKED (obra/superpowers).
  Concerns and blockers carry a reason.

Give one agent per stage per unit. An agent that built the list should not check it, and an
agent that wrote the draft should not inspect it. Brief stages that are separate jobs
separately.

## 3. Run

Launch the whole independent wave in one batch, then wait. Keep chains at 3 to 4 stages; prefer
a wider wave to a deeper chain (Orca). Mind the concurrency limit of the mechanism.

Silence is not failure. A long-running agent that has not reported is working until you have
evidence otherwise. Do not relaunch, stop or duplicate it, because a second writer on the same
paths causes the damage you split carefully to avoid. After several empty waits, look at real
state: the process or session list, the files and commits the agent owns. Act only on proof that
it exited.

When an agent settles, decide at once: reuse it for a follow-up, keep it, or release it.

Report to the person at milestones: the pilot, each finished batch, any failure, any cost
surprise. One line each, with counts. When a milestone needs the person to decide something,
ask one question at a time, with an example of what each option would produce.

## 4. Verify

The agent's own report is a claim. Check it.

- Use an independent verifier. It sees only the original and the result, not the working files,
  the fact lists or the producer's notes. Anything else lets it inherit the producer's mistakes.
- Give it a counted checklist, and the same checklist every time. Count each kind of defect:
  dropped, weakened, added, changed in meaning, form broken. Inspectors that count differently
  make the numbers useless. Tell it to be strict; earlier inspections undercounted.
- Machine checks (tests, linters, diff scripts) come first and are never a substitute. Run the
  inspection even when they pass.
- Fixes get re-verified. A fix commit has introduced new damage before. Re-inspect the fix diff
  narrowly, and count the result again.
- Cap the fix rounds, for example 3, then hand the remainder to the person with the findings
  (obra/superpowers caps its loop the same way). If the original itself is wrong or
  contradicts itself, report that and do not repair it.
- Irreversible actions (deletion, publishing, spending beyond the ceiling) wait for the person.

Judge outcome separately from correctness. A rewrite can drop nothing and still be no easier
to read; say both.

## 5. Record

Keep one table for the whole job, one row per unit, as a file in the repository or the
agreed workspace. Columns: unit, status, commit, finding counts from the last inspection, who or
what produced it, date, note. Update a unit's row in the same commit as its result, so the table
and the work never disagree. Units not started stay in the table, marked untouched.

A new session resumes from this table and the brief files, not from memory of the last session.
Say so in the table's header or next to it.

Record each ruling as decision, reason, and what it costs if wrong. Rulings made in conversation
are lost otherwise.

Report only what was counted. If a figure comes from a sample, say the sample size. If you did
not run a check, write "not verified". A run once reported zero drops from a method that could
not see some kinds of drop; the number was true of the method, not of the documents.

## 6. Close out

- Wait until every agent has settled. Enumerate them from real state, not from your memory of
  what you launched.
- Hand off or release each one. Nothing keeps running unowned.
- Report per unit: outcome, the evidence behind it (counts, commit hash), and what is still
  open, with the cost against the ceiling.
- Finish with one table the person can read in a minute: done, done with caveats, not started.
- Note what to change in the briefs or this process, while you still remember why.

## Sources

- Anthropic, "How we built our multi-agent research system":
  https://www.anthropic.com/engineering/multi-agent-research-system
- Anthropic, "Effective harnesses for long-running agents":
  https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
- Claude Code docs, subagents: https://code.claude.com/docs/en/sub-agents
- Claude Code docs, agent teams: https://code.claude.com/docs/en/agent-teams
- Cognition, "Don't Build Multi-Agents": https://cognition.com/blog/dont-build-multi-agents
- obra/superpowers (MIT), `dispatching-parallel-agents` and `subagent-driven-development`:
  https://github.com/obra/superpowers/tree/main/skills
- Orca orchestration skill (MIT, Lovecast Inc.): https://github.com/stablyai/orca
