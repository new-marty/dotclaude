# Design: pull-only devices (TASK-16)

Status: proposal, 2026-10-04. Evidence: `pull-only-research-1a.md` (approaches),
`pull-only-research-1b.md` (Claude Code mechanics), and the experiments recorded below.

## Requirements

- A company Mac that can pull from GitHub and cannot push; pulls are by hand. More devices like
  it may come, so the setup must be the same on every one.
- Claude Code runs there; whether hooks or scripts may run is unknown. Nothing in the design may
  depend on them.
- Local customisations: work-specific skills and CLAUDE.md text, and sometimes edits to shared
  skills or shared instructions.
- Conflicts with upstream are accepted; each one must be visible and quick to resolve.

## What the experiments showed (2026-10-04, git 2.50.1, Claude Code 2.1.288)

| case | observed |
|---|---|
| Local additions in untracked files, upstream changes elsewhere | `git pull --ff-only` fast-forwards; local files untouched |
| Upstream starts tracking a path the device uses for an ignored local file | the local file is overwritten with no warning (content lost) |
| Upstream starts tracking a path the device uses for an untracked, not ignored file | the pull aborts ("untracked working tree files would be overwritten"); nothing lost |
| Shared file edited and committed on a local branch, upstream edits the same lines, `git pull` (merge) | `CONFLICT (content)`, markers in the file, `UU` in status; resolve, `git add`, `git commit` |
| Same, upstream edits other lines of the file | clean merge, no question asked |
| A conflict seen before (re-pull after reset, or a revert and re-apply upstream) | `rerere` writes the old resolution; the person still runs `git add` and `git commit` |
| Today's `pull --rebase --autostash` with an uncommitted edit on the same lines | exit 0, "Applying autostash resulted in conflicts"; unrelated edits left staged; a stash entry to drop |
| A missing `@import` target in CLAUDE.md | the session runs; the line is not loaded |
| `.claude/rules/*.md` (project level) | loaded at launch. User level `~/.claude/rules/` not tested: this machine's guard blocks writing there |
| `skillOverrides` in a settings file | `{"z-eli5": "off"}` hides the skill; `{"z-eli5": {"visibility": "hidden"}}` does not |

## Decision

Two layers, and a device uses whichever its customisation needs. The file names are the same on
every device.

### Layer 1: additions (cannot conflict)

Everything a device adds lives at a reserved path that upstream never tracks.

| what | where on the device | notes |
|---|---|---|
| Instruction text | `~/.claude/CLAUDE.machine.md` | Already imported by the last line of the shared CLAUDE.md, and in use on the mac-mini. Start it with "Where these rules conflict with the shared ones above, these win." Claude Code has no precedence between memory files, so the text has to say it |
| Path-scoped rules (optional) | `~/.claude/rules/*.md` | Loads automatically; use `paths:` frontmatter to scope. Confirm on the device with `/context` |
| Skills | `~/.claude/skills/local-<name>/` | New `.gitignore` line keeps them out of `git status`. A local skill cannot share a name with a shared one |
| Hiding a shared skill | `"skillOverrides": {"<name>": "off"}` in `~/.claude/settings.json` | String form only (tested) |
| Settings, statusline, hooks | `~/.claude/settings.json` | Already per machine. A pull-only device copies `settings.example.json` and removes the `sync-pull.sh` and `sync-push.sh` hooks |

Reserved paths, never tracked upstream: `CLAUDE.machine.md`, `rules/`, `skills/local-*/`,
`settings.json`. The experiments showed why this must be enforced: if upstream ever tracked one
of them, a device's ignored local file would be overwritten without a word. Enforcement:
`scripts/sync-push.sh` refuses to commit a reserved path (it already refuses the mac-mini's
skill names), and README states the rule.

### Layer 2: edits to shared files (conflicts possible, kept readable)

Claude Code cannot overlay a shared skill or the shared CLAUDE.md, so an edit to one is a git
change. The device keeps those edits as commits on its own branch and merges upstream into it.

One-time setup on the device:

```sh
git -C ~/.claude switch -c local --track origin/main
git -C ~/.claude config pull.rebase false
git -C ~/.claude config rerere.enabled true
git -C ~/.claude config merge.conflictStyle zdiff3
```

Daily use, by hand:

```sh
git -C ~/.claude diff --name-only origin/main...HEAD   # what I changed in shared files
git -C ~/.claude fetch
git -C ~/.claude diff --stat HEAD...origin/main         # what upstream changed since my last update
git -C ~/.claude merge origin/main                      # update
```

On a conflict the file holds markers labelled `HEAD` (this device) and `origin/main`
(upstream), with the common ancestor in the middle (`zdiff3`). Edit, then `git add <file>` and
`git commit --no-edit`. `git merge --abort` returns to the state before the update. `rerere`
remembers each resolution, so the same conflict is not asked twice.

Why merge and not rebase: a merge conflict is resolved once per update and stays in one commit;
a rebase replays every local commit and can stop several times. The branch is never pushed, so
neither choice affects anyone else.

### What a pull-only device does not use

- `scripts/sync-pull.sh` and `scripts/sync-push.sh`: the first runs `pull --rebase --autostash`,
  whose conflicts exit 0 and leave stash entries and staged files behind (observed); the second
  pushes.
- `skip-worktree` / `assume-unchanged`: git documents them as not meant for local edits, and the
  edits disappear from `git status`.
- Dotfile managers (chezmoi, yadm, stow) and the plugin channel as the main route: each adds a
  tool or a second copy without improving conflicts, and a plugin cannot carry CLAUDE.md.

## Company settings the device may impose

Managed settings override everything above and can be set without notice.

- Hooks disabled (`allowManagedHooksOnly`, `disableAllHooks`): no effect; the design uses none.
- `strictPluginOnlyCustomization` with `skills: true`: every skill under `~/.claude/skills`,
  shared and local, is rejected silently. Check after setup and after any company update: `/skills`
  lists the shared skills. If they are gone, the fallback is the plugin channel this repository
  already offers (`claude plugin marketplace add new-marty/dotclaude`, `claude plugin install
  dotclaude@dotclaude`), if the company allows that marketplace; CLAUDE.md text then has no
  route and must be pasted into a project or skill. Not tested.
- A managed CLAUDE.md always loads; local text may contradict it, and Claude may follow either.

## Changes in this repository (TASK-16)

1. `.gitignore`: ignore `skills/local-*/`.
2. `scripts/sync-push.sh`: refuse to commit reserved local paths.
3. README: a "Pull-only devices" section with the setup, daily use, conflict steps and the
   self-check (`/context` shows `CLAUDE.machine.md`, `/skills` shows the shared skills).
4. Test on a scratch clone: local additions plus a shared-file edit, an upstream change to the
   same lines, update by the documented commands; end with no lost content and both changes in
   effect (TASK-16 AC#3).

## Open

- User-level `~/.claude/rules/` loading is not tested (project level is). The device's own
  `/context` check covers it.
- Nothing tells a manual-pull device that it is behind. `git fetch` plus `git status` shows it;
  a reminder would need a hook or a statusline script, which may not be allowed.
- On the mac-mini each shared skill appears twice, once from `~/.claude/skills` and once from
  the installed `dotclaude` plugin. Out of scope here; worth its own task.
