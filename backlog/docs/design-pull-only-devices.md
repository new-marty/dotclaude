# Design: pull-only devices (TASK-16)

Status: proposal, revision 4, 2026-10-04. Replaces revisions 1 to 3, which listed findings
instead of specifying changes. Evidence: `pull-only-research-1a.md`, `pull-only-research-1b.md`,
and the experiments summarised in "Evidence" at the end.

## 1. Problem

dotclaude assumes every machine both pulls and pushes. Two kinds of machine do not push:

- the mac-mini, whose `~/.claude` only pulls (a cron job runs `scripts/sync-pull.sh` at 05:00)
  and which already keeps a local layer: `CLAUDE.machine.md` and five untracked skills;
- the company Mac (and future devices like it), which cannot push, pulls by hand, and may not be
  allowed to run hooks or scripts.

Both need local customisation (work skills, extra instructions, sometimes an edit to a shared
skill) that a pull never destroys. Today that works on the mac-mini only by convention: the five
skill names are hard-coded in `sync-push.sh`, and nothing stops upstream from tracking a path a
device uses locally. When upstream does, git overwrites an ignored local file without a word
(observed).

## 2. Goals and non-goals

Goals:
- G1. A device can add instructions, skills, output styles and settings without editing tracked
  files, and no pull can conflict with or overwrite them.
- G2. A device that does edit a shared file sees every conflict with upstream as a stop with
  markers in the file, and resolves it with git alone.
- G3. Nothing on a device needs hooks or scripts; where hooks are allowed, they help.
- G4. One setup for every pull-only device; the mac-mini fits the same model.
- G5. Writer machines (the main machine) behave as today.

Non-goals: pushing from a device; delivering dotclaude when a company blocks
`~/.claude/skills` (section 8); syncing a device's local layer anywhere.

## 3. Concepts

- **Writer**: a machine whose `~/.claude` commits and pushes (sync-push on SessionEnd). Today:
  the main machine.
- **Pull-only device**: a machine whose `~/.claude` never pushes. Marked by one repository-local
  git setting, `dotclaude.role = pull-only` (stored in `.git/config`, so pulls never touch it).
  Today: the mac-mini (after opting in) and the company Mac.
- **Local layer**: files a device adds at reserved paths. Upstream never tracks a reserved path,
  and git ignores them all.
- **Local edits**: commits that change shared files, kept on a branch `local` on the device. Only
  needed when a device edits a shared file.

## 4. The local layer

### 4.1 Reserved paths

One tracked file, `scripts/reserved-paths.txt`, lists them as git pathspec globs, one per line,
with a comment saying what each is for:

```
CLAUDE.machine.md          # a device's own instructions; the shared CLAUDE.md imports it last
rules/                     # a device's own rules (~/.claude/rules/*.md)
settings.json              # per-machine settings
statusline.local.sh        # a device's own statusline script
skills/local-*             # a device's own skills
output-styles/local-*      # a device's own output styles
skills/adding-services     # mac-mini skills kept under their existing names
skills/reading-x
skills/recovering-gateway
skills/restoring-media-mount
skills/tracking-tasks
```

The mac-mini's five skills keep their names because its AGENTS.md and agents call them by
name; new local skills on any device use the `local-` prefix.

### 4.2 Ignoring them

`.gitignore` already ignores the root files and `rules/` through its leading `*`. Two lines are
added after the `!skills/**` and `!output-styles/**` lines, without a trailing slash so that a
symlinked skill matches too (tested):

```
skills/local-*
output-styles/local-*
```

The five mac-mini skill names move from "untracked, not ignored" to ignored as well (five lines),
so `git status` is clean on the mac-mini and `git add -A` on a writer can never pick them up.

### 4.3 Enforcing them

`scripts/check-reserved.sh` reads the list and fails (exit 1, naming the path) when a reserved
path is tracked or staged. It runs in three places:

1. `sync-push.sh`, after `git add -A` and before committing; it replaces today's hard-coded
   `RESERVED` loop. On failure it unstages and exits 0 with the message, as today.
2. A tracked `.githooks/pre-commit` that calls it. Each writer clone sets
   `git config core.hooksPath .githooks` once (the main machine's `~/.claude` and the mac-mini's
   `~/dev/dotclaude`), so a hand commit is checked too.
3. `scripts/test-sync-push.sh`, so the rule is part of the test suite.

### 4.4 What goes where

