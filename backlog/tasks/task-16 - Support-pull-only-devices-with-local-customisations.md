---
id: TASK-16
title: Support pull-only devices with local customisations
status: To Do
assignee: []
created_date: '2026-10-03 15:01'
labels: []
dependencies: []
priority: high
ordinal: 16000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Marty, 2026-10-04: wants to use dotclaude on the company PC, which can basically only pull (no push) and will probably pull by hand. Local customisations there must survive pulls; today they would conflict whenever a tracked file is edited locally. Plan for more devices like it. Design goal under review: every local customisation lives outside tracked files (an override layer that pulls never touch), so a pull cannot conflict; plus a safe manual update command and a way to see the device is behind. Existing pieces: settings.json per machine (untracked), CLAUDE.md imports @~/.claude/CLAUDE.machine.md, sync-pull.sh (--autostash), .claude-plugin marketplace for skills.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Design agreed with Marty: where each kind of local customisation lives (instructions, settings, skills, output styles, statusline) and how a pull-only device updates
- [ ] #2 Implemented and documented in README (a 'pull-only device' section)
- [ ] #3 Tested on a scratch clone: local customisations plus an upstream change to the same area, pulled by the manual command, end with no conflict and both changes in effect
<!-- AC:END -->
