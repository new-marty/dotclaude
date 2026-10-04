---
id: TASK-18
title: Answer chat in the user's language even after a skill loads
status: Done
assignee: []
created_date: '2026-10-04 07:28'
updated_date: '2026-10-04 07:30'
labels: []
dependencies: []
ordinal: 18000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The chat-language rule lived only in output-styles/concise.md, which is inactive on machines whose settings.json has no outputStyle (mac-mini). Move it to CLAUDE.md so every session loads it.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 CLAUDE.md states the chat-language rule, including that skill text does not count as the user's message
- [x] #2 concise.md no longer duplicates it
<!-- AC:END -->
