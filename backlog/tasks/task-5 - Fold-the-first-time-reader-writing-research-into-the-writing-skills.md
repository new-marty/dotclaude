---
id: TASK-5
title: Fold the first-time-reader writing research into the writing skills
status: Done
assignee:
  - '@claude-server'
created_date: '2026-10-03 08:39'
updated_date: '2026-10-03 10:08'
labels: []
dependencies: []
priority: high
ordinal: 5000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Marty, 2026-10-03, decided this belongs in dotclaude for every machine. The research was done on the mac-mini and lives at ~/server/research/2026-10-03-writing-for-first-readers.md (github.com/new-marty/macmini-server, private). It answers Marty's position: however correct a document is, if it is not read or understood it is as good as absent; explaining hard parts a little more abstractly, in prose, with fewer IDs and commands, is the right trade-off, as long as nothing written is wrong.

What the research found (Japanese public-document guidance, Google/Microsoft style guides, Diataxis, NN/g, plain-language guides): (1) define the reader and give only what they lack, and say up front who it is for, what it covers and leaves out; (2) do not pack in every detail: move secondary detail to another document and link to it (the Japanese public-document guidance names 'trying to be exact makes writers cram in everything' as the failure); (3) conclusion and the why first; (4) internal IDs (task numbers, decision numbers) are not written in prose; when the reader should follow the record, describe it in words and make those words the link (Marty's rule, 2026-10-03; no style guide addresses internal IDs directly); acronyms and terms are explained on first use and kept fixed; (5) abstraction is acceptable only when the detail is not needed for the reader's purpose and the meaning and scope do not change; procedures, safety information and numbers are never abstracted and stay exact in their own documents; (6) split documents by purpose (explanation, how-to, reference; Diataxis and JIS Z 82079-1); (7) readability scores are not comprehension: test with a reader. The research proposes eight rules for explanation documents.

Work: write these principles into the machine-independent writing skills, mainly z-writing-for-readers, and check that z-natural-japanese, z-japanese-proofreading and z-gemini-write do not contradict them (for example, any rule that keeps every fact or every ID). Decide where agent-facing text (memory, skills, CLAUDE.md) differs from human-facing documents: agents often need IDs and exact commands. The mac-mini task T-444 asked the same question for its own memory, documents and skills; this task covers the shared skills.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 z-writing-for-readers states the principles above, citing the research by what it is (not by ID) with sources
- [x] #2 The other writing skills were checked against the principles, and any contradiction was fixed or recorded with a reason
- [x] #3 The skills say how agent-facing text (memory, SKILL.md, CLAUDE.md) differs from documents written for people, with the reason
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
z-writing-for-readers now has rules for titles and openings (title says the subject; open only with assumed knowledge and what is left out), record numbers by kind of document (words + link in explanations; number + a few words in records, runbooks and agent text), abstraction limits, one purpose per document, a reader test, and a Text for agents section. Sources in references/sources.md (no style guide covers internal IDs; that rule is Marty's). Checked z-natural-japanese, z-japanese-proofreading, z-cognitive-rhythm-writing, z-gemini-write and z-humanizer; conflicts fixed in their local sections. Not done: a reader test of the new rules on a real document. Commit 57a1168.
<!-- SECTION:FINAL_SUMMARY:END -->
