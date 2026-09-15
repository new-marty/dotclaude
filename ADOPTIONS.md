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
| natural-japanese | [coji/natural-japanese](https://github.com/coji/natural-japanese) | Its norms conflict with `z-japanese-proofreading`. Its lint catches translationese and sentence length, which does not help with the length and level of abstraction that actually cause trouble |
| i-have-adhd (as a skill) | same as above | Overlaps in purpose with the output style. Holding both makes it unclear which one is in effect |

## Hand-written

`z-japanese-proofreading` / `z-cognitive-rhythm-writing` / `z-create-pr` / `z-start-task` /
`z-writing-for-readers`

The symlinks directly under `skills/` (`computer-use`, `find-skills`, `orca-cli`,
`orchestration`) are created per machine by Orca and are excluded from tracking in
`.gitignore`.
