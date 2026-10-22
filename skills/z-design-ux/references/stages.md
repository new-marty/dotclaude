# Stages

What each stage settles, what it writes, and when it is done. The questions are fixed; the
answers come from the user, from research, or from written reasoning. Use the lenses in
`lenses.md` to find what the questions miss.

Contents: S0 intake; S1 problem and scope; S2 structure; S3 screens and states; S4
experience principles; S5 hand-off; existing flows; the package layout.

## S0 Intake

Settle:
- Is this a new product, a new feature in an existing product, or an existing flow to
  improve? Read the repository, its README and any design documents before asking.
- Size: roles with different permissions, expected screens, and whether money moves or
  legally sensitive data is held (SKILL.md, "Size").
- Can the user answer in this session? If not, questions become `[guess]` assumptions and
  the package is marked "unconfirmed".
- What to ask: only what could overturn a decision (`question-bank.md`).

Write: the first reply in the shape from `designer-stance.md`. For medium or large work,
create `STATE.md` with the size, whether the user can answer, and the open questions.

Done when: the size and kind of work are stated in one sentence, everything readable has
been read, and the first reply has gone out (or the assumptions are recorded).

## S1 Problem and scope

Settle:
- The problem, without naming a solution or a screen. "Members miss pickup windows" rather
  than "a holds page".
- Who has it and in what situation, with labels on every claim.
- The main jobs, as "When ___, I want to ___, so I can ___". The "when" clause later
  becomes the entry point of a flow.
- One success measure, with a baseline if one exists.
- Constraints, split into hard (law, contract, platform) and soft (habit, preference).
- What is out of scope, and what the design will not do.
- The riskiest assumptions, each with what would show it wrong and the cheapest way to test
  it.
- Domain rules and regulations that bear on the design: research them now (budget in
  `research-and-evidence.md`) rather than writing them from memory, since they change. Each
  finding ends in a design consequence, carried into S2 or S3, or a line saying why it
  changes nothing.

Write: problem statement, situation and people, jobs, success measure, constraints,
not-doing list, assumption list, the rival frame from the first reply and why it was or was
not chosen.

Done when: the problem statement names no screen or feature; every feature you intend to
build traces to a job; the three riskiest assumptions each have a way to be shown wrong.
Then confirm with the user: show the problem, success measure, not-doing list and riskiest
assumptions on one screen and wait for the reply. If no one can answer, mark the package
"unconfirmed" and continue.

## S2 Structure

Settle:
- **Objects**: the things people deal with (a book, a hold, a member), what each holds that
  people look at, what they sort and filter by, and whether it has a lifecycle (requested →
  ready → collected → expired). Every noun in the jobs appears as an object or is explained
  away.
- **Relations**: for each pair of related objects, how they connect, how many of each, how
  the list is sorted and filtered, and what happens to one when the other is deleted.
- **Roles and actions**: a table of roles × objects with the verbs each role may perform.
  Include the role's lifecycle (invited, changed, removed, the last admin).
- **Flows**: one per main job, per role, as rows of the `ux:flow-steps` table in
  `coverage.md`, with failure branches on every step. Screens do not exist yet: write `TBD`
  in the Screen column and replace it with screen IDs in S3. Add the flows that happen outside
  the screen (messages sent, staff actions, things done on paper) as steps with their own
  actor.
- **Two alternatives**: sketch two different structures or flows for the central job, pick
  three or four criteria from this case, compare, and choose. Record what the choice gives
  up.
- After drafting, list what the draft revealed (`designer-stance.md`, move 5).

Write: objects, relations, roles × actions, flow-step table, and a Mermaid flowchart for
each main flow, kept to plain `flowchart` syntax (avoid lowercase `end` as a node label; it
breaks the chart).

Done when: every job has a flow; every step has failure branches or `none: reason` (the
Screen column may still say `TBD`); every object has an owner role; the alternatives comparison names its criteria and what was given
up.

## S3 Screens and states

Settle:
- The screen list, derived rather than imagined: list/detail/create screens per object,
  screens that flow steps need, and the common screens from the sweep in `coverage.md`.
- For each screen: purpose, the one primary action, the content in priority order with
  realistic examples and length ranges, the words on buttons and messages, and what differs
  by role.
