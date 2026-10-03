# Design: pull-only devices (TASK-16)

Status: proposal, revision 6, 2026-10-04. Revision 4 specified the changes file by file; an
independent inspection of it (1 goal missed, 6 gaps, 3 wrong claims, 4 breaks, 4
simplifications) is folded in here, and three of its four simplifications are taken. Evidence:
`pull-only-research-1a.md`, `pull-only-research-1b.md`, and "Evidence" at the end.

## 1. Problem

dotclaude assumes every machine both pulls and pushes. Two kinds of machine do not push:

- the mac-mini, whose `~/.claude` only pulls (`daily-maintenance` calls `~/server/bin/dotclaude-sync.sh`,
  which runs `scripts/sync-pull.sh`, every morning)
  and already keeps a local layer: `CLAUDE.machine.md` and five untracked skills;
- the company Mac (and future devices like it), which cannot push, pulls by hand, and may not be
  allowed to run hooks or scripts.

Both need local customisation (work skills, extra instructions, sometimes an edit to a shared
skill) that a pull never destroys. Today that holds on the mac-mini by convention only: its five
skill names are hard-coded in `sync-push.sh`, and nothing records which paths belong to devices.
When upstream starts tracking a path that a device keeps as an ignored file, git overwrites the
device's file without a word (observed).

## 2. Goals and non-goals

- G1. A device adds instructions, skills, output styles and settings without editing tracked
  files, and no pull conflicts with or overwrites them.
- G2. A device that edits a shared file sees each conflict with upstream as a stop with markers
  in the file, and resolves it with git alone.
- G3. Nothing on a device needs hooks or scripts; where hooks are allowed, they help.
- G4. One setup for every pull-only device; the mac-mini fits the same model.
- G5. Writer machines behave exactly as today.

Non-goals: pushing from a device; delivering dotclaude when a company blocks `~/.claude/skills`
(section 8); syncing a device's local layer anywhere.

## 3. Concepts

- **Writer**: a machine whose `~/.claude` commits and pushes through `sync-push.sh` (today the
  main machine). Nothing about writers changes.
- **Pull-only device**: a machine whose `~/.claude` has the repository-local git setting
  `dotclaude.role = pull-only`. It lives in `.git/config`, so no pull touches it. The scripts
  read it to change behaviour (section 5.3); a machine without it is a writer.
- **Local layer**: files a device adds at reserved paths, which `.gitignore` ignores and
  upstream never tracks.
- **Local edits**: commits that change shared files, on a branch named `local`. Needed only
  when a device edits a shared file; the mac-mini never does.

## 4. The local layer

### 4.1 Reserved paths, declared in `.gitignore`

`.gitignore` is the single list. Its new block, placed after the `!output-styles/**` line (the
`!` allow lines would re-include them if it came first):

```
# --- Device-local layer (README "Pull-only devices") ---
# Paths a device keeps for itself. Never track or force-add anything here: a pull
# would overwrite the device's file without a word.
# The root entries are anchored with "/" so that a rules/ directory inside a skill
# or under scripts/ stays trackable. "*" already ignores them; they are listed for the record.
/CLAUDE.machine.md
/statusline.local.sh
/rules/
skills/local-*
output-styles/local-*
# The mac-mini's own skills, kept under the names its agents call.
skills/adding-services
skills/reading-x
skills/recovering-gateway
skills/restoring-media-mount
skills/tracking-tasks
```

No trailing slash on the `skills/` lines, so a symlinked skill matches too (tested, including
the five mac-mini names as symlinks). `settings.json` is already ignored and documented in
`.gitignore`; it stays where it is.

Root-level files other than these two are also ignored by `*`, but a device must not keep its
own files there: if upstream ever adds a file of the same name, the device's file is
overwritten (observed with a force-added root file). Device files go only to the paths above.

### 4.2 Keeping the list honest

`sync-push.sh` stages with `git add -A`, which skips ignored paths, so a writer cannot commit a
reserved path by accident; only `git add -f` or a new `!` line in `.gitignore` could. The
hard-coded `RESERVED` loop in `sync-push.sh` is removed, since `.gitignore` now covers it.

