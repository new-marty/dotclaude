---
id: TASK-20
title: Consider adding Evidence and Merge Danger sections to z-create-pr
status: To Do
assignee: []
created_date: '2026-10-06 09:41'
labels: []
dependencies: []
priority: medium
ordinal: 20000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
mattpocock/skills v1.3 added /pr, a PR body template in three parts: Summary as the smallest visual (from humanlayer's show-me, which z-show-me also came from), Evidence as a before/after (a test that failed and now passes), and Merge Danger (one-way or two-way door, and blast radius) so the reviewer knows where to spend time. z-create-pr follows the repository's template. Decide which of these parts fit it without overriding a repo's own template. Source: Matt Pocock's skills v1.3 changelog, https://www.aihero.dev/skills/skills-changelog-v13-implement-spec-pr-retro-and-glossary-md (read 2026-10-06).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Each of the three sections is compared with what z-create-pr already asks for, with a keep/adopt/decline call
- [ ] #2 Adopted parts are in z-create-pr and recorded in ADOPTIONS.md; declined ones are listed there too
<!-- AC:END -->
