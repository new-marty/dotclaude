# Research run: pull-only devices (TASK-17, feeds TASK-16)

A new session resumes from this file (progress table and briefs), not from memory.
"Rules for every agent" in `orchestration-2026-10-03.md` apply. All units here are
read-only research except Stage 2, which writes only under its scratch directory.

## Requirements (from Marty, 2026-10-04)

- Device: a company Mac. It can pull from GitHub; it cannot push. Pulls will likely be by hand.
- Claude Code runs there. Whether hooks or scripts may run is unknown: the design must work
  without them, and may offer them as optional.
- Local customisations: work-specific skills and CLAUDE.md content. Edits to shared skills or
  shared instructions are possible too.
- Conflicts with upstream are accepted, but each one must be easy to see and resolve.
- More devices like this may come; the design must not be specific to one PC.

## Ceiling

About 4 agents (2 desk research, 1 experiment, 1 design inspection), about 600k tokens.

## Progress

| unit | stage | status | output | by | date | note |
|---|---|---|---|---|---|---|
| A general approaches | 1 desk research | done_with_concerns | pull-only-research-1a.md | subagent (Opus 5.5) | 2026-10-04 | top: overlay for additions + local branch merged with rerere for shared-file edits |
| B Claude Code mechanics | 1 desk research | done_with_concerns | pull-only-research-1b.md | subagent (Opus 5.5) | 2026-10-04 | layer works with today's .gitignore; no overlay for shared files; strictPluginOnlyCustomization is the main company risk |
| experiments | 2 | done_with_concerns | results table in design-pull-only-devices.md | subagent (Opus 5.5) + orchestrator (X4) | 2026-10-04 | X4 blocked by this machine's guards for the subagent; orchestrator re-ran it in scratch projects (project-level rules and settings.local.json); user-level ~/.claude/rules not tested |
| design document | 3 | done | design-pull-only-devices.md | orchestrator (Opus 5.5) | 2026-10-04 | |
| design inspection | 4 | done | revision 3 | 2 subagents (Opus 5.5) + orchestrator | 2026-10-04 | round 1: 22 findings (4 requirement, 4 unbacked, 2 failing steps, 8 uncovered, 4 repo contradictions); round 2: 14 fixed, 4 partly, 4 plan-only, 4 new defects; round 3 (https bootstrap with backup, cp -n, conditional identity, signing as an explicit choice, rerere dropped, unprefixed-skill rename) checked by the orchestrator only: setup 1b re-run on scratch with explicit paths (the guard blocks ~/.claude-shaped paths), not independently re-verified |

## Brief: Stage 1A, general approaches

Purpose: find the established ways to keep a local layer of changes on top of a shared
configuration repository that a device only pulls from, and judge them for the requirements
above. Do not design for Claude Code specifics; Stage 1B covers those.

Cover at least: overlay / `.local` include files; a local branch kept on top of upstream by
rebase or merge, with and without `git rerere`; patch queues (quilt, stgit, `git format-patch`
plus `git am`, topgit); `git update-index --skip-worktree` / `--assume-unchanged`; dotfile
managers (chezmoi, yadm, GNU stow, home-manager if relevant); submodule or subtree; vendor
branches. Find how teams that distribute shared configuration (editor configs, shell configs,
company dotfiles, AI agent rule files) handle per-user overrides, with real examples.

For each approach report, with sources (URLs, and the date or version when it matters):
- how a local change is stored, and what a pull does to it;
- what happens when upstream changes the same file or the same lines that were edited locally,
  and what the user sees and has to do (show the commands);
- effort per update when nothing conflicts;
- extra tools needed on the device;
- how the user notices that a locally edited file has changed upstream;
- known pitfalls (git docs or well-known write-ups say skip-worktree is not for this, etc.).

Output: a comparison table, then a short list of the 3 most promising approaches for the
requirements with a one-line reason each and the source it rests on. Mark anything you could
not confirm as unverified. Return as text. End with a status.

## Brief: Stage 1B, Claude Code mechanics

Purpose: find what Claude Code itself offers that a local layer can use, and what a company may
impose. Official docs: https://code.claude.com/docs/en/ (memory, settings, skills, plugins,
plugin marketplaces, sub-agents, output-styles, server-managed / managed settings, env vars).
Read the repository's README and `.gitignore` in /Users/gary/dev/dotclaude first.

Answer, with doc URLs and quotes:
1. Instructions: `@import` ordering and depth; how later text can override earlier text (is
   there any precedence, or only what the model reads); `~/.claude/rules/` loading; whether a
   user-level file can be loaded without editing the tracked CLAUDE.md. Known fact from a test
   on 2026-10-04: a missing `@import` target does not fail the session; its line is not loaded.
2. Skills: what happens when two skills share a name across personal, project and plugin
   scopes; can a skill be disabled or hidden per machine without deleting it (settings keys);
   can a skill's text be extended rather than replaced.
3. Plugins: could the shared skills reach the device as a plugin from this repository's
   marketplace (`.claude-plugin/` exists here) over https without push rights; update by hand
   (`/plugin marketplace update`, `claude plugin update`); what a plugin cannot carry (CLAUDE.md,
   rules, settings); how a local skill and a plugin skill coexist (namespacing).
4. Company constraints: managed settings and managed CLAUDE.md that a company can deploy; keys
   that block hooks, plugins, marketplaces, or skill directories (e.g. allowManagedHooksOnly,
   strictKnownMarketplaces, disable flags). What the design must survive if those are set.

Output: one section per question, then "consequences for the design" as bullets. Mark anything
unverified. Return as text. End with a status.

## Brief: Stage 2, experiments

