---
id: TASK-13
title: 'Review skills against how they were actually used, on a schedule'
status: To Do
assignee: []
created_date: '2026-10-03 12:59'
updated_date: '2026-10-03 14:33'
labels: []
dependencies: []
priority: medium
ordinal: 13000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Marty, 2026-10-03: wants to review and update skills periodically. Today TASK-7 AC#3 did this by hand for z-orchestrate: find sessions that invoked the skill (jq over ~/.claude/projects/*/*.jsonl for Skill tool_use with input.skill), give one read-only agent per transcript a brief (backlog/docs/orchestration-2026-10-03-run2.md, 'usage review'), and apply only changes backed by an incident in a transcript. 4 transcripts gave about 20 candidate changes. Open: which skills (z-orchestrate only, or every skill with enough uses since the last review); cadence and trigger (monthly-ops on the mac-mini, a count of new uses, or by hand); transcripts are per machine and deleted after cleanupPeriodDays (default 30, settings.example.json sets 14), so the main machine's uses are invisible from the mac-mini; cost per review (today about 350k subagent tokens for 4 transcripts); who approves the edits (agent proposes a diff, Marty approves). Check first whether Claude Code or published skills already offer usage review (e.g. /insights, skill evals) before building one.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Decided with Marty: scope, cadence, trigger and approval step
- [ ] #2 A repeatable procedure (skill or script) finds the uses of a skill since its last review and produces incident-backed change proposals
- [ ] #3 First scheduled or triggered run happened and its proposals were reviewed
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03: Marty: on hold for now (scope not decided).
<!-- SECTION:NOTES:END -->
