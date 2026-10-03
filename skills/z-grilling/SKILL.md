---
name: z-grilling
description: >-
  Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrase. Also triggers on Japanese: 「grill me」「壁打ちして」「この計画を詰めたい」「穴がないか叩いて」など、案を検証したい意図があれば呼ぶ。
---

<!-- The design comes from grilling in https://github.com/mattpocock/skills (MIT,
     Copyright (c) 2026 Matt Pocock); the question format is SOCCR from
     https://jacobian.org/2021/jan/30/soccr/. Upstream asks the whole frontier in one
     round; this version asks one question at a time. Upstream's body is not carried over,
     so the two cannot contradict each other. -->

Keep asking until you reach agreement. Hold the decisions as a tree: settling one decision
opens up the decisions hanging below it. Only ask decisions whose premises are already
settled.

## How to ask

One question at a time. Send the next one after the answer comes back. Never list them
together. Put the ones whose answers become premises for other questions first.
End each question with `<n> questions left`.

Finish researching a question before you send it. Researching after asking, and changing
the premises, makes the user answer the same question twice. Push questions that need
research into a later round and send the ones that do not first.

The user decides; you gather the facts. If no answer comes back, stop there. Do not fill in
the answer yourself.

## Format

```
❓ **<title>**

<Situation: the facts your research established. Do not argue yet. The reader knows
neither your research nor your reasoning, so do not skip the path that led there>

<Criteria: what the choice will be judged on. Comes before the options>

<Options: at most five, including the status quo. Only options you would genuinely back —
no straw men. Say what changes if each one is chosen>

➡️ **Recommendation**: <state it outright. Do not write "I think maybe X would be good">

<n> questions left
```

Check before sending. Rewrite if any of these hold.

- The recommendation cannot be found without reading to the end
- The background runs longer than the analysis
- It ends on "both have their pros and cons"
- It does not say what you want decided
- A straw man you would not back is mixed in

## When the user cannot answer

Do not withdraw the question. Classify why it cannot be answered, tell the user the
classification, and name the command to type. All three are user-invoked skills, so never
invoke them yourself.

| Reason | Hand off to | What comes back |
| --- | --- | --- |
| Does not know an underlying mechanism or term | `/z-teach` | What was learned |
| Outside their remit, or needs information only someone else holds | `/z-to-questionnaire` | The filled-in questionnaire |
| Cannot be known without building and running it | `/z-prototype` | The result of the experiment |

Leave that question open and move ahead with the questions that do not depend on it. When
the user returns, present the evidence they brought back as the premise and ask the same
question again.

Do not fill gaps with guesses. A guess becomes a specification, then a ticket, then an
implementation.

When the user says "your call", do not branch. Take your recommendation, proceed, and write
down what you assumed.
