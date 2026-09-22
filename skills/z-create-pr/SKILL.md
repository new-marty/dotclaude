---
name: z-create-pr
description: Open a Pull Request from the current branch. The description follows the repository's template and is written in terms of what changes for the people who read it. Also triggers on Japanese: 「PR を作って」「PR にして」「push したから PR お願い」「PR 本文を書いて / 下書きして」. Always use it when the intent is to create a PR or write its description — "create a PR", "open a pull request", "write the PR description".
allowed-tools: Bash(git *), Bash(gh pr *), Bash(gh api *), Read, Glob, Grep
---

## Steps

1. Determine the base branch. Do not assume it: check where recent PRs merged with `gh pr list --state merged --limit 10 --json baseRefName,title` and match that. Read the titles in the same output for the repository's title convention. Ask the user when it is unclear. Follow an explicit instruction when there is one.
2. Gather the material: read the commits with `git log origin/<base>..HEAD`, and get the overall shape with `git diff origin/<base>...HEAD --stat` if needed. Identify the related issue from the branch name and the commits.
3. Read the PR template (`.github/pull_request_template.md`, or a file under `.github/PULL_REQUEST_TEMPLATE/`; write flowing prose without headings when there is none). `gh pr create --body` does not apply the template automatically, so fill in that structure yourself. In SDD and checklist fields, tick only what was actually done. Put `Closes #xxxx` on the issue the work completes, to state the intent to close it, and follow it with that issue's title — issues and pull requests share one number sequence, so a bare `#xxxx` says neither which of the two it is nor which level.
4. Draft the title and body, present them together with the base branch, and get the user's approval. Do not run `gh pr create` before approval.
5. After approval, create it with `gh pr create --base <base>` (add `--draft` if asked) and return the URL.

## Title

- **Follow the repository's own convention first.** Read it off recent merged titles with
  `gh pr list --state merged --limit 10 --json title`. A prefix like `refactor:` is there to
  drive release notes, so keep it where the repository uses one and leave it out where it
  does not.
- **Then reuse the title of the issue this closes.** The issue list and the pull request
  list read in the same vocabulary, which is the only thing that makes a number in a comment
  recoverable later. The rules for the title itself live in `z-write-task` — one thing only,
  words the reader already has, about 30 characters in Japanese. **A bad issue title does not
  get inherited.** Rewrite it here, and say so, so the issue can be fixed too.
- **Never put the issue number in the title.** A squash merge appends the pull request's own
  number, so a title ending in `(#5898)` merges as `... (#5898) (#5930)` and neither number
  can be told from the other. `Closes` already carries it.
- No titles that mean nothing without context, like "Fix bug", "Updates", or "Phase 1".

## Writing the body

- Open by stating the purpose in one everyday sentence. Not "the last line of defense against regressions was human review alone", but "CI checks were loose, so they were tightened".
- Include at least one sentence on why this approach was chosen. Code and the diff say what; only the body can say why.
- Do not write file paths, lint rule names, configuration keys, or counts of what was touched. A measurement the reader acts on is a different thing and belongs here. When detail is needed, "see the commits for details" is enough. Tool and feature names (knip, StrictMode, and the like) are things the reader should learn, so they are fine.
- When many files changed, add a line on what to read first. Name features, not paths. A diff is sorted alphabetically and nothing more; the reading order is the writer's job.
- Write the changes field in terms of the effect on the reader — what becomes possible, what stops being possible, what to watch out for — not as a list of changed files.
- In the verification field, write steps a reviewer can follow as they stand. For a UI change, leave before/after screenshot slots.
- No evaluative words. Not "much faster", but "3.2s → 0.4s".
- No tables and no bold. Headings, bullets, and body text only.

The language of the body follows the rules in `CLAUDE.md`. Read `z-japanese-proofreading` when writing in Japanese, and `z-writing-for-readers` in any language.

## Tidying that was outside the task

Keep it in its own commit, and say so in the body, so a reviewer can wear one hat at a time.

```markdown
## Outside the scope of this PR
- abc123 only. Behavior is unchanged; the diff can be skipped on review.
```

The allowance is 50 lines, or a third of the diff. Past that it should have been its own
preparatory pull request.

## Example

Before (the language of the implementation — only a restatement of the diff):

> - Enabled `no-unknown-files` in `eslint-plugin-boundaries` and fixed 42 violating files
> - Added three entries to `ignoreDependencies` in `knip.json`

After (the language of the effect on the reader):

> - CI now fails when a file sits outside the FSD layers. Put new files inside the layer they belong to
> - The false positives in knip are cleared out, so every unused-dependency warning from now on is real

## Before submitting

- It closes exactly one issue. Two means the work should have been two pull requests
- Every part of the diff points at one of that issue's acceptance criteria, or sits in the
  declared tidying commit, or is a preparatory refactoring that changes no behavior
- Any issue named in the body carries its kind and its title, not a bare number
- No file paths or configuration keys left in
- A reviewer can act on the verification field alone
- It passes the check in `z-writing-for-readers`
