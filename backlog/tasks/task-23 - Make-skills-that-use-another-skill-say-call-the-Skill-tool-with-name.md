---
id: TASK-23
title: Make skills that use another skill say 'call the Skill tool with <name>'
status: To Do
assignee: []
created_date: '2026-10-06 09:41'
labels: []
dependencies: []
priority: medium
ordinal: 23000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
mattpocock/skills v1.3 changed every skill-to-skill reference from 'run the /grilling skill' to 'Call the Skill tool with "grilling"', because naming a skill in prose did not reliably load it. Check how our skills refer to each other (z-writing-for-readers -> z-humanizer / z-natural-japanese, z-create-pr, z-start-task, and so on) and whether the same failure applies here. Note: a skill cannot call a user-invoked (disable-model-invocation) skill. Source: Matt Pocock's skills v1.3 changelog, https://www.aihero.dev/skills/skills-changelog-v13-implement-spec-pr-retro-and-glossary-md (read 2026-10-06).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Every skill-to-skill reference in skills/ listed with file:line
- [ ] #2 References that should load the other skill use the Skill-tool wording; user-invoked targets tell the user to run them instead
<!-- AC:END -->
