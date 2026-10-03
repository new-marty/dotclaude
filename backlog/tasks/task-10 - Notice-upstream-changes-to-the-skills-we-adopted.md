---
id: TASK-10
title: Notice upstream changes to the skills we adopted
status: In Progress
assignee:
  - '@claude-server'
created_date: '2026-10-03 10:08'
updated_date: '2026-10-03 10:27'
labels: []
dependencies: []
priority: medium
ordinal: 10000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
On 2026-10-03 the inventory found japanese-tech-writing had changed on 2026-09-09 and nobody noticed. ADOPTIONS.md now records the upstream revision for yomiyasu, japanese-tech-writing and natural-japanese. Decide how a change upstream gets noticed on every machine (a script that compares recorded revisions with upstream heads, run on a schedule or on demand).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 An on-demand script reports, for each adopted upstream, whether it moved since the recorded revision
- [ ] #2 Marty decided where it runs on a schedule (or that it stays manual), and that is set up
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03: scripts/check-upstream.sh and scripts/upstream.tsv added (on demand, not scheduled). First run: yomiyasu, the japanese-tech-writing gist and natural-japanese current; z-humanizer changed upstream (9862685 -> 225a6f3), not yet reviewed. Open: where it runs on a schedule (SessionStart hook, each machine's sync job, or by hand monthly) — Marty's call.
<!-- SECTION:NOTES:END -->
