# Adoption log

One line per item adopted from elsewhere, and per item considered and declined. Git history
is filled with automatic commits from the sync hooks, so the intent behind any single
change does not survive there.

Since 2026-11-10, skills from elsewhere are installed as plugins and used unmodified
(README "Settings every machine shares"); the plugin carries its own license. A skill kept
in `skills/` carries its source and license in a comment at the top of `SKILL.md`, so
attribution survives even when the file is passed around on its own. This file is the index
over both, and it also lists what was declined and what was retired. The full license texts and copyright lines are in
`THIRD_PARTY_NOTICES.md`.

Add new rows above the existing ones.

## Installed as plugins

Declared in `settings.shared.json`, updated from upstream automatically (LAB-1360).

| Plugin | Source | License | Replaced |
| --- | --- | --- | --- |
| `mattpocock-skills` | [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | `z-teach`, `z-to-questionnaire`, `z-prototype`, `z-grilling`, `z-wait-what`, and `z-catch-up` / `z-wrap-up` (by `handoff`) |
| `yomiyasu` | [nanaism/yomiyasu](https://github.com/nanaism/yomiyasu) | MIT | `z-natural-japanese`, `z-japanese-proofreading`, `z-cognitive-rhythm-writing`. Its 2.0.0 keeps the source's spacing around Latin text, which removed the reason it was declined before |
| `humanizer` | [blader/humanizer](https://github.com/blader/humanizer) | MIT | `z-humanizer` |
| `i-have-adhd` | [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) | MIT | `output-styles/concise.md`. Always-on through the tracked `.i-have-adhd-always` |
| `show-me` | [humanlayer/skills](https://github.com/humanlayer/skills) | MIT | `z-show-me` |
| `eli5` | [claude-plugins-community](https://github.com/anthropics/claude-plugins-community) | MIT | `z-eli5` |
| `oi-owarasero` | [nwiizo/oi-owarasero](https://github.com/nwiizo/oi-owarasero) | MIT | `z-unstuck` |
| `agent-browser` | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | Apache-2.0 | `browsing-web` |
| `pstack` | [backnotprop/pstack](https://github.com/backnotprop/pstack), a mirror of [cursor/plugins `pstack`](https://github.com/cursor/plugins/tree/main/pstack) | MIT | nothing; added for `interrogate`, `how`, `why` and `arena`. The whole mirror, because its skills read one another by path; all manual-only, no hook. `poteto-mode` is run by hand only |
| `frontend-design` | claude-plugins-official | upstream | set in `settings.example.json`, not shared |

`z-gemini-write` moved to the mac-mini's own skills as `local-gemini-write` (LAB-1363).
Orca brings its own `orchestration` skill on the machines that run it, which replaced
`z-orchestrate`. `z-writing-for-readers` and `z-design-ui` were retired with no replacement.

## Kept in this repository

| Name | Source | License | What was changed |
| --- | --- | --- | --- |
| `z-design-ux` | Research for LAB-769 (2026-10): Garrett's *Elements of User Experience*, Basecamp *Shape Up*, GOV.UK Service Manual, NN/g, OOUX (Sophia Prater), Scott Hurff's UI stack, design-cognition research (Schön, Cross, Dorst), Kim Goodwin's stakeholder questions, *The Mom Test*; skills read for comparison: [pbakaus/impeccable](https://github.com/pbakaus/impeccable) at dad8dbb, [julianoczkowski/designer-skills](https://github.com/julianoczkowski/designer-skills) at c259656, [borghei/claude-skills](https://github.com/borghei/claude-skills) at 4a698e8 | impeccable, designer-skills: Apache-2.0; borghei: MIT with Commons Clause (nothing taken) | Ideas only, text written from scratch. From impeccable, few questions per round with a stated guess; from designer-skills, files that the next step reads; from borghei, listing assumptions when the user leaves it to Claude. Own additions: the designer stance and lenses, the three coverage checks with `check_package.py`, evidence labels, and the ask/research/reason order |
| `z-review-finding` | the Per-item Template from [p3bot/library](https://github.com/p3bot/library) | MPL-2.0 | Rewritten from scratch |

## Declined

| Name | Source | Reason |
| --- | --- | --- |
| [obra/superpowers](https://github.com/obra/superpowers) as a whole | as linked | Requires a skill before any reply and writes specs into `docs/superpowers/`; it takes over how every session runs (2026-11-10) |
| [pstack-claude](https://github.com/michael-denyer/pstack-claude) | as linked | A port with a `SessionStart` hook that routes every task to `poteto-mode` and 65 policy forks of its own; the mirror is used instead (2026-11-10) |
| [caveman](https://github.com/JuliusBrussee/caveman), [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | as linked | caveman imposes its own speech style over the language rule; the Karpathy file is a `CLAUDE.md` with no license that overlaps this one (2026-11-10) |
| [addyosmani/clarity](https://github.com/addyosmani/clarity) | as linked | Considered as the successor to `z-writing-for-readers`; Marty decided against it (2026-11-10) |
| Handoff skills: [conorbronsdon `/end`](https://github.com/conorbronsdon/claude-code-skills), [HumanLayer `create_handoff`](https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/create_handoff.md), [ykdojo `handoff`](https://github.com/ykdojo/claude-code-tips/blob/main/skills/handoff/SKILL.md), [REMvisual](https://github.com/REMvisual/claude-handoff), [bugiiiii11 `/wrap`](https://github.com/bugiiiii11/handoff), [Sonovore](https://github.com/Sonovore/claude-code-handoff) | as linked | All write a similar handoff file, none clears the conversation, and each brings its own state layout inside the repository (`sessions/`, `thoughts/`, `HANDOFF.md`). `z-wrap-up` borrows the section list from the first two and writes outside the repository |
| [GGPrompts `/wipe`](https://gist.github.com/GGPrompts/62bbf077596dc47d9f424276575007a1) | gist | The one that clears, by typing `/clear` through tmux. No license, and this machine runs cmux. The same move is done with `cmux send` in `z-wrap-up` |
| [safe-compact](https://github.com/gokturkgocen/safe-compact), [precompact-hook](https://github.com/mvara-ai/precompact-hook), [claude-mem](https://github.com/thedotmack/claude-mem) | as linked | Aimed at compaction or at recording everything automatically. `z-wrap-up` is deliberate and targets `/clear`; its re-injection on `SessionStart` is the documented `additionalContext` mechanism safe-compact also uses |
| [stop-slop](https://github.com/hardikpandya/stop-slop), [avoid-ai-writing](https://github.com/conorbronsdon/avoid-ai-writing), [no-ai-slop](https://github.com/petergyang/no-ai-slop) | as linked | English AI-tell catalogues from the same Wikipedia list as `z-humanizer`. stop-slop's hard bans (no dashes at all) over-constrain technical prose; avoid-ai-writing is 74 patterns plus a Node detector, heavier than the job; no-ai-slop is lighter than humanizer but lacks its guard against inventing facts |
| [vale-ai-tells](https://github.com/tbhb/vale-ai-tells) | as linked | Vale rules for AI tells, the only set with commit-message rules. Not adopted yet; a candidate for a commit-message hook once the prose skills have settled |

## Hand-written

`z-create-pr` / `z-start-task` / `z-write-task`, all three moving to Startup's own skills
(LAB-1361). Retired on 2026-11-10: `z-cognitive-rhythm-writing`, `z-writing-for-readers`,
`z-catch-up`, `z-wrap-up`; their text stays in git history.

The symlinks directly under `skills/` (`computer-use`, `find-skills`, `orca-cli`,
`orchestration`) are created per machine by Orca and are excluded from tracking in
`.gitignore`.
