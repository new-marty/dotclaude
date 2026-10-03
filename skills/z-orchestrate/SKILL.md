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
multi-agent run. Write down units x stages x rough size, counting the verifier and fix stages
and any paid backend, and put the ceiling as a number in the same message that proposes the
split, before anything launches. If it is large, say what it buys. Give a figure per unit, not
"tens of times a chat": in one run, one of four units cost more than ten times as much as each
of the others.

Pilot before scaling. Run 1 to 3 units through every stage, then show the person the results
and the success criterion in plain words: what counts as better, how it was measured. Show a
real before and after from the pilot, not only the policy; a person cannot judge a rule they
have not seen applied. Wait for agreement before the full run. A document rewrite once ran
without a clear goal: of 12 rewrites, only 4 were judged clearly easier to read. The pilot is
the check against that. When units differ in size or risk, pilot the one that changes security,
deletion or behaviour across repositories, else the largest; never just the cheapest. That pilot
costs more, and it is still cheaper than finding its defect after the full run: one run
launched four units together, and its security patch ran an hour, then failed verification on
a regression.

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
- Constraints: invariants and do-not-touch boundaries. Name the files next to the target that
  may need a matching change; the agent reports them and does not edit them. A needed change
  to `settings.example.json` was once found only by the verifier.
- What must survive: when the unit removes, replaces, moves or summarises something, list what
  may not be lost (dates, who decided, numbers, commands, the references that point at it) and
  how to confirm a replacement still works (for an alert path: a test alert that the person
  receives). Across repositories, say which side's commit waits for the other. Briefs without
  this have dropped task numbers from a rewrite, routed alerts to a check nobody was notified
  of, and left a live symlink dangling between two commits.
- Owned paths: the only paths this agent may write.
- Observable acceptance: the test, count or output that shows it is done.
- Output format: what to return, in what shape.

Add the rules every agent follows:

- Return findings as text. Some subagents cannot write report files; the orchestrator saves them.
- Commit only your own paths (`git commit -m ... -- <paths>`), never `git add -A` or `commit -a`,
  because the working tree is shared. Retry on an index lock. Never run `git stash`, `checkout`
  or `reset` there either: they move other agents' uncommitted work.
- Sign commits with the model you ran on, as your own session instructions state. Do not
  hard-code a name in the brief; an agent on a different model would sign falsely.
- End with one status: DONE, DONE_WITH_CONCERNS, NEEDS_CONTEXT or BLOCKED (obra/superpowers).
  Concerns and blockers carry a reason.

Fix rounds and follow-ups point at the same brief file. A fix prompt written ad hoc once left
out the stash ban, and that agent ran `git stash` in the shared tree.

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

While an agent owns a file, do not edit that file yourself; send the fix to the agent. An
orchestrator and its agent once both edited one code comment, and the second edit undid part of
the first.

Report to the person at milestones: the pilot, each finished batch, any failure, any cost
surprise. One line each, with counts. When a milestone needs the person to decide something,
ask one question at a time, with an example of what each option would produce. When the person
asks something mid-run, answer it before the next launch or report. Once, four more agents
were launched while the person's question sat unanswered, and they had to ask again.

## 4. Verify

The agent's own report is a claim. Check it.

- Use an independent verifier. It sees only the original and the result, not the working files,
  the fact lists, or the producer's notes and claims, so its prompt gives the target and the
  purpose and does not quote the producer. Anything else lets it inherit the producer's
  mistakes. Verifier prompts that quoted "it claims to add..." once steered what was checked.
- Give it a counted checklist, and the same checklist for every unit, kept in one brief file.
  Count each kind of defect: dropped, weakened, added, changed in meaning, form broken.
  Inspectors that count differently make the numbers useless; one run gave each unit's verifier
  its own list, and the counts could not be compared. Tell it to be strict; earlier inspections
  undercounted.
- Machine checks (tests, linters, parsers for frontmatter and JSON, diff scripts) come first and
  are never a substitute. Run the inspection even when they pass. A skill's frontmatter once
  passed a read-through and then failed YAML parsing.
- Fixes get re-verified. A fix commit has introduced new damage before. Give the fix diff to a
  verifier, narrowly, and count the result again. If you only read it yourself, that is a
  stopgap: the table says so and lists the checks nobody re-ran. A table once said "all 5
  items fixed" after a read, while the fixed commands had never been run.
- Your own edits are units too. A change you make after verification gets its own check, or
  the table marks it not verified. One orchestrator added a hook timeout after the verifiers
  had finished, and only a JSON parse ever checked it.
- A unit that rewrites or restructures an existing file gets the dropped-facts check against
  the old version, also when it is one of the small extra units run beside the main batch. Two
  such units were once closed on the producer's report and a diffstat alone.
- Cap the fix rounds, for example 3, then hand the remainder to the person with the findings
  (obra/superpowers caps its loop the same way). If the original itself is wrong or
  contradicts itself, report that and do not repair it.
- Irreversible actions (deletion, publishing, spending beyond the ceiling) wait for the person.

Judge outcome separately from correctness. A rewrite can drop nothing and still be no easier
to read; say both.

## 5. Record

Keep one table for the whole job, one row per unit, as a file in the repository or the
agreed workspace. Columns: unit, status, commit, finding counts from the last inspection (the
five kinds above; a table with its own three columns once could not hold the verifier's
counts), who or what produced it (agent and model, since "subagent" alone cannot be traced),
date, note. Set a unit's status as soon as its agent reports, and keep it short of done until
the result is verified and committed; one row stayed "running" after its agent had reported.
Write its commit and counts in the same commit as its result, so the table and the work never
disagree; when the work lands by merge or cherry-pick, cite the landed hash. Units not started
stay in the table, marked untouched.

A new session resumes from this table and the brief files, not from memory of the last session.
Say so in the table's header or next to it.

Record each ruling as decision, reason, and what it costs if wrong, including the answers the
person gives mid-run. Rulings made in conversation are lost otherwise; a hook timeout the
person approved mid-run once reached neither the table nor the rulings.

Report only what was counted. If a figure comes from a sample, say the sample size. If you did
not run a check, write "not verified". A run once reported zero drops from a method that could
not see some kinds of drop; the number was true of the method, not of the documents.

## 6. Close out

- Wait until every agent has settled. Enumerate them from real state (the agent or session
  list, `git worktree list`), not from your memory of what you launched. For each worktree,
  confirm its work has landed and nothing in it is uncommitted, then ask the person before
  removing it, or write down who removes it. One run left two behind.
- Hand off or release each one. Nothing keeps running unowned. Do not end the session while a
  fix round is still running; if you must, hand off each running agent, or stop it with the
  person's agreement, and record which. One agent kept editing files for 17 minutes after its
  orchestrator's final message.
- A handoff is complete only after you have read the other session's state back (it is alive
  and has the brief), not when the transport reports the text accepted. One handoff was
  reported done although its text went to a terminal that had already exited.
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