Read `pull-only-research-1a.md` and `pull-only-research-1b.md` first. Purpose: measure, on
scratch repositories, what a person on a pull-only device actually types and sees for the top
candidates, so the design rests on observed behaviour.

Setup: under your scratchpad, a bare repo `upstream.git` seeded with a copy of the tracked files
of /Users/gary/dev/dotclaude (`git archive HEAD`), a writer clone that plays "the other
machines", and a device clone that plays the company PC. Never touch /Users/gary/dev/dotclaude
or ~/.claude except the one allowed test in X4.

- X1 overlay only. On the device: an untracked `CLAUDE.machine.md`, an untracked
  `rules/work.md`, an untracked skill `skills/work-foo/`. In the writer: change CLAUDE.md, change
  a skill, add a new skill, push. On the device: `git pull --ff-only`. Record: output, `git
  status`, whether the local files survived, and what happens if upstream later adds a tracked
  file at a path the device uses locally (e.g. `skills/work-foo/`).
- X2 local branch. On the device: a branch `local` that tracks `origin/main`, with
  `pull.rebase=false` and `rerere.enabled=true`; commit an edit to a shared skill and to
  CLAUDE.md. In the writer: change the same lines, push. On the device: plain `git pull`.
  Record the exact output, the conflict markers, the commands to resolve, and the result. Then:
  a writer change to other lines (expect a clean merge); and a case where rerere reuses a
  recorded resolution (for example `git merge --abort` then pull again, or the same upstream
  change reverted and re-applied). Also record what `git log --oneline` looks like after three
  rounds, and how to see "which of my locally edited shared files changed upstream" before
  pulling (a git one-liner or a git alias in the repo's local config; no scripts).
- X3 today's behaviour for comparison: device with an uncommitted edit to a tracked file, the
  writer changes the same lines, device runs `git pull --rebase --autostash` (what
  `scripts/sync-pull.sh` does). Record what the person sees and has to do.
- X4 Claude Code checks, each as a separate `claude -p` call with a codeword in the text:
  (a) `skillOverrides` shape: run `claude -p --settings <file>` with `{"skillOverrides":
  {"z-eli5": "off"}}` and then with `{"skillOverrides": {"z-eli5": {"visibility": "hidden"}}}`;
  ask the model whether a skill named z-eli5 is available; report which shape takes effect.
  (b) user-level rules: create `~/.claude/rules/zz-pull-only-test.md` containing only a codeword
  sentence, run `claude -p` asking for the codeword, then delete the file at once and confirm it
  is gone. If `~/.claude/rules/` does not exist, create it and remove it again afterwards. This
  is the only write allowed outside the scratchpad.
- Owned paths: your scratchpad, and the single test file in X4(b).
- Output: per experiment, the commands and the trimmed real output, then a table "approach ×
  (clean pull / same-line conflict / new upstream file at a local path / effort / what the user
  sees)". Mark what you did not run. Return as text. End with a status.

## Implementation (TASK-16), agreed 2026-10-04

| unit | stage | status | commit | last inspection (dropped / weakened / added / changed / form) | by | date | note |
|---|---|---|---|---|---|---|---|
| TASK-16 | implement | done | main 5dfe644, 165ec3d (from 2ac4da7, 73d4aa0) | | subagent (Opus 5.5), worktree | 2026-10-04 | fix round 1 reused the same agent |
| TASK-16 | verify | done | | round 1: 0 spec gaps, 0 writer changes, 3 low bugs, 1 README contradiction; round 2 (fix diff): 0 / 0 / 0 / 0 / 0 | 2 subagents (Opus 5.5) | 2026-10-04 | negative control confirmed advice.diverging; tests re-run on main by the orchestrator: 12 ok |
| mac-mini opt-in | — | filed | | | | | ~/server T-479, after this lands |

### Brief: TASK-16 implement

The specification is `backlog/docs/design-pull-only-devices.md` (revision 6, agreed). Implement
section 7 exactly; where the design leaves a detail open, choose the simplest option that keeps
G1 to G5 and say what you chose in the report.

- Target and owned paths: `.gitignore`, `scripts/sync-push.sh`, `scripts/sync-pull.sh`,
  `statusline.sh`, `scripts/test-sync-push.sh`, `scripts/test-pull-only.sh` (new), `README.md`.
  Nothing else; in particular not `backlog/`, not `settings.example.json`, not `skills/`.
- Constraints: with `dotclaude.role` unset every script behaves byte-for-byte as before (G5); keep
  the stderr strings "would be overwritten by" and "pull failed" (the mac-mini's cron greps them);
  macOS bash 3.2 and BSD tools; never run anything against the real `~/.claude` (use
  `CLAUDE_SYNC_DIR` and scratch clones). The guard hook on this machine refuses commands that
  contain paths shaped like `~/.claude/settings.json`; use scratch paths in tests, never work
  around the guard. README is English; follow `skills/z-writing-for-readers` ("Text for agents"
  where it applies) and run `z-humanizer` on new prose.
- What must survive: every existing README fact that is still true; the mac-mini's five skills
  (they become ignored, not deleted); the existing `test-sync-push.sh` cases.
- Observable acceptance: `bash scripts/test-sync-push.sh` and `bash scripts/test-pull-only.sh`
  pass (paste the output); `bash -n` on every changed script; `git check-ignore -v` output for
  each path in the design's 4.1 block plus `skills/z-a/rules/x.md` (must not be ignored);
  `statusline.sh` rendered with the sample input from design section 9 in the three roles.
- Output: what changed per file, choices made where the design was open, the outputs above,
  commit hashes (commit only your paths, Conventional Commits, your own Co-Authored-By line),
  status. Do not push.
