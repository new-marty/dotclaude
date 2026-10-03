# Design: pull-only devices (TASK-16)

Status: proposal, revision 2, 2026-10-04. Evidence: `pull-only-research-1a.md` (approaches),
`pull-only-research-1b.md` (Claude Code mechanics), the experiments below, and an independent
inspection that re-ran every command sequence (22 findings, all addressed in this revision).

## Requirements

- A company Mac that can pull from GitHub and cannot push; pulls are by hand. More devices like
  it may come, so the setup must be the same on every one.
- Claude Code runs there; whether hooks or scripts may run is unknown. Nothing in the design may
  depend on them.
- Local customisations: work-specific skills and CLAUDE.md text, and sometimes edits to shared
  skills or shared instructions; possibly output styles and the statusline.
- Conflicts with upstream are accepted (Marty, 2026-10-04); each one must be visible and quick
  to resolve, and nothing local may be lost.

## What the experiments showed (2026-10-04, git 2.50.1, Claude Code 2.1.288)

| case | observed |
|---|---|
| Local additions in untracked files, upstream changes elsewhere | `git pull --ff-only` fast-forwards; local files untouched |
| Upstream starts tracking a path the device uses for an ignored local file | the local file is overwritten with no warning (content lost) |
| Upstream starts tracking a path the device uses for an untracked, not ignored file | the pull aborts ("untracked working tree files would be overwritten"); nothing lost |
| Shared file edited and committed on a local branch, upstream edits the same lines, merge | `CONFLICT (content)`, markers labelled `HEAD` and `origin/main`, `UU` in status; resolve, `git add`, `git commit` |
| Same, upstream edits other lines of the file | clean merge, no question asked |
| Upstream renames a file edited locally | rename detection carries the local edit across |
| Upstream deletes a file edited locally | `CONFLICT (modify/delete)`, `UD`; `git rm` accepts the deletion, `git add` keeps the file |
| Uncommitted edit to a shared file, then merge | if upstream touched that file: "Your local changes would be overwritten by merge. Aborting", nothing lost |
| `git switch main` on the device | the tree reverts to a stale `main`; local edits disappear from the tree until switching back |
| `rerere` | replays a resolution only for a byte-identical conflict (after `merge --abort` or a reset and a retry); a new upstream edit to the same line asks again |
| Today's `pull --rebase --autostash` with an uncommitted edit on the same lines | exit 0, "Applying autostash resulted in conflicts"; unrelated edits left staged; a stash entry to drop |
| A missing `@import` target in CLAUDE.md | the session runs; the line is not loaded |
| `.claude/rules/*.md` at project level | loaded at launch. User level `~/.claude/rules/` is documented but not tested here (this machine's guard blocks writing there) |
| `skillOverrides` in a settings file | `{"z-eli5": "off"}` hides the skill; `{"z-eli5": {"visibility": "hidden"}}` does not |
| `.gitignore`: `skills/local-*/` before `!skills/**`, or with a trailing slash | no effect, or misses a symlinked skill; `skills/local-*` after `!skills/**` works |

## Decision

Two layers. A device uses whichever its customisation needs; the file names and the setup are
the same on every device.

### Layer 1: additions (cannot conflict)

Everything a device adds lives at a reserved path that upstream never tracks.

| what | where on the device | notes |
|---|---|---|
| Instruction text | `~/.claude/CLAUDE.machine.md` | Imported by the last line of the shared CLAUDE.md; in use on the mac-mini. Start it with "Where these rules conflict with the shared ones above, these win": Claude Code has no precedence between memory files, so the text has to say it |
| Path-scoped rules (optional) | `~/.claude/rules/*.md` | Documented to load at launch; not tested at user level. The device's `/context` check confirms it |
| Skills | `~/.claude/skills/local-<name>/` (a directory or a symlink) | Ignored by a new `.gitignore` line. A skill without the prefix shows in `git status` and blocks a pull if upstream later adds the same path: rename it with the prefix |
| Output styles | `~/.claude/output-styles/local-<name>.md` | Ignored the same way |
| Statusline | an untracked script such as `~/.claude/statusline.local.sh`, set as `statusLine` in `settings.json` | Root files are ignored by `*` already |
| Hiding a shared skill | `"skillOverrides": {"<name>": "off"}` in `~/.claude/settings.json` | String form only (tested) |
| Settings, hooks | `~/.claude/settings.json` | Per machine, never tracked. See "Device settings" |

Reserved paths, never tracked upstream: `CLAUDE.machine.md`, `rules/`, `settings.json`,
`statusline.local.sh`, `skills/local-*`, `output-styles/local-*`. The experiments showed why this
must be enforced: if upstream ever tracked one of them, a device's ignored local file would be
overwritten without a word. Enforcement is a check that fails when `git ls-files` lists a
reserved path, run in two places: by `scripts/sync-push.sh` before it commits on a writer
machine, and by `scripts/test-sync-push.sh` (so a commit made from `~/dev/dotclaude`, which never
runs sync-push, is still caught when the tests run).

### Layer 2: edits to shared files (conflicts possible, kept readable)

Claude Code cannot overlay a shared skill or the shared CLAUDE.md, so an edit to one is a git
change. The device keeps those edits as commits on its own branch `local` and merges upstream
into it. A merge asks about a conflict once per update and records the answer in one commit; a
rebase would replay every local commit and can stop several times. The branch is never pushed.

#### Setup, once per device (paste into a terminal)

```sh
# 1. Get the repository. No ~/.claude yet:
git clone https://github.com/new-marty/dotclaude.git ~/.claude
#    ~/.claude exists already (Claude Code has run here): follow README "New machine" to turn
#    it into a clone, then commit whatever differs as the first local commit in step 3.

# 2. Work on a local branch only, and remove main so it cannot be switched to by mistake.
git -C ~/.claude switch -c local --track origin/main
git -C ~/.claude branch -D main

# 3. Git settings for this repository only.
git -C ~/.claude config pull.rebase false
git -C ~/.claude config merge.conflictStyle zdiff3
git -C ~/.claude config rerere.enabled true
git -C ~/.claude config user.name  "$(id -un) (device)"     # if the Mac has no git identity
git -C ~/.claude config user.email "device@localhost"
git -C ~/.claude config commit.gpgsign false                # local commits are never pushed
git -C ~/.claude add -A && git -C ~/.claude commit -m "local: initial differences" || true

# 4. Settings: copy the example, then edit it (see "Device settings").
cp ~/.claude/settings.example.json ~/.claude/settings.json
```

#### Daily use, by hand

```sh
git -C ~/.claude status --short                 # 0. uncommitted edits? commit them first:
                                                #    git -C ~/.claude commit -am "local: <what>"
git -C ~/.claude fetch && git -C ~/.claude status -sb   # 1. "behind N" means updates exist
git -C ~/.claude diff --stat HEAD...origin/main # 2. what upstream changed
git -C ~/.claude diff --name-only origin/main...HEAD    # 3. which shared files I changed
git -C ~/.claude merge origin/main              # 4. update
```

#### When the merge stops

- `CONFLICT (content)`: the file holds markers. `<<<<<<< HEAD` is this device, `>>>>>>>
  origin/main` is upstream, and the part after `|||||||` is the common ancestor. Edit the file
  to the wanted text, then `git add <file>` and `git commit --no-edit`.
- `CONFLICT (modify/delete)`: upstream deleted a file this device changed. `git rm <file>` accepts
  the deletion; `git add <file>` keeps the local version. Then `git commit --no-edit`.
- To back out of the update entirely: `git merge --abort`. With rerere on, retrying the same
  update later replays the resolution recorded before the abort, if one was recorded.
- "untracked working tree files would be overwritten": upstream added a path this device uses.
  Rename the local file to its reserved name (`local-` prefix) and run the merge again.

#### Device settings

`settings.example.json` holds the writer machines' choices. On a device:
- remove the `sync-pull.sh` and `sync-push.sh` hooks (and keep `handoff-inject.py` only if hooks
  are allowed);
- review `permissions.defaultMode`, `skipDangerousModePermissionPrompt`,
  `skipAutoPermissionPrompt` and `deniedMcpServers` against the company's rules before keeping
  them;
- point `statusLine` at the shared `statusline.sh` or a local script.

#### Self-check after setup and after each update

- `/context` lists `CLAUDE.machine.md` (and any `rules/` files) under memory files.
- `/skills` lists the shared skills and the `local-` ones.
If skills are missing, see "Company settings".

### Safety in the shared scripts

- `scripts/sync-pull.sh` and `scripts/sync-push.sh` exit at once unless the current branch is
  `main`. A device that keeps the hooks by mistake then cannot rebase or commit `local`.
- `statusline.sh` shows the unpushed count only on `main`. On `local` the count is the device's
  own commits, which never reach GitHub by design; it shows `local` instead.

### What a pull-only device does not use

- `sync-pull.sh` / `sync-push.sh`: the first runs `pull --rebase --autostash`, whose conflicts
  exit 0 and leave stash entries and staged files behind (observed); the second pushes.
- `skip-worktree` / `assume-unchanged`: git documents them as not meant for local edits, and the
  edits disappear from `git status`.
- Dotfile managers (chezmoi, yadm, stow) and the plugin channel as the main route: each adds a
  tool or a second copy without improving conflicts, and a plugin cannot carry CLAUDE.md.

## Company settings the device may impose

Managed settings override everything above and can change without notice.
- Hooks disabled (`allowManagedHooksOnly`, `disableAllHooks`): no effect; the design uses none.
- `strictPluginOnlyCustomization` with `skills: true`: every skill under `~/.claude/skills`,
  shared and local, is rejected silently; the self-check shows it. Fallback, not tested: the
  plugin channel this repository offers (`claude plugin marketplace add new-marty/dotclaude`,
  `claude plugin install dotclaude@dotclaude`), if the company allows the marketplace. CLAUDE.md
  text then has no route. The repository is public (checked with `gh repo view`), so https works
  without credentials.
- A managed CLAUDE.md always loads; local text may contradict it, and Claude may follow either.
- A company git configuration may require signing or set an identity; the setup's repository-only
  settings override it for this repository.

## Changes in this repository (TASK-16)

1. `.gitignore`: `skills/local-*` and `output-styles/local-*`, placed after the `!skills/**` and
   `!output-styles/**` lines, without a trailing slash.
2. A reserved-path check: in `sync-push.sh` before committing, and in `scripts/test-sync-push.sh`.
3. `sync-pull.sh`, `sync-push.sh`: exit unless on `main`. `statusline.sh`: `local` instead of the
   unpushed count off `main`.
4. README: a "Pull-only devices" section (setup, daily use, conflicts, device settings,
   self-check), and reconcile the existing text: the "pull-only machine drops the SessionEnd
   hook" sentence, the conflict section's rebase advice (writer machines only), the reserved
   paths next to "Two more things live under skills/", and the plugin paragraph that calls the
   repository private.
5. Test on a scratch clone, following the README literally: local additions (Layer 1) and a
   committed shared-file edit (Layer 2); upstream changes to other files and to the same lines;
   update. Pass: Layer 1 files untouched with no conflict; the same-line edit stops with a
   conflict that the documented steps resolve, keeping both sides' intended text; nothing local
   lost. TASK-16 AC#3 says "no conflict"; with conflicts accepted, it is reworded to this.

## Open

- User-level `~/.claude/rules/` loading is not tested; the device's `/context` check covers it.
- `git merge --abort` with unrelated uncommitted edits present is not tested; step 0 of daily use
  avoids that state.
- On the mac-mini each shared skill appears twice, once from `~/.claude/skills` and once from the
  installed `dotclaude` plugin. Out of scope here; worth its own task.
