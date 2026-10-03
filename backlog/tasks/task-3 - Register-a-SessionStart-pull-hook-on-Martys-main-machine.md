---
id: TASK-3
title: Register a SessionStart pull hook on Marty's main machine
status: Done
assignee: []
created_date: '2026-10-03 08:36'
updated_date: '2026-10-03 14:56'
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
- [x] #2 A new session there pulls origin/main without a manual step (checked by starting a session after a remote change)
- [x] #3 README no longer says the main machine pulls manually
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03: macbook-pro offline in Tailscale; needs Marty at that machine.

2026-10-03: the main machine's session reports sync-pull.sh is already registered on SessionStart there (AC#1, reported, not seen from the mac-mini). README sentence fixed in this commit (AC#3). Same session reported that its ~/.claude lacks backlog/ and the README sentence, both on origin/main since 17:36-17:37 (7a1b629, 1ea9625): its ~/.claude looks stuck before them, so the pull may be failing there. AC#2 open: this commit is the test push.

2026-10-03 correction: the main machine's pull was not failing. Its session started at 17:09, before 7a1b629 (17:36); HEAD was f6802ea, 45 behind, no local-only commits, no claude-sync-diverged marker. A manual sync-pull.sh exited 0 and reached 77a469b. AC#2 still needs a new session there that pulls this commit on its own.

2026-10-03: AC#2 verified on macbook-pro (hostname Marty). With HEAD at 77a469b and no manual pull, a new session opened at 23:55 JST; the reflog shows 'pull --rebase --autostash: Fast-forward' to ecc5f22 at 23:55:44, and git -C ~/.claude log --oneline -1 in that session printed ecc5f22, equal to origin/main after fetch. Uncommitted local edits survived the autostash.
<!-- SECTION:NOTES:END -->
