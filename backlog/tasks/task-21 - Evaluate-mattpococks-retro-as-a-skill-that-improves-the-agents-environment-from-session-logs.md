---
id: TASK-21
title: >-
  Evaluate mattpocock's /retro as a skill that improves the agent's environment
  from session logs
status: To Do
assignee: []
created_date: '2026-10-06 09:41'
updated_date: '2026-10-06 10:47'
labels: []
dependencies: []
priority: medium
ordinal: 21000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
mattpocock/skills v1.3 added /retro: it reads a past coding session and proposes changes to the agent's environment, not the code (navigation, automated checks, coding standards, AGENTS.md health, tool cost, no-op instructions, missing information). Mechanical violations become deterministic checks; prose rules are kept for judgement calls. It is human-in-the-loop by design; the author warns against automating it. This matches the mac-mini rule 'mechanisms over prose'. Read the upstream skill and decide whether to adopt it, and how it relates to existing review/wrap-up habits. Source: Matt Pocock's skills v1.3 changelog, https://www.aihero.dev/skills/skills-changelog-v13-implement-spec-pr-retro-and-glossary-md (read 2026-10-06).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Upstream SKILL.md read; overlap with existing skills and ~/server checks noted
- [ ] #2 Decision (adopt, adapt, decline) recorded in ADOPTIONS.md
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-06 Marty: also weigh the option of aligning with the existing upstream skill as is (install or copy mattpocock's version) instead of folding parts into ours.
<!-- SECTION:NOTES:END -->
