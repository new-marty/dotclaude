---
id: TASK-16
title: Support pull-only devices with local customisations
status: Done
assignee:
  - '@claude-dotclaude'
created_date: '2026-10-03 15:01'
updated_date: '2026-10-03 17:51'
labels: []
dependencies:
  - TASK-17
priority: high
ordinal: 16000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Marty, 2026-10-04: wants to use dotclaude on the company PC, which can basically only pull (no push) and will probably pull by hand. Local customisations there must survive pulls; today they would conflict whenever a tracked file is edited locally. Plan for more devices like it. Design goal under review: every local customisation lives outside tracked files (an override layer that pulls never touch), so a pull cannot conflict; plus a safe manual update command and a way to see the device is behind. Existing pieces: settings.json per machine (untracked), CLAUDE.md imports @~/.claude/CLAUDE.machine.md, sync-pull.sh (--autostash), .claude-plugin marketplace for skills.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Design agreed with Marty: where each kind of local customisation lives (instructions, settings, skills, output styles, statusline) and how a pull-only device updates
- [x] #2 Implemented and documented in README (a 'pull-only device' section)
- [x] #3 Tested on a scratch clone: local customisations plus an upstream change to the same area, pulled by the manual command, end with no conflict and both changes in effect
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-04: design agreed (backlog/docs/design-pull-only-devices.md rev 6). mac-mini side filed in ~/server.

2026-10-04: implemented per design rev 6 (5dfe644, 165ec3d): .gitignore device block, role-aware sync-pull/sync-push/statusline, test-pull-only.sh, README 'Pull-only devices'. Two independent inspections; scripts/test-sync-push.sh and test-pull-only.sh pass on main (12 ok, /bin/bash). The mac-mini opt-in is ~/server T-479. Not tested on a real company Mac.
<!-- SECTION:NOTES:END -->