`scripts/test-sync-push.sh` gains one case that guards against the two remaining ways in: for
each line of the device block, `git check-ignore -q` on a sample path under it must succeed
(catches a `!` line that re-includes it), and `git ls-files` must list nothing under it (catches
a force-add). Tests run by hand; that is the level of enforcement this repository has today.

### 4.3 What goes where

| a device wants to | it creates |
|---|---|
| add or override instructions | `~/.claude/CLAUDE.machine.md`, starting with "Where these rules conflict with the shared ones above, these win." Claude Code concatenates memory files and ranks none, so the text has to say it |
| add rules for some files only | `~/.claude/rules/<name>.md` with `paths:` frontmatter |
| add a skill | `~/.claude/skills/local-<name>/SKILL.md`, or a symlink at that path |
| add an output style | `~/.claude/output-styles/local-<name>.md` |
| hide a shared skill | `"skillOverrides": {"<name>": "off"}` in `~/.claude/settings.json`; only this string form works (tested) |
| use its own statusline | `~/.claude/statusline.local.sh`, set as `statusLine` in `settings.json` |

## 5. Updating a pull-only device

### 5.1 Without local edits (the usual case; the mac-mini always)

The device stays on `main` and only fast-forwards:

```sh
git -C ~/.claude pull --ff-only
```

