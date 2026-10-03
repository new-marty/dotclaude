# Orchestration run 2026-10-03 (2): all open tasks

A new session resumes from this file (progress table and briefs), not from memory.
"Rules for every agent" in `orchestration-2026-10-03.md` apply here too, with the exceptions
each brief states.

## Progress

| unit | stage | status | commit | last inspection (dropped AC / bugs / scope creep) | by | date | note |
|---|---|---|---|---|---|---|---|
| TASK-1 | implement | done_with_concerns | dotclaude 3f51c7a; ~/server 0e882bc | | subagent | 2026-10-03 | ~/server T-466 filed for the server side |
| TASK-1 | verify | done | +b133c08, ~/server d5ae118 | 0 / 3 / 2 minor | subagent | 2026-10-03 | YAML description invalid (fixed b133c08); mac-mini notes unreachable (AGENTS.md proposal sent); dangling symlink until switch |
| TASK-1 | switch (AC#5) | done | pushed d66f660 | | orchestrator | 2026-10-03 | symlink removed, ~/.claude pulled, verify agent-browser green |
| T-459 (~/server) | implement | done_with_concerns | ~/server 07db819 | | subagent | 2026-10-03 | full verify 4/42 red, none from this change (visible: proposal-cards, repo-ci) |
| T-459 (~/server) | verify | done | +905d9b6 | 0 / 0 / 1 minor | subagent | 2026-10-03 | streak write failure was silent: now a WARN in the log; bl done T-459 |
| TASK-10 | close | done | d66f660 | | orchestrator | 2026-10-03 | header + README; check-upstream rc=0 from ~/.claude. Not yet seen in a real morning run |
| TASK-12 | — | held | | | | | only Marty's main machine (macbook-pro) registers sync-push; it is offline. mac-mini registers no sync-push hook |
| TASK-3 | — | held | | | | | needs macbook-pro (offline) |
| TASK-7 AC#3 | usage review x4 | done | | | 4 subagents (Opus 5.5) | 2026-10-03 | transcripts: server 9e32fe00 (stopped at §1, no proposals), dotclaude 1e9a57ec (7), server 08e1b18f (7), server cd07889c (7); about 350k subagent tokens |
| TASK-7 AC#3 | skill edit | done_with_concerns | this commit | round 1: 0 / 0 / 7 / 4 / 0; round 2: 0 / 0 / 4 / 1 / 0 | orchestrator + 2 verifier subagents | 2026-10-03 | round 3 (incidents for the 4 additions, pilot tie, status timing, rewrap) read by the orchestrator only: stopgap, not independently re-verified |

## Rulings

- TASK-1 and T-459 run in parallel: disjoint write paths (TASK-1: browsing-web files, sync-push.sh, README skill lines, agent-browser files in ~/server; T-459: bin/daily-maintenance.sh and what it needs). Cost if wrong: a merge conflict in a shared tree, resolved by hand.
- TASK-10's dotclaude edits (README "Run it by hand" line, check-upstream.sh header) stay with the orchestrator, so only one agent writes README.md.
- The dotclaude push and the mac-mini switch (TASK-1 AC#5) are done by the orchestrator in one sitting: an untracked symlink at a path upstream starts tracking aborts the 05:00 pull.

## Brief: TASK-1 implement

Read the task: `backlog task view task-1 --plain` (in /Users/gary/dev/dotclaude). Source skill: `~/server/skills/browsing-web/SKILL.md`.

- Change in dotclaude (`/Users/gary/dev/dotclaude`, work on main, do not push):
  - `skills/browsing-web/SKILL.md`: a machine-independent skill (AC#1, AC#4). Keep the name `browsing-web` (no z- prefix: the name must match the directory and the mac-mini's AGENTS.md refers to it). Mac-mini specifics go out, or into a short optional section that says where a machine keeps its own notes. Say that saved sessions sit in plaintext under `~/.agent-browser/sessions`, and that the content-boundaries flag is the generic fallback for the config file. Verify agent-browser flags against `agent-browser --help` / `agent-browser skills get core`, not memory.
  - `.gitignore`: track the new directory (`!skills/browsing-web/`, `!skills/browsing-web/**` or the repo's existing pattern).
  - `scripts/sync-push.sh`: drop browsing-web from RESERVED (AC#2).
  - `README.md`: only the skills lines (AC#3): "all prefixed z-" is no longer true; the mac-mini keeps five untracked skills, not six.
  - Follow `skills/z-writing-for-readers` ("Text for agents") and run `z-humanizer` on new English text.
- Change in ~/server (`/Users/Gary/server`, shared tree with other sessions; Japanese text, as the repo uses): AC#6.
  - `bin/agent-browser-apply.sh`: stop linking the skill (step ③); keep ① ②.
  - `skills/browsing-web/`: reduce to mac-mini notes (install via Brewfile, Chrome path, config.json symlink, Screen Sharing login, x-read pointer, OpenClaw note), pointing to the dotclaude skill for the rest — or remove it if nothing machine-specific is left. Check what references it first (`grep -rn browsing-web ~/server --exclude-dir=backlog`), including AGENTS.md (canonical: do not edit; if it needs a change, write a proposal under docs/proposals/ per its README and report it).
  - `checks/agent-browser.check.sh`: update so it checks the new layout (the skill reachable at `~/.claude/skills/browsing-web` as a directory from dotclaude, no longer a symlink to ~/server) and still passes after the orchestrator's switch. Run it.
  - Track the work in ~/server's ledger only if its rules require it (`bl add` then claim); commit only your paths with `git -C /Users/Gary/server commit -m ... -- <paths>`. Do not `cd` into ~/server (a guard hook blocks it); use `git -C` and absolute paths. If the canonical guard refuses a write, stop and report it.
- Do NOT: touch `~/.claude` (no symlink removal, no pull — the orchestrator does AC#5), push either repo, edit dotclaude `backlog/`.
- Observable acceptance: `git -C /Users/gary/dev/dotclaude show --stat` for your commits; `bash -n` on changed scripts; the check script's output; a grep showing no remaining mac-mini paths in the dotclaude SKILL.md outside the optional section.
- Output: per AC, what satisfies it (file:line or command output); commit hashes in both repos; anything the orchestrator must do at switch time; status.

## Brief: T-459 implement (~/server)

Read the task: `bl show T-459` (run from any directory except ~/server; do not `cd` into ~/server, a guard hook blocks it). Claim it first: `bl claim T-459 --owner claude-dotclaude-run2`. Follow ~/server's `skills/tracking-tasks` and `skills/adding-services` (its checklist about verify going red on repeated failure applies).

- Target: `/Users/Gary/server/bin/daily-maintenance.sh` after step [4.5/6] (dotclaude-sync), and whatever small helper or check the design needs.
- Change: run `~/.claude/scripts/check-upstream.sh` each morning. Exit 1 → the CHANGED lines reach Telegram (follow how the script already notifies). Exit 2 (fetch failed) → do not alert on a single night; a run of failures must become visible (e.g. a state file with a streak counter that a `checks/*.check.sh` turns red in verify after N nights). Choose N and justify it in one line. Purpose: the 2026-09-09 upstream change went unnoticed for weeks.
- Constraints: daily-maintenance must never stop or fail because of this step (it is informational). Respect the existing timeout and summary conventions in the script. Tripwire-listed files (`~/server/checks/tripwire-files.txt`) and canonical files are off limits; if the design needs one, write a proposal and report. Shared tree: commit only your paths with `git -C /Users/Gary/server commit -m ... -- <paths>`. Commit messages in ~/server follow its own log and rules (read them). Do not push.
- Do NOT edit dotclaude (`/Users/gary/dev/dotclaude` or `~/.claude`); the orchestrator closes TASK-10 there.
- Observable acceptance: run the new step in isolation for exit 0, 1 and 2 (simulate 1 and 2, e.g. with a temporary upstream.tsv copy or a stub via an env override), showing what would be sent and what verify shows after the streak; `bash -n`; ~/server's `./verify` / `bin/verify` state for what you touched; run the code-review skill on your diff and address findings (T-459 DoD). Do not send real Telegram test messages unless the script's own test mode exists.
- Output: per AC and DoD item, the evidence; commit hash; whether you ran `bl done` (only if every AC is evidenced — AC#3 "notify dotclaude" is satisfied by your report to the orchestrator); status.

## What to change next time

- A cross-repo move needs an order in the brief: the ~/server commit that deleted `skills/browsing-web` landed before the dotclaude push, so the live symlink dangled for about 20 minutes. Tell the implementer which side waits for the switch.
- Ask implementers to parse SKILL.md frontmatter with a YAML loader. The unquoted `: ` passed review by eye and was caught only by the verifier.
- Moving a skill out of a repo can strand its pointers in canonical files. Have the brief name `grep` over canonical files and require the proposal in the same unit.

## Brief: TASK-7 AC#3 usage review (one agent per session transcript)

Purpose: find out how `skills/z-orchestrate/SKILL.md` (read it first, in /Users/gary/dev/dotclaude) fared on real work, so it can be adjusted from what happened.

- Input: one main session transcript (JSONL, large: use `jq` to extract user messages, assistant text and tool_use inputs; do not cat it whole). Its subagent transcripts sit in `<session-id>/subagents/` next to it; read them only where needed.
- Read-only. Do not edit or commit anything.
- Report:
  1. The job: what was orchestrated, how many units and stages, which mechanism (Agent tool, Workflow, background sessions).
  2. For each section of the skill (1 decide, 2 briefs, 3 run, 4 verify, 5 record, 6 close out): followed, deviated, or not reached. Give evidence (a short quote or tool call, with its timestamp).
  3. What went wrong or cost extra (duplicated agents, conflicts, unverified claims, lost state, wasted tokens, the person correcting the agent), with evidence.
  4. Candidate changes to the skill text: each one names the section, the change, and the incident it comes from. Only changes that would have prevented or shortened a real incident in this transcript; no general advice.
- End with DONE, DONE_WITH_CONCERNS or BLOCKED.

## Rulings (TASK-7 AC#3)

- The four transcripts that invoked z-orchestrate count as the real use for AC#3, in place of the handbook rewrite alone. Reason: Marty said several sessions had tried to use it. Cost if wrong: the handbook rewrite may show more; TASK-13 reviews skills again from use.
- Only changes backed by an incident in a transcript or in this run went into the skill. Not taken: write milestone reports in the person's language (Marty rejected a memory note for it; CLAUDE.md covers language), "or the tracker's own records" in place of the table (no incident).
