---
name: z-write-task
description: Write an Epic, Story, Bug, or Task and file it on GitHub, so that a person can follow the work from the title alone and whoever picks it up later still decides the design from the code. Use it whenever the intent is to create or reshape work items — "file an issue", "turn this into a ticket", "break this story down", "write this up as an epic", 「Issue にして」「チケット切って」「タスクに分解して」「Epic を作りたい」. Use it as well when someone hands over a rough request and expects work items out of it, even if they never say the word issue. Not for writing the code, not for picking up work that already exists (`z-start-task`), and not for the pull request description (`z-create-pr`).
allowed-tools: Bash(gh issue *), Bash(gh search *), Bash(gh api *), Bash(git *), Read, Glob, Grep
---

# Write a work item

A work item is a placeholder for a conversation, not a specification. It carries what and
why. The how is decided when the work starts, by reading the code — which by then knows
things the writer did not.

This is the writing side of `z-start-task`, whose third principle tells the reader not to
trust an issue as a specification. Write items that earn that distrust: thin enough that
there is nothing stale to trust.

Nothing in this file is a gate on starting work. A checklist that has to be fully satisfied
before anyone may begin turns into pre-work that goes stale before it is used, which is the
failure this skill exists to prevent.

## The three levels

A level is defined by what it promises. The tracker field is only where that is recorded.

| Level | Promise | Acceptance criteria | Produces a PR |
| --- | --- | --- | --- |
| Epic | An outcome someone outside the team notices | None of its own — its children's, plus the outcome being observable | No |
| Story | One change in behavior that can be observed from outside | Required | Yes, one — unless it has children |
| Task | One PR's worth of a Story that turned out not to fit in one | Points at which of the parent's criteria it satisfies | Yes, one |

**The PR unit is the leaf.** A Story with no children is one PR. A Story with children is
no PR at all; each Task is one.

**Never create Tasks while filing.** At filing time nobody has read the code, so any split
made then can only follow the shape of the code — layers, modules, files — and produces
slices that individually ship nothing. Split after starting, when the implementation is in
view. Creating a Task is the act of declaring "this becomes a separate PR", so it carries
the burden of proof described under Splitting.

## Recording the level in the tracker

The levels above are promises. The type field is where they are recorded, and the two
vocabularies do not line up: each GitHub organization defines its own set, and Story and
Chore are usually absent from it. Read the set before filing:

```sh
gh api /orgs/<org>/issue-types --jq '.[] | [.name, .description] | @tsv'
```

Map by what the item does, not by what the level is called. Where an organization offers
Epic, Task, Bug and Feature:

| Level | Type to set |
| --- | --- |
| Epic | Epic |
| Story that changes what someone can do | Feature |
| Story that is refactoring or upkeep | Task |
| Task split out of a Story | Task |
| Bug | Bug |

Set the type on every issue, children included. Filing a parent with a type and leaving its
children without one is the common failure, and it is the worst one: an issue with no type
drops out of every query and rollup that filters by type, and the children are where the
work actually sits. A label saying `bugfix` does not stand in for the Bug type — the two
fields are read by different tools.

## Where each sentence goes

Every sentence has exactly one destination. Wanting to write one in two places means the
parent and child are cut in the wrong place.

```text
the sentence you are about to write
  │
  ├─ what is going wrong now, and for whom ──→ body, Problem
  ├─ the condition under which this is done ─→ acceptance criteria
  ├─ the larger purpose, or a relationship ──→ the parent, or a native field. Not the body
  ├─ something you found out ────────────────→ a comment, not the body
  ├─ how to build it ┬─ already decided ─────→ an ADR or the PR. A link at most
  │                  └─ not yet ─────────────→ nowhere. Decide it from the code at the start
  └─ something to do later, or while in there → nowhere. See "Something you noticed"
```

The body is the specification and changes only when the acceptance criteria change.
Comments are the record, and the platform dates them for you. A hand-written date rots; a
comment's does not.

## Titles

The grammar says which level it is, so nobody has to open it. Keep the type out of the
title — GitHub has a field for it.

```text
Epic   [invoice] Receive invoices without asking support
Story  [invoice] Download a single invoice as PDF
Task   [invoice] Return a generated PDF from the API
Bug    [invoice] The PDF total is shown excluding tax
Chore  [invoice] Move pdfkit to v3
```

- **Epic and Story: what becomes possible.** Not an instruction to build something — an
  imperative title invites the how back in through the front door.
- **Bug: the symptom as observed.** Not the fix and not the cause. The title is the part of
  a bug report that gets read most, and a title naming the fix loses the symptom for good.
- **Chore: the imperative.** Nothing changes for the user, so there is nothing to phrase as
  an outcome.
- **The prefix is the Epic's key**, decided when the Epic is filed and used by every
  descendant. It is a product-feature name, never a directory name: directories move,
  feature names do not. Siblings end up adjacent in any flat list.
- **Say one thing.** Joining two with "and" means the search for the word that covers both
  was abandoned. Look for that word: two defects in one directory are one non-conformance.
  If no such word exists, these are two items, not one title.
- **Use words the reader already has.** Layer names, internal vocabulary, and directory
  names describe the inside; the title is read from the outside. The prefix is the one
  exception, and it is a feature name for exactly that reason.
- About 60 characters, or 30 in Japanese. Over that, rewrite and move the detail into the
  body. Do not truncate. A title that lists what was wrong is always too long — listing is
  the body's job.

## Templates

Keep the body within 20 lines. The parent goes in the native field, not here.

