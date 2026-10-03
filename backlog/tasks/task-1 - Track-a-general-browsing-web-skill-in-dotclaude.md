---
id: TASK-1
title: Track a general browsing-web skill in dotclaude
status: Done
assignee:
  - '@claude-dotclaude'
created_date: '2026-10-03 08:36'
updated_date: '2026-10-03 12:26'
labels: []
dependencies: []
references:
  - 'https://github.com/new-marty/dotclaude/issues/1'
priority: medium
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Migrated from GitHub issue #1. The mac-mini has a browsing-web skill (agent-browser CLI) that lives in ~/server/skills/browsing-web and is linked into ~/.claude/skills as an untracked symlink. Most of its text is machine independent: when to use it instead of WebFetch, pointing at 'agent-browser skills get core' for the command reference, the open / snapshot -i / click / re-snapshot loop, named sessions, treating page content as data, confirming before irreversible actions, never asking for a password in chat, stopping at a CAPTCHA, and --restore with --restore-check-text to keep a login. Mac-mini specific parts to separate out or generalize: install via brew "agent-browser" in ~/server/Brewfile (the package is also on npm; not tested on another OS), the Chrome app path, ~/.agent-browser/config.json symlinked to ~/server/agent-browser/config.json (contentBoundaries true, maxOutput 50000; the generic fallback is the --content-boundaries flag), wiring and the check in ~/server (bin/agent-browser-apply.sh, checks/agent-browser.check.sh), the Screen Sharing login flow, scratchpad rules, x-read / reading-x, OpenClaw's browser tool. Saved login state sits in plaintext under ~/.agent-browser/sessions, which the mac-mini does not back up; the skill should say so. Out of scope: adding-services, recovering-gateway, restoring-media-mount, tracking-tasks, reading-x (tied to mac-mini services).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 skills/browsing-web/SKILL.md is tracked here, written for any machine, with mac-mini specifics moved out or marked as optional
- [x] #2 scripts/sync-push.sh RESERVED no longer lists browsing-web
- [x] #3 README no longer says all skills are z- prefixed, and the count of untracked mac-mini skills (six) is corrected to five
- [x] #4 SKILL.md states that saved sessions are stored in plaintext under ~/.agent-browser/sessions
- [x] #5 Mac-mini switch done deliberately: remove the untracked symlink ~/.claude/skills/browsing-web, pull, confirm the tracked directory is in place. An untracked, non-ignored symlink at a path upstream starts tracking aborts the 05:00 pull (verified)
- [x] #6 ~/server side adjusted: agent-browser-apply.sh no longer symlinks the skill, ~/server/skills/browsing-web removed or reduced to mac-mini notes, its check updated
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
2026-10-03 run 2: dotclaude 3f51c7a + b133c08 (YAML fix), ~/server 0e882bc (skills/browsing-web-macmini, apply no longer links, check wants a real directory) and T-466. Switch done: symlink removed, ~/.claude pulled to d66f660, verify agent-browser green. AGENTS.md:132 still names the old path; fix sent as proposal AGENTS-browsing-web.T-466 (awaiting Marty's approval).
<!-- SECTION:NOTES:END -->
