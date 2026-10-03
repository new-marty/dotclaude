---
name: z-review-finding
description: Write a code review finding, a bug report, or an explanation of a defect so that a reader who has not opened the code understands it in one pass. Use it when showing review results to someone, reporting a problem in an issue or a PR comment, or explaining a defect found during investigation ("write up this finding", "report this bug", 「レビューコメントにして」). Not for writing the code itself, nor for the work of finding the problems.
---

<!-- Adapted from the "Per-item Template" section of
     https://github.com/p3bot/library/blob/main/tasks/review/pre-commit/task.md
     (Mozilla Public License 2.0).

     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at https://mozilla.org/MPL/2.0/. -->

# How to write a review finding

The reader has not opened the code. They can look nothing up on the spot, and they decide
something from a single read.

## Four steps

Start with the smallest concrete case that produces the problem, and put the explanation
after it. Do not reorder these.

1. **Show what it should be, and where it breaks.**
   If the code can be run, write one of these next to the expected value: the command and
   its output, the call and its return value, or the request and its response —
   `ParseDuration("500ms") → 0s (expected 500ms)`.
   If the change is structural and produces no output, describe in plain words the
   situation it breaks.
   If the behavior depends on a condition, contrast the two cases. That contrast is usually
   what makes the break visible.
2. **A simple explanation** — one or two sentences in everyday words. Not a single
   identifier. Name the problem, and leave out the chain of causes.
3. **What causes it**, using only the nouns from step 2. Introduce no new identifiers.
4. **What it costs.**

## Rules for writing it

- **Call things by what they are, not by their name in the code.** "The retry counter", not
  `svc.rc`. Identifiers and `file:line` are anchors in parentheses after a plain noun. Do
  not make them carry the explanation.
- **Expand an abbreviation on first use.** Requirement IDs, ticket numbers, and in-house
  abbreviations tell the reader nothing.
- **Write nothing you did not observe.** Put nothing in a code block but the output of a
  command you actually ran. When you cannot run it, describe the situation instead.
- **Keep the details to six lines.**
- **Do not argue that the finding is real, and do not restate the intent.** The concrete
  case and the explanation are enough.
- **Separate options with a blank line.** Do not fold them onto one line.

## Template

Four sections are required: the concrete case, the simple explanation, the details, and the
recommendation. Include "Decision" and "Options" only when laying them out makes the choice
clearer. A recommendation may combine options, as in `A + C`.

```markdown
### Issue n of m: <ID> <short title>

Category: <correctness / security / maintainability / …>
Location: <file:line>

<The smallest concrete case that produces the problem. A command and its output, a
request and its response, or a call and its return value, next to the expected
value. If nothing can be run, describe the situation the change breaks. Show it;
do not explain it.>

**Simple Explanation**

<One or two sentences in everyday words. No identifiers. No chain of causes, no options.>

**Details**

<Six lines or fewer of flowing text. What causes it and what it costs, in the same
plain words as above.>

**Decision**

<The single question being put to the reader>

**Options**

A. <what it does, and what it costs>

B. <option>

**Recommendation (B)**

<The letter chosen, and one passage on why. Choose what holds up over time, not the
expedient patch.>
```

## Example

```markdown
### Issue 1 of 1: M1 ParseDuration truncates sub-second values to zero

Category: correctness
Location: internal/timeutil/parse.go:42

  ParseDuration("500ms")  → 0s     (expected 500ms)
  ParseDuration("1500ms") → 1s     (expected 1.5s)

**Simple Explanation**

A duration under a second is silently truncated, so passing a 500-millisecond timeout
leaves you with no timeout at all.

**Details**

The result is assembled in whole seconds, so the millisecond remainder is dropped before
the duration value is built. A caller that passes a sub-second timeout ends up with a
timeout that never fires. The failure never surfaces: the call returns a value of the
right type, only with different contents.
```

## Heading translations

The output language follows the rules in `CLAUDE.md`. Use this table when translating.

| English | 日本語 |
| --- | --- |
| Issue n of m | 指摘 n / m |
| Category | 分類 |
| Location | 場所 |
| Simple Explanation | かんたんな説明 |
| Details | 詳細 |
| Decision | 決めること |
| Options | 選択肢 |
| Recommendation | 推奨 |
