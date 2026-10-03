---
id: TASK-7
title: >-
  Research orchestration skills, including Orca's, and turn the useful parts
  into a skill
status: To Do
assignee: []
created_date: '2026-10-03 08:39'
labels: []
dependencies: []
priority: medium
ordinal: 7000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Marty, 2026-10-03, asked to research orchestration skills, either the one Orca ships or ones published elsewhere, and make a skill from them. Orca symlinks four skills into skills/ on the machine where it runs, one of them named orchestration (README, ADOPTIONS.md); it is untracked and its contents have not been read here.

Background from the mac-mini: on 2026-09-30 to 10-03 a document rewrite was run as many background agents in stages (fact list, check and write, independent inspection and fix), first by hand with the Agent tool and then with the Workflow tool's pipeline. Lessons worth carrying: write each stage's brief to a file and point agents at it instead of repeating it; one agent per stage per document; an independent final inspector that sees only the original and the result; record each document's state in one table; agents must commit only their own paths in a shared working tree; give each agent its own commit attribution line.

Work: read Orca's orchestration skill and at least two published orchestration skills or guides (for example Anthropic's guidance on multi-agent work, community skills for Claude Code). Compare with how we actually orchestrate. Write a z- skill that says when to fan out, how to brief agents, how to verify their results, and how to record progress so nothing is lost between sessions.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Orca's orchestration skill and at least two outside sources were read, with what each recommends and where it fits
- [ ] #2 A skill exists in skills/ that covers when to orchestrate, how to brief and verify agents, and how to record progress, citing its sources
- [ ] #3 The skill was used once on a real task and adjusted from what happened
<!-- AC:END -->
