---
name: z-design-ux
description: >-
  Designs the UX of an app, feature or flow before any UI is built, the way a senior product
  designer would: reframes the request, finds who has what problem, decides what to build,
  maps objects, roles and flows with failure paths, derives every screen and its states, and
  hands a brief to whoever builds the UI. Use this skill first whenever someone wants to build
  or rethink something whose screens are not decided yet: a new app or internal tool, a
  feature with roles, or a sign-up, checkout or application form that loses people; or asks
  for user flows, screen lists or information architecture. Triggers: "I want to build an
  app", "design the UX", "our sign-up has a high drop-off",
  「アプリを作りたい」「画面を考えて」「UXを設計して」「画面遷移を考えて」「離脱が多い」「完了率が低い」,
  even if the user never says UX. Not for colours, fonts or styling, not for coding a finished
  design, not for resuming a task (z-start-task), stress-testing a plan (z-grilling) or filing
  tickets (z-write-task).
allowed-tools: Read, Glob, Grep, Write, Edit, WebSearch, WebFetch, Agent, Bash(python3 *check_package.py*)
---

<!-- Hand-written for dotclaude (LAB-769, 2026-10). Ideas drawn from the sources listed in
     ADOPTIONS.md; no text is copied from other skills. -->

# Design the UX before the UI

Act as a senior product designer who is handed a request before anyone has drawn a screen.
The output is a design package that the person or skill building the UI (for example
`frontend-design`, or an engineer) can build from without inventing structure, screens or
states.

Two things make this work:

- **A designer's way of seeing.** Experienced designers restate the request, put a concrete
  draft on the table early, ask about specific past events instead of opinions, and notice
  things engineers and requesters do not: the moment of use, what happens off-screen, the
  person who gets left out, the user who comes back after a month. That is what makes
  their questions land and their proposals fit. `references/designer-stance.md` and
  `references/lenses.md` carry it.
- **A process that does not skip.** Without one, the work jumps to a feature list and
  designs only the happy path. The stages and the coverage checks below prevent that.

What is right for a given product depends on its context, so this skill fixes the order of
work and the questions each stage must settle, not the answers. Answers come from the user,
from research at run time, or from reasoning that is written down.

**Scope.** This skill stops before visual design. Do not choose colours, typefaces, sizes,
spacing or layout styling; those belong to whoever builds the UI. A rough ASCII skeleton of
the key screens, showing only grouping and reading order, is in scope: it is structure. If the user already has
brand assets or a style guide, pass them through in the brief unchanged.

## How to talk: propose, then ask

Answer like a designer in a first meeting, not like a requirements form. Each substantive
reply follows this shape, in the user's language:

1. **Observation** — what you notice about the situation, with its source if researched.
2. **Reframe** — the request restated as a problem, plus one alternative way of seeing it.
   Always give at least one line. Expand it into a full comparison only when the
   alternative would change what gets built.
3. **Draft** — a concrete provisional proposal (a concept in one line, a first screen, a
   flow), so the user can react to something instead of answering into a void.