| a device wants to | it creates |
|---|---|
| add instructions or override shared ones | `~/.claude/CLAUDE.machine.md`, starting with "Where these rules conflict with the shared ones above, these win." Claude Code concatenates memory files and gives none precedence, so the text must say it |
| add rules scoped to some files | `~/.claude/rules/<name>.md` with `paths:` frontmatter |
| add a skill | `~/.claude/skills/local-<name>/SKILL.md` (or a symlink there) |
| add an output style | `~/.claude/output-styles/local-<name>.md` |
| hide a shared skill | `"skillOverrides": {"<name>": "off"}` in `~/.claude/settings.json` (only the string form works; tested) |
| use its own statusline | an untracked `~/.claude/statusline.local.sh`, set as `statusLine` in `settings.json` |

## 5. Updating a pull-only device

### 5.1 Without local edits (the usual case)

The device stays on `main` and only fast-forwards:

```sh
git -C ~/.claude pull --ff-only
```

If hooks are allowed, the `SessionStart` hook does the same (5.3). `--ff-only` cannot create a
conflict: when the device has changed a shared file, the pull refuses and names the file
("Your local changes to the following files would be overwritten" or "Not possible to
fast-forward"). That is the signal to use 5.2.

### 5.2 With local edits to shared files

Once, the device moves its edits onto a branch:

```sh
git -C ~/.claude switch -c local
git -C ~/.claude branch -u origin/main   # a new branch tracks nothing until told
git -C ~/.claude config pull.rebase false
git -C ~/.claude config merge.conflictStyle zdiff3
git -C ~/.claude commit -am "local: <what changed>"
git -C ~/.claude branch -D main          # so `switch main` cannot hide the edits
```

From then on:

```sh
git -C ~/.claude status --short          # commit any new edit first
git -C ~/.claude fetch
git -C ~/.claude merge origin/main
```

When the merge stops:
- `CONFLICT (content)`: the file shows `<<<<<<< HEAD` (this device), `||||||| <hash>` (the common
  ancestor), and `>>>>>>> origin/main` (upstream). Edit to the wanted text, `git add <file>`,
  `git commit --no-edit`.
- `CONFLICT (modify/delete)`: `git rm <file>` takes upstream's deletion, `git add <file>` keeps the
  file; then `git commit --no-edit`.
- `git merge --abort` returns to the state before the update.

Merge, not rebase: a merge stops once per update and records the resolution in one commit; a
rebase replays every local commit and can stop several times. `rerere` is not used: in the
experiments it replayed a resolution in one run and recorded nothing in another.

### 5.3 What the scripts do on a pull-only device

| script | writer (role unset) | pull-only, on `main` | pull-only, on `local` |
|---|---|---|---|
| `sync-pull.sh` (SessionStart, or the mac-mini cron) | as today: `pull --rebase --autostash` | `pull --ff-only`; on refusal, print the files and "see README: local edits" | `fetch` only; print "N upstream commits; run git merge origin/main" |
| `sync-push.sh` (SessionEnd) | as today | exit 0 at once | exit 0 at once |
| `statusline.sh` | as today: unpushed count `⇡N` | `⇣N` behind origin/main as of the last fetch (no network call) | `local` plus `⇣N` |

A device without hooks runs the commands in 5.1 or 5.2 by hand; nothing else changes for it.
`--rebase --autostash` stays for writers, where it replays the writer's own uncommitted edits
before its push.

## 6. Setting up a device

```sh
# A. No ~/.claude yet
git clone https://github.com/new-marty/dotclaude.git ~/.claude

# B. ~/.claude exists (Claude Code has run here): make it a clone, keep its old files aside
cd ~/.claude && git init -b main
git remote add origin https://github.com/new-marty/dotclaude.git && git fetch origin
git reset origin/main && git checkout-index -a
mkdir -p ~/claude-before
git diff --name-only | while read -r f; do mkdir -p ~/claude-before/"$(dirname "$f")"; cp -p "$f" ~/claude-before/"$f"; done
git restore . && cd -
#   Move what you want to keep from ~/claude-before into the local layer (section 4.4).
#   A skill of your own that shows as "?? skills/<name>/": rename it to skills/local-<name>.

# Then, for both:
git -C ~/.claude config dotclaude.role pull-only
git -C ~/.claude branch -u origin/main
cp -n ~/.claude/settings.example.json ~/.claude/settings.json
```

Then edit `settings.json`: drop the `SessionEnd` sync-push hook (it would exit anyway, 5.3);
keep the `SessionStart` sync-pull hook only if hooks are allowed; review
`permissions.defaultMode` and the `skip…Prompt` keys against the company's rules.

Self-check after setup and after each update: `/context` lists `CLAUDE.machine.md` under memory
files, and `/skills` lists the shared skills and the `local-` ones.

The device's commits on `local` use its git identity and signing settings. A company setting
that requires signing makes them fail if the device has no key; signing them with a device key,
or `git -C ~/.claude config commit.gpgsign false`, is a deliberate choice about commits that
never leave the device.

## 7. Changes, file by file

| file | change |
|---|---|
| `scripts/reserved-paths.txt` | new; the list in 4.1 |
| `scripts/check-reserved.sh` | new; reads the list, checks `git ls-files` and the staged set |
| `.githooks/pre-commit` | new; runs the check |
| `.gitignore` | `skills/local-*`, `output-styles/local-*`, the five mac-mini skill names; track `.githooks/` |
| `scripts/sync-push.sh` | exit when `dotclaude.role` is `pull-only` or the branch is not `main`; the check replaces the `RESERVED` loop |
| `scripts/sync-pull.sh` | role-aware behaviour in 5.3 |
| `statusline.sh` | role-aware segment in 5.3 |
| `scripts/test-sync-push.sh` | cases for the role, the branch guard and the reserved check |
| `scripts/test-pull-only.sh` | new; the scenarios in section 9 on scratch clones |
| `README.md` | a "Pull-only devices" section (sections 4 to 6, short); the existing sentences on pull-only machines, the conflict advice (writers only), the "untracked skills" paragraph and the plugin paragraph that calls the repository private, reconciled |
| mac-mini (`~/server`, separate task) | `git config dotclaude.role pull-only` in `~/.claude`; check that `dotclaude-sync.sh` still parses the messages it greps for |

## 8. Failure modes

| what happens | what the person sees | what to do |
|---|---|---|
| A device edits a shared file and pulls with `--ff-only` | the pull refuses and names the file | 5.2 |
| Upstream adds a path a device uses without a reserved name | the pull refuses: "untracked working tree files would be overwritten" | rename to `local-…`, pull again |
| A writer tries to commit a reserved path | sync-push or the pre-commit hook refuses and names it | rename upstream's file |
| A device forgets to pull for weeks | statusline `⇣N` after any fetch; nothing without one | `git fetch` shows it; no reminder without hooks |
| The company blocks `~/.claude/skills` (`strictPluginOnlyCustomization`) | `/skills` lacks the shared skills; no warning | out of scope; the plugin channel (`claude plugin install dotclaude@dotclaude`) is an untested fallback, and CLAUDE.md has no route then |
| A company CLAUDE.md contradicts the local one | Claude may follow either | nothing in dotclaude can rank them |

## 9. Test plan

`scripts/test-pull-only.sh` builds a bare upstream, a writer clone and a device clone in a temp
directory and asserts:

1. Local layer files at every reserved path survive a pull that changes shared files.
2. A writer commit that adds a reserved path is refused by the check.
3. `sync-pull.sh` with role `pull-only` on `main` fast-forwards; with an uncommitted shared edit
   it refuses, prints the file, and leaves the edit in place.
4. On `local`: a non-overlapping upstream change merges cleanly; a same-line change stops with
   `UU` and the documented steps resolve it; a modify/delete stops with `UD`.
5. `sync-push.sh` exits without committing on a pull-only device and on `local`.
6. Writer behaviour is unchanged: the existing `test-sync-push.sh` cases still pass.

`statusline.sh` is checked by rendering it with sample input in each role.

## 10. Decisions for Marty

1. Mark devices with `git config dotclaude.role pull-only` (recommended: one line, survives
   pulls, lets the scripts and statusline adapt) or keep scripts role-blind and tell devices
   which hooks to remove.
2. The `local` branch only when a device edits a shared file (recommended: most devices only
   add) or from day one on every device.
3. Opt the mac-mini in now, as part of this task (recommended: it is the first pull-only device
   and proves the model), or later.

## Evidence

Experiments 2026-10-04 (git 2.50.1, Claude Code 2.1.288), on scratch repositories:
- Untracked local files survive `pull --ff-only`; an ignored local file is overwritten when
  upstream starts tracking its path; an untracked, unignored one makes the pull abort instead.
- On a local branch, merge stops with markers on a same-line conflict, merges silently
  otherwise, and reports `UD` for an upstream deletion; renames carry local edits.
- `pull --rebase --autostash` with a conflicting uncommitted edit exits 0, leaves a stash entry
  and unrelated files staged.
- A missing `@import` target does not fail a session; project-level `.claude/rules/` loads;
  `skillOverrides` works with `"off"` and not with `{"visibility": "hidden"}`.
- `.gitignore` lines for `skills/local-*` work only after `!skills/**` and without a trailing
  slash.
- Two independent inspections of revisions 1 and 2 re-ran the command sequences; their findings
  are folded into this revision.
Not tested: user-level `~/.claude/rules/`; the plugin fallback; a real company Mac.
