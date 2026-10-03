# Stage 1A report: general approaches (2026-10-04)

Saved by the orchestrator from the Stage 1A agent's text report (status DONE_WITH_CONCERNS).
Condensed: the comparison, the recommendation and the sources are kept; the per-approach
prose is shortened.

## Comparison

| approach | local change stored as | upstream changes the same lines | effort per clean update | extra tools | how the user notices an upstream change | main pitfall |
|---|---|---|---|---|---|---|
| A overlay / `.local` | separate untracked file | no conflict; the override silently wins | `git pull` | none (the reader must load a second file) | not automatic; stale overrides invisible | works only where the reader loads a second file; "later wins" is up to the model for instruction text |
| B local branch, merge | commits on a `local` branch | conflict markers; `git add`, `git commit` | `git fetch && git merge origin/main` | none | the conflict, or `git diff HEAD...origin/main -- FILE` | pulling on the wrong branch |
| B local branch, rebase (+rerere) | commits rewritten each update | a conflict per replayed commit; rerere replays only identical conflicts | `git rebase origin/main` | none | as above | stops mid-stack; rerere helps little while upstream moves |
| C `format-patch` + `am --3way` | patch files | `git am` stops; resolve; `--continue` | export, reset, apply | none | only through a failed apply | extra step; silent when the patch still applies |
| C quilt / StGit / TopGit | patch stack | conflict on push/update | one command plus a tool to learn | yes | only through a conflict | niche tool on a locked-down machine |
| D skip-worktree / assume-unchanged | edited file hidden from git | pull refuses; manual unlock, stash, reapply | `git pull` until it breaks | none | none until a failure | git docs: not meant for this; edits invisible to `git status` |
| E chezmoi | source repo + templates / `modify_` scripts | three-way prompt; `chezmoi merge` | `chezmoi update` | chezmoi binary | `chezmoi diff` | a second copy of every file; scripts to maintain |
| E yadm / stow | git in `$HOME` / symlinks | left as is / aborts | `yadm pull` / `stow -R` | yadm / Perl + stow | none beyond git | add nothing git lacks here; stow has no text merge |
| F submodule / subtree | a host repo embedding upstream | merge conflict inside the submodule | `git submodule update --remote --merge` | none | the conflict | detached HEAD; the host repo is not needed here |
| G vendor branch | vendor + local branch | merge conflict on the local branch | fetch, update vendor, merge | none | the conflict | duplicates `origin/main` when upstream is a git remote |

## Recommendation from Stage 1A (input to the design, not decided)

1. Overlay files (A) for local additions: no conflict, no git skill, no hooks. Rests on
   git-config includes (https://git-scm.com/docs/git-config) and Codex's `AGENTS.override.md`
   (https://developers.openai.com/codex/guides/agents-md).
2. A local branch merged with upstream, `rerere.enabled=true` (B), for edits to shared files:
   conflicts show as markers in the file, git only, by hand. Rests on
   https://git-scm.com/book/en/v2/Git-Tools-Rerere.
3. `format-patch` + `am --3way` (C) as a fallback only (https://git-scm.com/docs/git-am).

Rejected: skip-worktree / assume-unchanged ("will fail (gracefully) in case it needs to modify
this file", https://git-scm.com/docs/git-update-index), and chezmoi, yadm, stow, home-manager,
submodule, subtree, vendor branches (each adds a tool or a layout without improving conflicts).
Shape suggested: A for additive content, B for the few edits to shared files.

Other sources: thoughtbot/dotfiles (https://github.com/thoughtbot/dotfiles), chezmoi FAQ
(https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/), Pro Git submodules
(https://git-scm.com/book/en/v2/Git-Tools-Submodules), GNU stow manual.

## Not confirmed by Stage 1A

The skip-worktree pull error text; git subtree behaviour (doc 404); yadm details; StGit, TopGit
and quilt commands and maintenance; tool installs on a locked-down Mac; whether other shared
configs use conventions beyond `.local` and `AGENTS.override.md`.
