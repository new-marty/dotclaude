---
id: TASK-4
title: Record that dotclaude is developed on multiple machines
status: Done
assignee: []
created_date: '2026-10-03 08:36'
updated_date: '2026-10-03 08:37'
labels: []
dependencies: []
priority: high
ordinal: 4000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Decided 2026-10-03: dotclaude is developed on more than one machine. The mac-mini develops in a separate clone, ~/dev/dotclaude, and pushes on request; its ~/.claude stays pull-only (05:00 pull). Tasks live in this repository's backlog/, not GitHub Issues.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 CLAUDE.md tells every agent to pull before editing, rebase onto origin/main before pushing, and never force-push
- [x] #2 README describes the mac-mini as pull-only in ~/.claude with development in ~/dev/dotclaude, and says the main machine pulls manually for now
- [x] #3 A SessionStart pull hook runs in the mac-mini's ~/dev/dotclaude clone via untracked project settings
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
CLAUDE.md now carries the pull/rebase/no-force-push rule, README describes ~/dev/dotclaude and the pull-only ~/.claude on the mac-mini, and an untracked SessionStart pull hook in .claude/settings.local.json was tested in the clone. Follow-ups: tasks 1 to 3.
<!-- SECTION:FINAL_SUMMARY:END -->
