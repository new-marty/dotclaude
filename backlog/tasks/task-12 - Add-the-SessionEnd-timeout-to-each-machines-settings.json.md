---
id: TASK-12
title: Add the SessionEnd timeout to each machine's settings.json
status: Done
assignee: []
created_date: '2026-10-03 12:09'
updated_date: '2026-10-03 14:51'
labels: []
dependencies: []
priority: medium
ordinal: 12000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
settings.example.json now gives the sync-push SessionEnd hook "timeout": 30 (SessionEnd hooks share a 1.5 s budget by default, https://code.claude.com/docs/en/hooks). settings.json is per machine and untracked, so each machine that registers sync-push.sh needs the same field, or fetch+rebase+push (TASK-8) can be cancelled before it warns.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Every machine whose settings.json registers sync-push.sh on SessionEnd has timeout 30 on that hook
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03: the mac-mini registers no sync-push hook (checked ~/.claude/settings.json), so only the main machine (macbook-pro) needs it; it was offline in Tailscale. Waiting for Marty.

2026-10-03: macbook-pro (hostname Marty): added "timeout": 30 to the SessionEnd sync-push.sh hook in ~/.claude/settings.json; backup at settings.json.bak-20261003-task12. jq . parses it; diff against the backup shows only that field; the other hooks (Orca's included) are unchanged in count. Not verified: that a SessionEnd push now completes within the timeout.
<!-- SECTION:NOTES:END -->
