# Adoption log

One line per item adopted from elsewhere, and per item considered and declined. Git history
is filled with automatic commits from the sync hooks, so the intent behind any single
change does not survive there.

Each `SKILL.md` carries its source and license in a comment at the top, so attribution
survives even when the file is passed around on its own. This file is the index over those,
and it also lists what was declined. The full license texts and copyright lines are in
`THIRD_PARTY_NOTICES.md`.

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
| `z-orchestrate` | Orca's `orchestration` skill (bundled with [Orca](https://github.com/stablyai/orca)), [obra/superpowers](https://github.com/obra/superpowers) `dispatching-parallel-agents` and `subagent-driven-development`, Anthropic's [multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system) post | Orca: MIT; superpowers: MIT | Ideas only, text written from scratch (2026-10-03). Orca's task-spec contract, "silence is not failure" and shallow chains; superpowers' brief-as-file, status codes and capped fix loop; plus this repository's own lessons from a staged document rewrite (pilot first, independent verifier, one progress table) |
| `z-japanese-proofreading` (2026-10-03 additions) | [nanaism/yomiyasu](https://github.com/nanaism/yomiyasu) at 8d5abee (2026-10-02); [k16shikano's japanese-tech-writing gist](https://gist.github.com/k16shikano/fd287c3133457c4fd8f5601d34aa817d) at 8f2d576 (2026-09-09) | MIT; Unlicense | From yomiyasu, the "keep the meaning" check (claim, weight, firmness, the sentence's role) and "add nothing", rewritten. From the gist's 2026-09-09 revision, three rules: name a concept's kind first, define the central term before use, add one step at a time. The skill now owns how prose is fixed; `z-natural-japanese`'s fixes defer to it. Compared on three of the mac-mini's own documents before deciding |
| `z-japanese-proofreading` | [VarYUvrc's predictable-reading-japanese gist](https://gist.github.com/VarYUvrc/6fe8174afa5d902fa2bc7a8a47b5484e) and [k16shikano's japanese-tech-writing gist](https://gist.github.com/k16shikano/fd287c3133457c4fd8f5601d34aa817d) | VarYUvrc: none; k16shikano: Unlicense | From VarYUvrc, ideas only: the gist has no license, so every example is rewritten. Norms from k16shikano. Written in Japanese and consolidated with the other rules for Japanese prose |
| `z-gemini-write` | the workflow in [this note article](https://note.com/genkaijokyo/n/n8562c2500420) | none taken | Only the idea (Gemini rewrites, Claude checks for meaning drift). Script, prompt and procedure written from scratch; OpenRouter added as a paid route used only on the user's approval |
| `z-humanizer` | [blader/humanizer](https://github.com/blader/humanizer) at 225a6f3 (2026-09-27) | MIT | Body is upstream's. `name`, an `argument-hint`, and a closing section that sets it as the English pass after `z-writing-for-readers`, exempts repository templates and index-line dashes, limits §26 (re-explaining what the reader knows) to replies inside a thread, and defaults to embedded mode when another skill calls it |
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
| `z-eli5` | [claude-plugins-community](https://github.com/anthropics/claude-plugins-community), by Thariq Shihipar | `plugin.json`: MIT; repository: Apache-2.0 | Added the output-language rule. Japanese triggers, `argument-hint` |
| `frontend-design` | claude-plugins-official | upstream | A plugin. Its body is not synced |

## Declined

| Name | Source | Reason |
| --- | --- | --- |
| [yomiyasu](https://github.com/nanaism/yomiyasu) as a whole skill | as linked | Its README asks to disable other Japanese style skills while it runs, and its typography rules (no space between Japanese and Latin text, no line-final colon, a 30-45 character sentence target) go against this repository's prose. Only the meaning check was taken, into `z-japanese-proofreading`. Upstream versions in use are recorded above so drift can be checked |
| Handoff skills: [conorbronsdon `/end`](https://github.com/conorbronsdon/claude-code-skills), [HumanLayer `create_handoff`](https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/create_handoff.md), [ykdojo `handoff`](https://github.com/ykdojo/claude-code-tips/blob/main/skills/handoff/SKILL.md), [REMvisual](https://github.com/REMvisual/claude-handoff), [bugiiiii11 `/wrap`](https://github.com/bugiiiii11/handoff), [Sonovore](https://github.com/Sonovore/claude-code-handoff) | as linked | All write a similar handoff file, none clears the conversation, and each brings its own state layout inside the repository (`sessions/`, `thoughts/`, `HANDOFF.md`). `z-wrap-up` borrows the section list from the first two and writes outside the repository |
| [GGPrompts `/wipe`](https://gist.github.com/GGPrompts/62bbf077596dc47d9f424276575007a1) | gist | The one that clears, by typing `/clear` through tmux. No license, and this machine runs cmux. The same move is done with `cmux send` in `z-wrap-up` |
| [safe-compact](https://github.com/gokturkgocen/safe-compact), [precompact-hook](https://github.com/mvara-ai/precompact-hook), [claude-mem](https://github.com/thedotmack/claude-mem) | as linked | Aimed at compaction or at recording everything automatically. `z-wrap-up` is deliberate and targets `/clear`; its re-injection on `SessionStart` is the documented `additionalContext` mechanism safe-compact also uses |
| [stop-slop](https://github.com/hardikpandya/stop-slop), [avoid-ai-writing](https://github.com/conorbronsdon/avoid-ai-writing), [no-ai-slop](https://github.com/petergyang/no-ai-slop) | as linked | English AI-tell catalogues from the same Wikipedia list as `z-humanizer`. stop-slop's hard bans (no dashes at all) over-constrain technical prose; avoid-ai-writing is 74 patterns plus a Node detector, heavier than the job; no-ai-slop is lighter than humanizer but lacks its guard against inventing facts |
| [vale-ai-tells](https://github.com/tbhb/vale-ai-tells) | as linked | Vale rules for AI tells, the only set with commit-message rules. Not adopted yet; a candidate for a commit-message hook once the prose skills have settled |
| i-have-adhd (as a skill) | same as above | Overlaps in purpose with the output style. Holding both makes it unclear which one is in effect |

## Hand-written

`z-cognitive-rhythm-writing` / `z-create-pr` / `z-start-task` /
`z-writing-for-readers` / `z-catch-up` / `z-wrap-up`

The symlinks directly under `skills/` (`computer-use`, `find-skills`, `orca-cli`,
`orchestration`) are created per machine by Orca and are excluded from tracking in
`.gitignore`.
