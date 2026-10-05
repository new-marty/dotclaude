---
id: TASK-19
title: handbook のサイトで崩れて見える箇所を直す(5 件)
status: To Do
assignee: []
created_date: '2026-10-05 11:14'
labels: []
dependencies: []
priority: low
ordinal: 19000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
handbook(~/dev/handbook)の生成で、このリポの文書に、サイトで崩れて見える箇所が見つかった(2026-10-05 20:14 の生成)。直すのはこのリポの原稿。
一覧と直し方: ~/dev/handbook/backlog/docs/run-2026-10-04/handoff/dotclaude.md(場所はリポの中のパスと行)
- 箇条書きの直前に空行がない: リストにならず、前の段落の続きとして出る。空行を 1 つ入れる
- リンク切れ: 名前が変わったか場所が違うリンク。一覧に原因の見立てがある
GitHub では崩れない形もある(Zensical の描き方による)。直した後は handbook の次の生成で一覧から消える
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 一覧の箇所を直したか、直さない理由をノートに書いた
<!-- AC:END -->