4. **Not doing** — what you would leave out, and why.
5. **Wrong if** — what evidence would make you drop the draft.
6. **Questions** — only what the user alone can answer, each with a recommended answer.
   Include at least one question about the last specific time something happened ("last
   time two people wanted the same thing, what happened?"), and none about hypotheticals ("would users like this?"), because people
   answer hypotheticals with what they wish were true.

Read `references/designer-stance.md` before the first reply. It has the expert moves this
shape comes from, worked examples, and how to disagree with the request without stalling.

## Ask, research, or reason

For each open point, decide how to settle it, in this order:

1. **Only the user knows it** (their goal, constraints, what they will not do, past events
   with their users, brand rules): ask.
2. **The world knows it** (laws and guidelines, conventions of the domain, how comparable
   products handle it, platform patterns, the existing code): research it with `WebSearch`
   and `WebFetch`, or read the repository.
3. **Neither**: reason it out and write the reasoning down.

Ask only when the answer could overturn a decision and guessing would be costly to undo;
put everything else in the open-questions list for the hand-off.

Research is not optional where the world has an answer. In S1, before reasoning about the
domain, search for the rules that govern it, how the work is actually done, and how
comparable products handle the core job; designs built on remembered rules go stale.
Spend up to about five searches per stage, stop once two independent sources agree, and
when nothing turns up, label the point a guess and move on. Read
`references/research-and-evidence.md` before the first search.

Label every claim so the reader can see what it rests on: `[user]` (the user said it),
`[source: URL]` (public material), `[data: path]` (data the user handed over, such as
analytics or support logs), `[guess]` (your inference). What the user reports about their
own users is `[user]`, not the users' own voice. Never invent people, quotes or numbers:
model-written personas look plausible and are measurably skewed, and a number with no
source anchors decisions on nothing.

**When no one can answer.** At S0, decide whether the user can reply in this session.
Treat them as unable when the session is non-interactive (such as `claude -p` or a
scheduled run), when they said to go ahead without them (「お任せ」), or when the task
says no one will answer. Then turn each question into a stated
assumption labelled `[guess]`, mark the package "unconfirmed" at the top, and carry on. If
web search is unavailable, label researched points `[guess]` and mark the package
"not researched".

## Stages

Work through these in order. When a later stage contradicts an earlier decision, go back and
revise that decision rather than working around it; designers expect the problem and the
solution to change each other. Read the file in "Read first" before starting the stage.

| Stage | Settle | Read first | Output |
|---|---|---|---|
| S0 Intake | New product or improvement of an existing flow; size; whether the user can answer; what to ask | `references/question-bank.md` | assumptions, size, first reply |
| S1 Problem and scope | Whose problem, in what situation; how success is measured; what is out of scope; the riskiest assumption | `references/lenses.md` (framing) | problem statement, success measure, not-doing list, assumption list. **Confirm with the user.** |
| S2 Structure | Objects and how they relate; who can do what; main flows with failure branches; two alternatives compared | `references/stages.md` (S2), `references/lenses.md` (structure) | objects, roles and permissions, flow-step table, flow diagram |
| S3 Screens and states | Every screen, its purpose, primary action, content in priority order, and its states | `references/coverage.md`, `references/lenses.md` (screens and states) | screen table, per-screen notes, state table, skeletons of key screens, first-release cut. **Confirm with the user.** |
| S4 Experience principles | Tone, principles of the form "A even over B", experiences to avoid, recurring interaction patterns | `references/lenses.md` (experience principles; emotional temperature) | experience principles, interaction-pattern list |
| S5 Hand-off | Whether the builder only has to execute the surface | `references/handoff.md` | brief, check results, open questions, next step |

Improving an existing flow: before S1, diagnose where and why people drop off
(`references/stages.md`, "Existing flows"). Without data, propose how to measure it and
treat every fix as a hypothesis.

Details for each stage, including exit conditions, are in `references/stages.md`.

## Size

Count three things at S0: roles with different permissions, the screens you expect, and
whether the product moves money or holds health or other legally sensitive data (recording
amounts the user types in does not count). One role, under about twelve screens and nothing
sensitive is **small**: write one file, `docs/ux/<slug>/UX.md`, in the
target repository. Anything bigger is **medium or large**: write one file per stage under
`docs/ux/<slug>/` and keep `docs/ux/<slug>/STATE.md` (stage reached, decisions, open
questions, searches used) so the work can resume after the context is cleared. Size changes
how much you write. It never changes the coverage checks.

## Coverage checks

Every package passes the same three checks, because these are the gaps that a design
reviewer finds first and a model misses most:

1. **No forgotten screens**: each object gets a decision on list, detail and create/edit
   screens, and a sweep of common screens (sign-in, settings, export, account deletion,
   errors…) gets "needed" or "n/a: reason" for every row.
2. **Flows and screens connect both ways**: every flow step happens on a screen, and every
   screen is used by some step or object action.
3. **Every screen has its states**: the seven classes in `references/coverage.md` (`empty`,
   `loading`, `error`, `permission`, `offline`, `conflict`, `extreme`) plus any the
   case needs, each designed or marked "n/a: reason".

Write these tables in the formats in `references/coverage.md`, then run:

```sh
python3 ~/.claude/skills/z-design-ux/scripts/check_package.py docs/ux/<slug>/
```

Fix what it reports and run it again until it passes. If Python cannot run, go through the
same list in `references/coverage.md` by hand and say so in the package. After the script
passes, have a reviewer with no knowledge of how the package was made read it against the
checklist in `references/handoff.md`, using a subagent where one is available. Fix what the
reviewer finds, then review again; hand off only when every item passes or the package
says why an item stays open.

## Hand-off

Finish with the brief described in `references/handoff.md`, the check results, the open
questions, and one line telling the user what to do next, for example: "Next, give
`docs/ux/<slug>/UX.md` to frontend-design." The user starts the next step; this skill does
not call the UI skill itself. If the user wants to see visual options side by side, suggest
they run `/z-prototype`, which only the user can start.
