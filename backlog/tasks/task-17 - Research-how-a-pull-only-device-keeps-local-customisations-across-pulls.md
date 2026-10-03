---
id: TASK-17
title: Research how a pull-only device keeps local customisations across pulls
status: In Progress
assignee:
  - '@claude-dotclaude'
created_date: '2026-10-03 15:46'
updated_date: '2026-10-03 15:47'
labels: []
dependencies: []
priority: high
ordinal: 17000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Feeds TASK-16. Facts from Marty (2026-10-04): the company PC is a Mac, can pull from GitHub, cannot push; Claude Code runs there, but whether hooks or scripts are allowed is unknown; local customisations are work-specific skills and CLAUDE.md content, possibly edits to shared skills too; conflicts are accepted but must be easy to resolve each time. Research: (1) established ways to keep a local layer on top of a shared config repo (overlay/.local files, a local branch rebased on upstream with git rerere, patch queues such as quilt/stgit/format-patch, skip-worktree/assume-unchanged, chezmoi/yadm/stow, submodule/subtree), each judged on conflict rate, effort per update, what happens to upstream changes in a file edited locally, and need for extra tools; (2) Claude Code mechanics that make a layer possible (CLAUDE.md imports, rules/, skill name precedence, plugins from a git marketplace over https, --plugin-dir, managed settings a company may impose); (3) experiments on a scratch clone for the top candidates.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Options compared in a written table with sources, judged on the criteria in the description
- [ ] #2 Top 2-3 candidates tried on a scratch clone with a real upstream change, results recorded
- [ ] #3 A design document for TASK-16 written from the results and shown to Marty
<!-- AC:END -->
