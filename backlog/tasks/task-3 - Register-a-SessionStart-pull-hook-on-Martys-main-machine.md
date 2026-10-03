---
id: TASK-3
title: Register a SessionStart pull hook on Marty's main machine
status: To Do
assignee: []
created_date: '2026-10-03 08:36'
labels: []
dependencies: []
priority: low
ordinal: 3000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Marty's main machine has no SessionStart pull hook for ~/.claude; it pulls manually. settings.json is per machine and untracked, and settings.example.json already registers scripts/sync-pull.sh on SessionStart. Add that hook to the machine's settings.json, then update the README statement that this machine pulls manually.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 The main machine's settings.json registers scripts/sync-pull.sh on SessionStart
- [ ] #2 A new session there pulls origin/main without a manual step (checked by starting a session after a remote change)
- [ ] #3 README no longer says the main machine pulls manually
<!-- AC:END -->
