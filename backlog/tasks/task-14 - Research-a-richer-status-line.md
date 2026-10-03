---
id: TASK-14
title: Research a richer status line
status: Done
assignee: []
created_date: '2026-10-03 14:33'
updated_date: '2026-10-03 14:40'
labels: []
dependencies: []
priority: low
ordinal: 14000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Marty, 2026-10-03: research whether the status line can show more, and show him the good options before changing anything. Current: statusline.sh, registered in settings.example.json.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Options found (Claude Code's statusline input fields, published statuslines) were compared with the current statusline.sh, each with what it shows and what it costs
- [x] #2 Marty saw a preview of the recommended options and chose
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03 research (subagent, sources: https://code.claude.com/docs/en/statusline, gh api for tools): unused stdin fields include effort.level, fast_mode, cost.total_duration_ms / lines added/removed / total_cost_usd, prompt_cache (warm, ttl, expires_at, hit_ratio; v2.1.251+, this mac-mini runs 2.1.288), pr.number/url/review_state, session_name, worktree.*, agent.name, context_window_size; statusLine.refreshInterval exists. Published: ccstatusline (13.2k, Node/Bun, 200-630 ms per render by its README), claude-powerline (1.17k, Node), CCometixLine (Rust, stale since 2026-03), ccusage statusline (beta). Not recommended wholesale: they drop our account, billing and ~/.claude sync segments. Measured here: current statusline.sh about 420 ms per render (5 runs, 2.1 s); a one-jq prototype of the new segments about 35 ms. Prototype: proto.sh in the session scratchpad (not kept).

2026-10-03: Marty saw the before/after preview and chose none of the additions. Nothing changed in statusline.sh.
<!-- SECTION:NOTES:END -->
