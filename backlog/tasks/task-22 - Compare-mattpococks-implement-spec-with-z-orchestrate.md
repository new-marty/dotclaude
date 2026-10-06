---
id: TASK-22
title: Compare mattpocock's /implement-spec with z-orchestrate
status: To Do
assignee: []
created_date: '2026-10-06 09:41'
labels: []
dependencies: []
priority: low
ordinal: 22000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
mattpocock/skills v1.3 added /implement-spec: it walks a ticket dependency graph, starts one implementer subagent per unblocked ticket in its own worktree (/tdd), lands each on one integration branch through a merger subagent, then runs /code-review and a fixer on the whole branch. The author says a deterministic script loop is better, and offers this as a starting point for AFK work. z-orchestrate covers parallel agents in general. Check whether the frontier/merger/integration-branch pattern should go into z-orchestrate. Source: Matt Pocock's skills v1.3 changelog, https://www.aihero.dev/skills/skills-changelog-v13-implement-spec-pr-retro-and-glossary-md (read 2026-10-06).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Differences from z-orchestrate listed
- [ ] #2 Decision recorded in ADOPTIONS.md (adopt parts or decline)
<!-- AC:END -->
