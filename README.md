# dotclaude

A repository for keeping Claude Code's user-level configuration (`~/.claude`) in sync
across several machines.

Claude Code keeps global instructions, skills, output styles, and settings in `~/.claude`
in the home directory. The same directory also accumulates runtime state: conversation
logs, caches, authentication tokens. This repository tracks the former and contains none
of the latter.

## What is tracked

| Path | Contents |
| --- | --- |
| `CLAUDE.md` | Global instructions applied to every project |
| `settings.example.json` | The starting point for `settings.json`: output style, permissions, the sync hooks, statusline, enabled plugins, MCP deny rules |
| `statusline.sh` | The script that renders the statusline (called from `settings.json`) |
| `skills/` | Skills. Both hand-written and adopted ones start with `z-` |
| `output-styles/` | Output styles that override how responses are written |
| `scripts/` | Scripts invoked from hooks |
| `ADOPTIONS.md` | A record of what was adopted from elsewhere and what was considered and declined |

`settings.json` itself is not tracked. Each machine keeps its own: Orca injects hooks into
it on machines where Orca runs, and a headless machine runs hooks of its own, so the file
differs from machine to machine and syncing it only produced conflicts. A new machine
copies `settings.example.json` to `settings.json` once (see "Setting up a new machine")
and edits it locally from then on. A change that every machine should have — a new hook,
a permission — goes into `settings.example.json` and is copied by hand.

`.gitignore` is written to **ignore everything by default and allow only what is tracked**.
New runtime files that Claude Code creates never slip into the tracked set. Authentication
tokens (`personal-oauth-token` and the like), conversation logs (`history.jsonl`,
`sessions/`, `projects/`), and caches are all excluded. Beyond the table above, the allow
list covers `.gitignore` itself and `README.md`.

Directly under `skills/` sit symlinks that Orca creates per machine (`computer-use`,
`find-skills`, `orca-cli`, `orchestration`). They are excluded again after the allow lines,
because tracking them leaves broken links on machines without Orca.

To track something new, add an allow line to `.gitignore`. A directory needs two lines
(`!name/` and `!name/**`).

`skills/` mixes hand-written skills with ones adopted from other repositories. An adopted
skill records its source URL and license in a comment at the top of the file. When it was
taken as is, everything but `name` matches upstream. When it was modified — retranslated,
or given an extra section — the same comment says where upstream ends and local work
begins. `name` is rewritten to follow this repository's convention that every skill starts
with `z-`.

That opening comment protects attribution for the file on its own; it gives no overall
view. What was taken from where, what was changed, and what was considered and declined is
recorded entry by entry in `ADOPTIONS.md`. When you decide to adopt or decline something,
add the entry there at the same time you add the skill.

## How syncing works

Hooks registered in each machine's `settings.json` run automatically. No manual pull or
push is needed. `settings.example.json` carries both hooks, so a machine set up from it
syncs from its first session.

| When | What runs | What it does |
| --- | --- | --- |
| Session start | `scripts/sync-pull.sh` | `git pull --rebase --autostash` |
| Session end | `scripts/sync-push.sh` | Commits and pushes if anything changed |

A machine that only pulls (a headless one, say) leaves the `SessionEnd` hook out of its
`settings.json` and pulls on its own schedule instead.

Thanks to `--autostash`, local edits are shelved before the pull and restored afterwards.
`sync-push.sh` takes its lock non-blocking: if another session is already running, the
later session exits without doing anything. It does not queue and run in turn, so that
session's changes stay uncommitted until the next push runs. While an unresolved conflict
exists it does not commit, to avoid pushing conflict markers.

## What the statusline shows

`statusline.sh` renders up to four lines. The first carries account, model, directory, and
git; the second, context usage; the third and fourth, usage limits (the five-hour and
seven-day windows). When usage cannot be fetched — first launch, keychain not yet read, API
failure — lines three and four are omitted and only two remain.

The start of the first line names the account only when it is not the default one. Under
`~/work`, `CLAUDE_SECURESTORAGE_CONFIG_DIR=~/.claude-work` is set and `work` is shown.
Nothing is shown for the default account.

The end of the first line shows this repository's sync state. Nothing is shown when all is
well.

- `.claude ⇡N` — N commits have not been pushed
- `⚠ .claude CONFLICT` — there is an unresolved conflict

### Usage per account

Claude Code stores separate credentials per account in the login keychain. The default
account uses the service name `Claude Code-credentials`; an account selected through
`CLAUDE_SECURESTORAGE_CONFIG_DIR` uses `Claude Code-credentials-<tag>`, where `<tag>` is the
first eight digits of the SHA-256 of that directory's absolute path.

The statusline builds the service name by this rule and shows the usage of whichever
account is actually signed in. The cache (`/tmp/claude-usage-cache*.json`) is also split per
account, so two accounts never overwrite each other's numbers.

When `⇡N` will not go away, the push is failing: the SSH agent is locked, the network is
down, or the remote has moved ahead.

## When a conflict happens

`⚠ .claude CONFLICT` means two machines changed the same file. The hooks exit without doing
anything once they detect a conflict, so resolve it yourself.

```bash
git -C ~/.claude status          # see which files conflict
git -C ~/.claude diff            # look at the conflicting hunks
# edit the files and remove the conflict markers
git -C ~/.claude add <file>
git -C ~/.claude rebase --continue
```

The pre-pull state also remains in the stash (`git -C ~/.claude stash list`).

## Setting up a new machine

The dotfiles repository (`github.com:<you>/dotfiles`) runs
`run_once_before_bootstrap-dotclaude.sh` automatically. The only step is
`chezmoi init --apply git@github.com:<you>/dotfiles.git`.

That script turns `~/.claude` into a git repository in place. Cloning does not work: the
Claude Code installer creates `~/.claude/downloads/` and others first, so `git clone` fails
with "directory not empty".

Files that already exist on the machine are not overwritten. Where the content differs from
the remote, the local version stays and shows up as a change in `git status`. Which one to
keep is decided by hand.

Then create the machine's own `settings.json` from the tracked starting point, unless
Claude Code has already written one you want to keep:

```bash
cp -n ~/.claude/settings.example.json ~/.claude/settings.json
```

Without this step no sync hook is registered and the machine never pulls or pushes.

To do it manually:

```bash
mkdir -p ~/.claude && cd ~/.claude
git init -b main
git remote add origin git@github.com:new-marty/dotclaude.git
git fetch origin main
git branch -f main origin/main && git symbolic-ref HEAD refs/heads/main
git branch -u origin/main main
git reset origin/main
git checkout-index -a          # write out only the files that do not exist
cp -n settings.example.json settings.json
```

### If this machine tracked `settings.json` before

`settings.json` was tracked until 2026-09-26. Pulling the commit that stopped tracking it
deletes the file from the working tree on a machine that still has the tracked version,
and with it the sync hooks. Before that pull, keep a copy and put it back afterwards:

```bash
cp ~/.claude/settings.json ~/.claude/settings.json.bak
git -C ~/.claude update-index --no-skip-worktree settings.json   # only if it was skip-worktree
git -C ~/.claude checkout -- settings.json                        # only if it was skip-worktree
git -C ~/.claude pull --rebase
cp ~/.claude/settings.json.bak ~/.claude/settings.json
```

After that the file is ignored by git, so local edits never conflict with a pull again.