- The states of every screen (`coverage.md`, check 3).
- A skeleton for the one to three screens that carry the main job: an ASCII wireframe of
  boxes and labels that shows grouping and reading order, with real content, inside a
  fenced code block marked `text` (the check script skips fences, so the boxes are not read as
  tables). No sizes,
  colours or styling; it shows priority, not appearance. Designers sketch these because a
  list of contents hides problems that a layout exposes (what is above the fold, what
  competes with the primary action).
- The first release: which flows and screens are needed for the main job to work end to
  end, and which can wait. A complete map is not a plan to build everything in it.
- Accessibility that structure decides: heading order, focus order, what is announced when
  content changes, nothing conveyed by colour alone, touch targets large enough for the
  people involved.

Write: the `ux:screens`, `ux:objects`, `ux:sweep` and `ux:states` tables, and a short note per
screen. Do not specify colours, fonts, sizes or layout styling; describe priority and grouping
instead ("the amount comes first and is the largest thing on the screen" is priority; "24px
bold" is styling and belongs to the implementer).

Done when: the skeletons and the first-release cut are written; the riskiest assumption
from S1 has a visible answer in the design (how the screens behave if it turns out wrong);
every `TBD` in the Screen column has become a screen ID; `scripts/check_package.py` passes;
and a read-through finds no colour, typeface, size, pixel value or exact position in the
screen notes (rewrite any as priority or grouping). Then confirm with the user: show the screen
list with each screen's purpose and ask whether anything is missing or unnecessary.

## S4 Experience principles

Settle:
- Tone, as a few words with what they rule out ("calm, never scolding").
- Three to five principles of the form "A even over B", each one choosing something the
  team will be worse at. A principle that every product could claim ("simple and
  delightful") decides nothing; drop it.
- Experiences to avoid, especially deceptive patterns and anything that shames or rushes.
- Recurring interaction patterns found across S3: how undo works, how errors are explained,
  how waiting is shown, how destructive actions are protected. List each with the screens
  that use it; this is the seed of a design system, extracted from real screens rather than
  invented upfront.

Do not choose colours, typefaces, spacing or visual references. If the user supplies brand
assets, record them for the brief unchanged.

Done when: each principle names what it sacrifices; each pattern lists the screens that use
it.

## S5 Hand-off

See `handoff.md`.

## Existing flows

When the request is to improve a flow that already exists, diagnose before redesigning:

1. For every step and field, first ask whether it needs to exist at all, and at this point
   in the journey; removing or postponing a step usually beats polishing it. Then map the
   current flow step by step, with its fields and messages, as a plain table
   without a `ux:` marker: the checks apply to the proposed flow, and current screens have
   no IDs. Number current steps `C-01`, `C-02`… so they cannot clash with proposed steps.
2. Ask for or locate data: completion per step, drop-off by device and traffic source,
   errors per field, support tickets, session recordings. Label what you get `[data: …]`.
3. Without data, propose what to measure and how (events per step and per field, a
   baseline period), and treat every proposed change as a hypothesis.
4. Review each step with the lenses (`lenses.md`), especially "why it is not happening",
   "now or later", "trust at the moment of giving" and "interruption".
5. Research conventions and rules that apply to the fields involved (how each kind of field
   is conventionally handled, and what the law requires to be collected and when).
6. Propose changes ranked by expected effect and effort. For each: the hypothesis, the
   metric it should move, a guardrail metric it must not harm, and how to test it (an A/B
   test where traffic allows, otherwise a before-and-after comparison).
7. Show the current and proposed flows side by side.

Keep what works; a full redesign is warranted only when the structure itself is the
problem.

## Package layout

Small: one file, `docs/ux/<slug>/UX.md`, with sections in stage order and the brief at the
top.

Medium or large:

```
docs/ux/<slug>/
  BRIEF.md       # the hand-off brief (handoff.md)
  STATE.md       # stage reached, decisions, open questions, searches used
  01-problem.md
  02-structure.md
  03-screens.md  # ux:screens, ux:objects, ux:sweep, ux:states
  04-principles.md
```

Write section headings in the user's language. The marker comments, IDs and the English
keys required by `coverage.md` stay as they are.
