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
| A general approaches | 1 desk research | running | | subagent | 2026-10-04 | |
| B Claude Code mechanics | 1 desk research | running | | subagent | 2026-10-04 | |
| experiments | 2 | untouched | | | | after A and B |
| design document | 3 | untouched | | orchestrator | | |
| design inspection | 4 | untouched | | | | independent |

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
