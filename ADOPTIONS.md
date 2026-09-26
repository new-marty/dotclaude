# Adoption log

One line per item adopted from elsewhere, and per item considered and declined. Git history
is filled with automatic commits from the sync hooks, so the intent behind any single
change does not survive there.

Each `SKILL.md` carries its source and license in a comment at the top, so attribution
survives even when the file is passed around on its own. This file is the index over those,
and it also lists what was declined.

Add new rows above the existing ones.

## Adopted
An audit of the whole set on 2026-09-13 fixed the bugs that actually caused harm: missing
`allowed-tools`, wrong internal references, skills that called the wrong other skill, and
an upstream assumption that the `open` command exists. Where the same rule appeared in
several files, it was consolidated: output language into `CLAUDE.md`, rules for Japanese
prose into `z-japanese-proofreading`, the check test into `z-writing-for-readers`, and
response length into `output-styles/concise.md`.


| Name | Source | License | What was changed |
| --- | --- | --- | --- |
| `z-humanizer` | [blader/humanizer](https://github.com/blader/humanizer) at 9862685 (2026-09-06) | MIT | Body is upstream's. `name`, an `argument-hint`, and a closing section that sets it as the English pass after `z-writing-for-readers`, exempts repository templates and index-line dashes, and defaults to embedded mode when another skill calls it |
| `z-natural-japanese` | [coji/natural-japanese](https://github.com/coji/natural-japanese) at 9a78a42 (2026-09-04) | MIT | Taken whole: references, scripts, fixtures. `name`, the slash-command examples and the script paths use the `z-` name. A closing section fixes the order of use with `z-japanese-proofreading`: constitution before writing, lint after, proofreading last |
| `output-styles/concise.md` | [i-have-adhd](https://github.com/ayghri/i-have-adhd) | MIT | Cut down to three rules and rewritten, matching the research that people can hold about three constraints at once |
| `z-show-me` | [humanlayer/skills](https://github.com/humanlayer/skills) | MIT | HTML delivery swapped for Artifact / SendUserFile. Japanese triggers |
| `z-teach` | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | Added a section that confirms the directory for teaching material, and how to hand over HTML. Japanese triggers, `disable-model-invocation`, `argument-hint` |
| `z-to-questionnaire` | same as above | MIT | Added a section that confirms where the questionnaire is written. Japanese triggers, `disable-model-invocation` |
| `z-prototype` | same as above | MIT | Body is upstream's. Japanese triggers, `disable-model-invocation` |
| `z-grilling` | same as above | MIT | Rewritten from scratch: one question at a time, the [SOCCR](https://jacobian.org/2021/jan/30/soccr/) format, and a branch for when the user cannot answer |
| `z-wait-what` | same as above | MIT | Rewritten. Added the `z-japanese-proofreading` condition, `disable-model-invocation` |
| `z-unstuck` | [oi-owarasero](https://github.com/nwiizo/oi-owarasero) | MIT | A local section at the end |
| `z-review-finding` | the Per-item Template from [p3bot/library](https://github.com/p3bot/library) | MPL-2.0 | Rewritten from scratch |
| `z-eli5` | [claude-plugins-community](https://github.com/anthropics/claude-plugins-community) | Apache-2.0 | Added the output-language rule. Japanese triggers, `argument-hint` |
| `frontend-design` | claude-plugins-official | upstream | A plugin. Its body is not synced |

## Declined

| Name | Source | Reason |
| --- | --- | --- |
| Handoff skills: [conorbronsdon `/end`](https://github.com/conorbronsdon/claude-code-skills), [HumanLayer `create_handoff`](https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/create_handoff.md), [ykdojo `handoff`](https://github.com/ykdojo/claude-code-tips/blob/main/skills/handoff/SKILL.md), [REMvisual](https://github.com/REMvisual/claude-handoff), [bugiiiii11 `/wrap`](https://github.com/bugiiiii11/handoff), [Sonovore](https://github.com/Sonovore/claude-code-handoff) | as linked | All write a similar handoff file, none clears the conversation, and each brings its own state layout inside the repository (`sessions/`, `thoughts/`, `HANDOFF.md`). `z-wrap-up` borrows the section list from the first two and writes outside the repository |
| [GGPrompts `/wipe`](https://gist.github.com/GGPrompts/62bbf077596dc47d9f424276575007a1) | gist | The one that clears, by typing `/clear` through tmux. No license, and this machine runs cmux. The same move is done with `cmux send` in `z-wrap-up` |
| [safe-compact](https://github.com/gokturkgocen/safe-compact), [precompact-hook](https://github.com/mvara-ai/precompact-hook), [claude-mem](https://github.com/thedotmack/claude-mem) | as linked | Aimed at compaction or at recording everything automatically. `z-wrap-up` is deliberate and targets `/clear`; its re-injection on `SessionStart` is the documented `additionalContext` mechanism safe-compact also uses |
| [stop-slop](https://github.com/hardikpandya/stop-slop), [avoid-ai-writing](https://github.com/conorbronsdon/avoid-ai-writing), [no-ai-slop](https://github.com/petergyang/no-ai-slop) | as linked | English AI-tell catalogues from the same Wikipedia list as `z-humanizer`. stop-slop's hard bans (no dashes at all) over-constrain technical prose; avoid-ai-writing is 74 patterns plus a Node detector, heavier than the job; no-ai-slop is lighter than humanizer but lacks its guard against inventing facts |
| [vale-ai-tells](https://github.com/tbhb/vale-ai-tells) | as linked | Vale rules for AI tells, the only set with commit-message rules. Not adopted yet; a candidate for a commit-message hook once the prose skills have settled |
| i-have-adhd (as a skill) | same as above | Overlaps in purpose with the output style. Holding both makes it unclear which one is in effect |

## Hand-written

`z-japanese-proofreading` / `z-cognitive-rhythm-writing` / `z-create-pr` / `z-start-task` /
`z-writing-for-readers` / `z-catch-up` / `z-wrap-up`

The symlinks directly under `skills/` (`computer-use`, `find-skills`, `orca-cli`,
`orchestration`) are created per machine by Orca and are excluded from tracking in
`.gitignore`.