A fast-forward cannot conflict. If the device has changed a shared file, the pull refuses:
for an uncommitted change git names the file ("Your local changes to the following files would
be overwritten by merge"); for a commit on `main` it says only "Not possible to fast-forward".
Either way, nothing is lost, and 5.2 is the way on.

### 5.2 With local edits to shared files

Once:

```sh
git -C ~/.claude switch -c local
git -C ~/.claude branch -u origin/main            # a new branch tracks nothing until told
git -C ~/.claude config merge.conflictStyle zdiff3
git -C ~/.claude commit -am "local: <what changed>"
git -C ~/.claude branch -D main                   # so `switch main` cannot hide the edits
```

Each update:

```sh
git -C ~/.claude status --short                   # commit any new edit first
git -C ~/.claude fetch
git -C ~/.claude merge origin/main
```

When the merge stops:
- `CONFLICT (content)`: the file shows `<<<<<<< HEAD` (this device), `||||||| <hash>` (the common
  ancestor) and `>>>>>>> origin/main` (upstream). Edit to the wanted text, `git add <file>`,
  `git commit --no-edit`.
- `CONFLICT (modify/delete)`: `git rm <file>` takes upstream's deletion, `git add <file>` keeps
  the file; then `git commit --no-edit`.
- `git merge --abort` returns to the state before the update.

A merge stops once per update and keeps the resolution in one commit; a rebase replays each
local commit and can stop several times. `rerere` is not used: in the experiments it replayed a
resolution in one run and recorded nothing in another.

### 5.3 The scripts on a pull-only device

The role check is `[ "$(git -C "$DIR" config dotclaude.role)" = pull-only ]`. With the role unset
every script runs exactly as today (G5).

`sync-push.sh`: on a pull-only device, exit 0 before doing anything. No branch check for writers.

`sync-pull.sh` on a pull-only device. All messages go to stderr with the existing
`[claude-sync]` prefix, and the script always exits 0, as today.

| state | action | message |
|---|---|---|
| on `main` | `git fetch`; if that fails, the existing `pull failed:` block and stop. Then `git merge --ff-only origin/main` | none on success. If the merge refuses: git's own output (which contains "would be overwritten by" when it names files), then `[claude-sync] local edits to shared files block a fast-forward; see README "Pull-only devices"`. Fetching first keeps a network failure from being reported as local edits |
| on any other branch, or detached | `git fetch` only | `[claude-sync] on <branch>, N commits behind origin/main; run: git -C ~/.claude merge origin/main` when N > 0, where N is `git rev-list --count HEAD..origin/main` |
| fetch or pull fails for another reason | nothing more | the existing `[claude-sync] pull failed:` block |

The strings "would be overwritten by" and "pull failed" are kept because the mac-mini's
`dotclaude-sync.sh` greps them from stderr.

`statusline.sh` on a pull-only device: the `.claude ⇡N` segment (unpushed commits) is replaced
by `.claude ⇣N` when `git rev-list --count HEAD..@{u}` is above 0, from the last fetch and with
no network call; on a branch other than `main` it also shows `local`. The `CONFLICT` segment
stays. `DIVERGED` never appears, because sync-push writes it and exits early here.

`sync-pull.sh` and `statusline.sh` read `${CLAUDE_SYNC_DIR:-$HOME/.claude}`, as `sync-push.sh`
already does, so tests can point them at a scratch clone. In `statusline.sh` that covers the git
checks and the `settings.json` read; the usage cache and the keychain lookup are untouched.

## 6. Setting up a device

```sh
# A. No ~/.claude yet
git clone https://github.com/new-marty/dotclaude.git ~/.claude

# B. ~/.claude exists (Claude Code has run here): make it a clone, keep its old files aside
cd ~/.claude && git init -b main
git remote add origin https://github.com/new-marty/dotclaude.git && git fetch origin
git reset origin/main && git checkout-index -a
mkdir -p ~/claude-before
git diff -z --name-only | while IFS= read -r -d '' f; do
  mkdir -p ~/claude-before/"$(dirname "$f")" && cp -p "$f" ~/claude-before/"$f"
done
git restore . && cd -
#   Move what you want to keep from ~/claude-before into the local layer (section 4.3).
#   A skill of your own that shows as "?? skills/<name>/": rename it to skills/local-<name>.

# Then, for both:
git -C ~/.claude config dotclaude.role pull-only
git -C ~/.claude branch -u origin/main
cp -n ~/.claude/settings.example.json ~/.claude/settings.json
```

Then edit `settings.json`: remove the `SessionEnd` hook (it exits at once on a device anyway);
keep the `SessionStart` hook only if hooks are allowed; review `permissions.defaultMode`,
`skipDangerousModePermissionPrompt` and `skipAutoPermissionPrompt` against the company's rules.

Self-check after setup and after each update: `/context` lists `CLAUDE.machine.md` under memory
files, and `/skills` lists the shared skills and the `local-` ones.

Commits on `local` use the device's git identity and signing settings. If company settings
require signing and the device has no key, those commits fail; signing with a device key, or
`git -C ~/.claude config commit.gpgsign false` for commits that never leave the device, is a
deliberate choice about company policy.

## 7. Changes, file by file

| file | change |
|---|---|
| `.gitignore` | the device block in 4.1 |
| `scripts/sync-push.sh` | exit 0 at once on a pull-only device; remove the `RESERVED` loop |
| `scripts/sync-pull.sh` | `CLAUDE_SYNC_DIR`; pull-only behaviour in 5.3 |
| `statusline.sh` | `CLAUDE_SYNC_DIR`; pull-only segment in 5.3 |
| `scripts/test-sync-push.sh` | cases: pull-only exits without committing; the device block is ignored and untracked |
| `scripts/test-pull-only.sh` | new; the scenarios in section 9 |
| `README.md` | new section "Pull-only devices": the concepts (3), the table in 4.3, the commands in 5.1, 5.2 and 6, and the self-check. Existing text: the sentence "A pull-only machine drops the SessionEnd hook and pulls whenever it likes" points to the new section; the conflict section says it is for writers; the paragraph on the mac-mini's six untracked skills says they are now ignored and points to the device block; the plugin paragraph's claim that the repository is private is corrected to public |
| mac-mini, in `~/server` (separate task) | confirm `git -C ~/.claude status` is clean, then `git config dotclaude.role pull-only` in `~/.claude`. In `dotclaude-sync.sh`, test for "local edits to shared files" before the existing "would be overwritten by" test (git's own text comes first in the output) and report it as a red line, rc=1; a fast-forward refusal is not "network/auth?". Behaviour after opt-in was traced with a stubbed copy: clean updates and no-change days report as today |

## 8. Failure modes

| what happens | what the person sees | what to do |
|---|---|---|
| A device edits a shared file, then pulls with `--ff-only` | the pull refuses (names the file, or "Not possible to fast-forward") | 5.2 |
| Upstream adds a file under an allowed directory (`skills/`, `scripts/`, …) at a path a device uses without the `local-` prefix | the pull refuses: "untracked working tree files would be overwritten" | rename to `local-…`, pull again |
| Upstream adds a root-level file with the same name as a device's own root file | the device's file is overwritten, no warning | prevented by keeping device files at the reserved paths only (4.1) |
| Someone force-adds a reserved path or adds a `!` line for it | nothing at commit time; `test-sync-push.sh` fails | revert the commit |
| A device forgets to pull for weeks | `⇣N` in the statusline after any fetch; nothing without a fetch | `git fetch`; no reminder exists without hooks |
| The company blocks `~/.claude/skills` (`strictPluginOnlyCustomization`) | `/skills` lacks the shared skills, with no warning | out of scope; the plugin channel (`claude plugin install dotclaude@dotclaude`) is an untested fallback, and CLAUDE.md has no route then |
| A company CLAUDE.md contradicts the device's | Claude may follow either | nothing in dotclaude can rank them |

## 9. Test plan

`scripts/test-pull-only.sh` builds a bare upstream, a writer clone and a device clone in a
temporary directory, sets `CLAUDE_SYNC_DIR` for the device, and asserts:

1. Files at every reserved path survive a pull that changes shared files.
2. `sync-pull.sh` with the role set, on `main`: fast-forwards; with an uncommitted edit to a
   shared file that upstream also changed, refuses, keeps the edit, and prints "would be
   overwritten by" and "pull failed" on stderr; exit 0 in both.
3. On `local`: `sync-pull.sh` only fetches and prints the behind count; a manual
   `git merge origin/main` merges a non-overlapping change cleanly, stops with `UU` on a
   same-line change (resolved by the documented steps), and with `UD` on an upstream deletion.
4. `sync-push.sh` with the role set exits 0 and creates no commit.
5. With the role unset, the existing `test-sync-push.sh` cases pass unchanged.

`statusline.sh` is rendered with a sample input that includes `rate_limits.five_hour` and
`rate_limits.seven_day` (so it takes the early exit and makes no keychain or network call) on a
writer, a pull-only device on `main` behind by two commits, and one on `local`.

## 10. Decisions for Marty

1. Mark devices with `git config dotclaude.role pull-only` (recommended: one line that survives
   pulls and lets the scripts adapt) or keep scripts unaware and tell each device which hooks to
   remove.
2. The `local` branch only when a device edits a shared file (recommended: most devices only
   add, and moving to it later is the five commands in 5.2) or on every device from the start.
3. Opt the mac-mini in as part of this work (recommended: it is already a pull-only device) or
   later.

## Evidence

Experiments 2026-10-04 (git 2.50.1, Claude Code 2.1.288) on scratch repositories:
- Untracked local files survive `pull --ff-only`. An ignored local file is overwritten when
  upstream starts tracking its path; an untracked, unignored one makes the pull abort instead.
- With commits on `main`, `pull --ff-only` prints only "Not possible to fast-forward".
- On a local branch, merge stops with markers on a same-line conflict, merges silently otherwise,
  reports `UD` for an upstream deletion, and carries local edits across a rename.
- `pull --rebase --autostash` with a conflicting uncommitted edit exits 0 and leaves a stash
  entry and unrelated files staged.
- A missing `@import` target does not fail a session; project-level `.claude/rules/` loads;
  `skillOverrides` works with `"off"`, not with `{"visibility": "hidden"}`.
- `skills/local-*` and the five mac-mini names as symlinks are ignored only when listed after
  `!skills/**` without a trailing slash; `git add -A` then skips them.
- `git diff --name-only` quotes non-ASCII paths; `-z` with `read -d ''` does not.
- `.claude-plugin` ships tracked files only, so ignoring these paths does not change the plugin.
- Revision 5 was inspected again (12 of 14 fixed, 2 partly, 4 new gaps); revision 6 fixes those
  four, checked by reading only.
Not tested: user-level `~/.claude/rules/`; the plugin fallback; a real company Mac; the
mac-mini's own `~/.claude` state.