```markdown
## Problem
<Three to five lines: what is happening now, and who it costs what>

## Desired outcome
<One or two lines: the state once this has shipped>

## Acceptance criteria
- [ ] <Observable from outside: a command and its result, or something a person can do>
- [ ] <…>

PR: 1
```

For a Bug, follow `z-review-finding` and use these headings: What happens (observed, not
inferred) / Steps to reproduce / Expected / Environment.

For an Epic: Outcome / Why now / Not in this epic (the nearest thing people will assume is
included) / Key (the title prefix every child will use).

For a Task: which of the parent's acceptance criteria it satisfies, and nothing else. The
one exception is a preparatory refactoring, which satisfies none of them; its completion
condition is that behavior is unchanged and the existing tests still pass.

## Numbers

A measured value written into a body turns the item into something to be reconciled — and
then the reconciling gets done, by someone, forever. Sort every number into one of three.

| Role | Example | How to write it |
| --- | --- | --- |
| Evidence — why this is worth doing | 40 support requests a month | One significant figure and a date: "around 40 a month (2026-09-18)". Do not sharpen it |
| Subject — what has to be changed | 43 files, 120 call sites | Do not write it. Write the command that produces it |
| Completion — whether it is done | all of them migrated | Write a predicate, not a count |

```markdown
## Current state
Calls to `InvoiceService.render` remain in places. Current count:
`rg -c 'InvoiceService\.render' src/`

## Acceptance criteria
- [ ] `rg 'InvoiceService\.render' src/` returns nothing
- [ ] The existing invoice PDF snapshot tests pass
```

A rounded figure cannot contradict a later measurement, so nothing has to be reconciled. A
predicate survives the work changing underneath it, and it is checkable, which is what an
acceptance criterion has to be anyway.

## Splitting

One Story is one PR by default. Splitting carries the burden of proof; a logical partition
is not a reason.

- **The vertical slice test.** If slice one needs slice two to work, that is not a split,
  only a reordering. Fold it back into one.
- **Structural and behavioral changes go in separate PRs.** This is the one split worth
  making on its own, and it is decidable: ask whether the diff changes behavior. A
  preparatory refactoring goes first, as its own Task.
- **Size is a smell, not a cut line.** Past about 400 lines, review stops catching things.
  Take that as a signal to look for the vertical line again — never split to hit a number.

## Something you noticed

Filing is not free. When items arrive faster than they are finished, the queue does not
settle at slightly larger; it compounds into a graveyard, and then nothing in it gets read.
So there are four exits, and filing is only one of them.

```text
something you noticed
  ├─ the acceptance criteria cannot be met without it → do it now (preparatory PR if structural)
  ├─ small, local, inside a file already open ────────→ do it now, in its own commit
  ├─ a TODO for it is already there ──────────────────→ file it
  └─ anything else ───────────────────────────────────→ leave a TODO at that spot, and move on
```

The TODO is what makes "the second time" decidable: the first encounter leaves one, and
finding one already there is the evidence that this recurs. Leave it only at the spot in a
file already open. Scattering TODOs elsewhere just moves the graveyard into the code.

Present what you sorted, filing and not filing alike, in the same approval as the items
themselves. Never file out of the fourth exit silently, and never file out of it twice.

The tidying allowance in one PR is 50 lines, or a third of the diff. Past that, it becomes
its own preparatory PR.

## References between items

Relationships go in native fields — parent, sub-issue, blocked-by, and `Closes` on the PR.
GitHub numbers issues and pull requests from one sequence, so `#123` on its own says
neither which kind it is nor which level; a native field renders the title instead, and it
never goes stale.

When a relationship has no field for it — a decision that rests on an earlier discussion,
an issue in another repository — write all three parts: `Story #11 Download a single
invoice as PDF`.

## Steps

1. **Establish the repository's premises.** Which issue types exist, whether Projects is in
   use, what language the existing issues are written in. Do not assume them; `GITHUB.md`
   has the commands.
2. **Search before writing.** Look for an item that already covers this, and for an Epic
   this belongs under. On a hit, say so and propose commenting on the existing item rather
   than filing beside it.
3. **Decide the level** from the promise, using the table above.
4. **Write the body**, within 20 lines. Read `z-writing-for-readers` first; add
   `z-japanese-proofreading` when writing in Japanese, and `z-review-finding` for a Bug.
5. **Run the checks below**, and fix what fails before showing anything.
6. **Show the title and body, and get approval.** Do not run `gh issue create` first.
7. **File it, then set the relationships in the native fields** — parent, type, blocked-by.
   Return the URL.

## Before filing

- [ ] The title is within about 60 characters (30 in Japanese), carries the Epic key, and
      names no identifier, ticket number, or issue type
- [ ] The body is within 20 lines
- [ ] Every acceptance criterion is observable from outside — a command, or something a
      person can do
- [ ] Every number is either rounded evidence with a date, a command, or a predicate
- [ ] There is no implementation plan and no list of file paths
- [ ] The parent appears in one place only: the native field, never also the body
- [ ] `PR: n` is stated, and `n` is 1 unless the split has passed the vertical slice test

## Heading translations

The output language follows the rules in `CLAUDE.md`. Use this table when translating.

| English | 日本語 |
| --- | --- |
| Problem | 課題 |
| Desired outcome | 望む状態 |
| Acceptance criteria | 受入条件 |
| Current state | 現状 |
| What happens | 起きていること |
| Steps to reproduce | 再現手順 |
| Expected | 期待する挙動 |
| Environment | 環境 |
| Outcome | 成果 |
| Why now | なぜ今か |
| Not in this epic | この Epic に含まないもの |
| Key | キー |
