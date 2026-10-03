# Orchestration run 2026-10-03: TASK-8 and TASK-2

A new session resumes from this file (progress table and briefs), not from memory.

## Progress

| unit | stage | status | branch / commit | last inspection (dropped AC / bugs / scope creep) | by | date | note |
|---|---|---|---|---|---|---|---|
| TASK-8 | implement | running | | | subagent | 2026-10-03 | |
| TASK-8 | verify | untouched | | | | | |
| TASK-2 | implement | running | | | subagent | 2026-10-03 | |
| TASK-2 | verify | untouched | | | | | |
| TASK-1 | — | held | | | | | touches sync-push.sh (RESERVED list); needs ~/server changes and a deliberate mac-mini switch with Marty present |
| TASK-3 | — | held | | | | | needs Marty's main machine |

## Rulings

- Only TASK-8 and TASK-2 run in parallel: their write paths are disjoint. Reason: TASK-1 also edits sync-push.sh. Cost if wrong: a merge conflict, resolved by hand.
- Each implementer works in its own git worktree; the orchestrator merges into main. Push to origin/main waits for Marty's OK.

## Rules for every agent

- Write only your owned paths. Commit only those paths (`git commit -m ... -- <paths>`), never `git add -A` / `commit -a`.
- Commit messages: English, Conventional Commits. End with the Co-Authored-By line your own session instructions give for the model you run on.
- Do not push. Do not touch `~/.claude` (the live checkout on this machine: pull only, never edit or push). Do not edit `backlog/`.
- Temporary files go in your scratchpad or `~/tmp`.
- Return a text report ending with one status: DONE, DONE_WITH_CONCERNS, NEEDS_CONTEXT or BLOCKED (with a reason).

## Brief: TASK-8 implement

Read the task: `backlog task view task-8 --plain` (run in /Users/gary/dev/dotclaude).

- Target: `scripts/sync-push.sh` (SessionEnd hook, see `settings.example.json`).
- Change: before pushing, fetch origin and rebase the local commits onto origin/main; if the rebase conflicts, abort it (leave the tree as it was before the rebase), do not push, and make the outcome visible to the user. Purpose: with two machines pushing, a session that started before the other machine's push currently ends in a silent non-fast-forward rejection and commits stay local unnoticed.
- Visibility (AC #2): stderr of a SessionEnd hook is not shown to the user. Check the Claude Code hooks docs (https://code.claude.com/docs/en/hooks) for what SessionEnd output reaches the user, then pick a mechanism that does: for example a marker file that `scripts/sync-pull.sh` reports at the next SessionStart and/or `statusline.sh` shows. Keep it simple; state what you chose and why, citing the docs.
- Constraints: keep the existing lock, the unresolved-conflict guard and the RESERVED check working. Never leave the repository mid-rebase. Never force-push. macOS bash 3.2 and BSD tools must work.
- Testability: the script hard-codes `DIR="$HOME/.claude"`. Allow overriding it (e.g. `DIR="${CLAUDE_SYNC_DIR:-$HOME/.claude}"`) so it can be tested on scratch clones. Never run it against the real ~/.claude.
- Owned paths: `scripts/sync-push.sh`, `scripts/sync-pull.sh`, `statusline.sh`, `README.md` (only the sync description, if behaviour described there changes).
- Observable acceptance (AC #3): a test with a bare repo and two clones in a scratch directory: clone A pushes, clone B has an unpushed commit and runs the script → B's commit lands on the remote after a rebase. Second case: conflicting edit → no push, B is not mid-rebase, the user-visible signal is produced. Put the test as a script (e.g. `scripts/test-sync-push.sh`, add it to owned paths) only if it stays short; otherwise paste the transcript in your report.
- Output: what changed, the test transcript, the commit hash, status.

## Brief: TASK-2 implement

Read the task: `backlog task view task-2 --plain` (run in /Users/gary/dev/dotclaude).

- Target: `skills/z-start-task/SKILL.md`, `skills/z-write-task/` (SKILL.md, GITHUB.md, EVALS.md).
- Change: both skills currently assume GitHub Issues (`gh issue ...`). Make them detect the project's tracker and use it: Backlog.md (`backlog/config.yml` present → `backlog` CLI: `backlog task list --plain`, `backlog task view`, `backlog task create`, `backlog task edit -s/-a`), a tracker the project's CLAUDE.md / AGENTS.md names (that rule wins), and GitHub Issues only as fallback. Purpose: today z-start-task found an empty `gh issue list` in this very repository and had to read backlog/ by hand.
- Design hints: write the detection once per skill, near step 0, as a short ordered rule. Keep tracker-specific commands in one place (z-write-task already has GITHUB.md for GitHub specifics; a sibling BACKLOG.md is a reasonable shape). Concepts that do not map (labels, milestones, issue comments, sub-issues) need a stated equivalent or "not applicable". Verify CLI flags against `backlog --help` / `backlog task create --help` rather than memory.
- Constraints: keep each SKILL.md under 500 lines, keep the existing voice and structure; do not rewrite unrelated parts. Skill text is English. Follow `skills/z-writing-for-readers` ("Text for agents") and run the `z-humanizer` pass on what you add. If the descriptions' frontmatter changes, it must still parse as YAML.
- Owned paths: `skills/z-start-task/`, `skills/z-write-task/`.
- Observable acceptance: `grep -n "gh issue" skills/z-start-task skills/z-write-task -r` shows only lines inside GitHub-specific sections/files; each AC of TASK-2 is pointed to a line.
- Output: what changed per file, AC → line mapping, commit hash, status.

## Brief: verify (one per unit, independent)

You see only the task (`backlog task view task-N --plain`) and the diff (`git -C <worktree> diff main...<branch>`), plus the files it touches. Not the implementer's report.

Count, strictly, each of: AC not met (dropped), AC weakened, behaviour added beyond scope, existing behaviour broken, form broken (shell syntax, YAML, markdown). For TASK-8 also re-run the two-clone test yourself in a fresh scratch directory (never against ~/.claude), and `bash -n` / `shellcheck` if available. For TASK-2 also check the `backlog` commands against `backlog --help`.

Output: the counts table, each finding with file:line and a one-line failure scenario, status.
