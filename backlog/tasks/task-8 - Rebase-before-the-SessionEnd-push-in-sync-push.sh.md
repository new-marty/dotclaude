---
id: TASK-8
title: Rebase before the SessionEnd push in sync-push.sh
status: Done
assignee:
  - '@claude-dotclaude'
created_date: '2026-10-03 08:59'
updated_date: '2026-10-03 12:09'
labels: []
dependencies: []
priority: medium
ordinal: 8000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
scripts/sync-push.sh runs `git push origin HEAD:main` with no fetch or rebase. Now that the mac-mini also pushes (from ~/dev/dotclaude), a session on the main machine that started before such a push ends with a non-fast-forward rejection. The script only prints the error to stderr and the statusline shows the unpushed count, so the commits can stay local unnoticed until a later session's SessionStart pull. The CLAUDE.md rule says to rebase before pushing; the script does not. Found in code review of the multi-machine change (TASK-4). Relates to TASK-3 (no SessionStart pull hook on the main machine yet, which makes this more likely).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 sync-push.sh fetches and rebases onto origin/main before pushing, and stops (without pushing) if the rebase conflicts
- [x] #2 A non-fast-forward or conflict outcome is visible to the user, not only on stderr
- [x] #3 Tested with two clones: a push from one while the other has unpushed commits
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03: fetch+rebase before push, abort and exit 2 on conflict, marker .git/claude-sync-diverged shown by statusline; scripts/test-sync-push.sh (two clones). Independently verified. Hook timeout 30 in settings.example.json; per-machine settings tracked separately.
<!-- SECTION:NOTES:END -->
