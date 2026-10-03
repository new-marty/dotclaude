---
id: TASK-2
title: Make z-write-task and z-start-task follow the project's tracker
status: In Progress
assignee:
  - '@claude-dotclaude'
created_date: '2026-10-03 08:36'
updated_date: '2026-10-03 11:54'
labels: []
dependencies: []
priority: medium
ordinal: 2000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Both skills assume GitHub Issues (gh issue). Projects here track work elsewhere, for example Backlog.md under backlog/ (this repository included). The skills should detect and use whichever tracker the project uses and fall back to GitHub Issues only when nothing else is in place.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 z-write-task files work items in the project's tracker (Backlog.md via the backlog CLI, GitHub Issues via gh, or another documented one)
- [ ] #2 z-start-task reads and updates tasks in the same tracker
- [ ] #3 How a skill detects the tracker is written in the skill (for example backlog/config.yml present, or a rule in the project's CLAUDE.md)
- [ ] #4 No remaining hard-coded gh issue assumption in either skill's workflow
<!-- AC:END -->
