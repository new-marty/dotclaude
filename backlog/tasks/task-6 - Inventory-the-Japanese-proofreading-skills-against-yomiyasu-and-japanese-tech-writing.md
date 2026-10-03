---
id: TASK-6
title: >-
  Inventory the Japanese proofreading skills against yomiyasu and
  japanese-tech-writing
status: To Do
assignee: []
created_date: '2026-10-03 08:39'
labels: []
dependencies: []
priority: medium
ordinal: 6000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Marty, 2026-10-03, asked for an inventory of the Japanese writing and proofreading skills. Two articles to start from: https://qiita.com/inoyu-qiita/items/0ffe6e74ecaf3aaa8b14 compares three skills on the same source text (yomiyasu, natural-japanese, japanese-tech-writing) and concludes the right one depends on what you want to fix; https://zenn.dev/algoartis/articles/0b1c731881b25c introduces yomiyasu, which works on sentence structure rather than banned words (inanimate subjects, metaphorical verbs, over-nominalisation, formatting inflation such as needless bold and bullets, invented negative contrasts), based on an analysis of about 70,000 Qiita articles.

Candidates: yomiyasu (https://github.com/nanaism/yomiyasu), japanese-tech-writing (https://gist.github.com/k16shikano/fd287c3133457c4fd8f5601d34aa817d), upstream natural-japanese (https://github.com/coji/natural-japanese, vendored here as z-natural-japanese at commit 9a78a42). Ours: z-natural-japanese, z-japanese-proofreading, z-writing-for-readers, z-gemini-write, z-cognitive-rhythm-writing.

Read the candidates before adopting anything (the mac-mini rule: read a skill's contents before installing it). Run them on the same two or three of our own documents and compare. Decide for each: adopt, merge parts into ours, or leave. Check overlap and contradictions among ours, and how they fit the first-time-reader principles in the task above.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Each candidate and each of our Japanese writing skills has a row: what it fixes, overlap with the others, and a decision (adopt, merge, leave, retire) with the reason
- [ ] #2 The comparison ran the skills on the same documents, and the before/after is kept with the decision
- [ ] #3 Adopted or merged parts are in the repo with their licence and upstream notice recorded in ADOPTIONS.md and THIRD_PARTY_NOTICES.md
<!-- AC:END -->
