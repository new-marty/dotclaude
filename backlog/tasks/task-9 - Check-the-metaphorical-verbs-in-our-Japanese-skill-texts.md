---
id: TASK-9
title: Check the metaphorical verbs in our Japanese skill texts
status: In Progress
assignee:
  - '@claude-server'
created_date: '2026-10-03 10:08'
updated_date: '2026-10-03 10:24'
labels: []
dependencies: []
priority: low
ordinal: 9000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
yomiyasu's author found that skills written with metaphorical verbs (効く, 渡す, 倒す) leak them into output. A string count on 2026-10-03 over z-natural-japanese, z-japanese-proofreading, z-writing-for-readers, z-cognitive-rhythm-writing and z-gemini-write found 効く 20, 渡す/渡し 22, 倒す/倒し 5, including literal uses. Check each hit; rewrite metaphorical ones in skills we wrote. z-natural-japanese's body is upstream's and stays as is.
<!-- SECTION:DESCRIPTION:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03 check (no edits): our own skills have 6 metaphorical uses — z-japanese-proofreading:54 (渡される), z-cognitive-rhythm-writing:51 (橋渡し), :66 :68 :82 :84 (着地させる). Proposed rewrites are in the session report; z-writing-for-readers, z-orchestrate, z-gemini-write have none. z-natural-japanese (upstream body) has ~60 metaphorical hits (効く 21, 渡す, 倒す, 溶ける, ループを回す); body stays as is. Open: whether to apply the 6 rewrites, and whether the quoted bad examples (proofreading:71, :77) should also go. Waiting on Marty.
<!-- SECTION:NOTES:END -->
