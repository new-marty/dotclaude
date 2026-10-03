---
id: TASK-15
title: Surface a failed commit in sync-push.sh
status: To Do
assignee: []
created_date: '2026-10-03 14:57'
labels: []
dependencies: []
priority: medium
ordinal: 15000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
2026-10-03 on the main machine: commits are signed through 1Password (commit.gpgsign=true, ssh); with 1Password not answering, git commit failed ('failed to write commit object'). sync-push.sh runs git commit at line 50 without checking the result: the changes stay staged, no claude-sync-diverged marker is written, and the statusline's unpushed count (commits only) shows nothing. A machine's edits then silently never reach the others. Decide how to surface it (write the marker with the reason, and/or count staged-but-uncommitted changes in the statusline), and check whether a commit can be retried at the next SessionStart.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 A failed commit in sync-push.sh leaves a visible signal at the next session, with the reason
- [ ] #2 Tested on a scratch clone with a commit forced to fail (e.g. an invalid signing key), not on ~/.claude
<!-- AC:END -->
