---
id: TASK-3
title: Register a SessionStart pull hook on Marty's main machine
status: To Do
assignee: []
created_date: '2026-10-03 08:36'
updated_date: '2026-10-03 14:41'
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
- [x] #1 The main machine's settings.json registers scripts/sync-pull.sh on SessionStart
- [ ] #2 A new session there pulls origin/main without a manual step (checked by starting a session after a remote change)
- [x] #3 README no longer says the main machine pulls manually
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03: macbook-pro offline in Tailscale; needs Marty at that machine.

2026-10-03: the main machine's session reports sync-pull.sh is already registered on SessionStart there (AC#1, reported, not seen from the mac-mini). README sentence fixed in this commit (AC#3). Same session reported that its ~/.claude lacks backlog/ and the README sentence, both on origin/main since 17:36-17:37 (7a1b629, 1ea9625): its ~/.claude looks stuck before them, so the pull may be failing there. AC#2 open: this commit is the test push.
<!-- SECTION:NOTES:END -->
