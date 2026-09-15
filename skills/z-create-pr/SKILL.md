---
name: z-create-pr
description: Open a Pull Request from the current branch. The description follows the repository's template and is written in terms of what changes for the people who read it. Also triggers on Japanese: 「PR を作って」「PR にして」「push したから PR お願い」「PR 本文を書いて / 下書きして」. Always use it when the intent is to create a PR or write its description — "create a PR", "open a pull request", "write the PR description".
allowed-tools: Bash(git *), Bash(gh pr *), Bash(gh api *), Read, Glob, Grep
---

## Steps

1. Determine the base branch. Do not assume it: check where recent PRs merged with `gh pr list --state merged --limit 5 --json baseRefName` and match that. Ask the user when it is unclear. Follow an explicit instruction when there is one.
2. Gather the material: read the commits with `git log origin/<base>..HEAD`, and get the overall shape with `git diff origin/<base>...HEAD --stat` if needed. Identify the related issue from the branch name and the commits.
3. Read the PR template (`.github/pull_request_template.md`, or a file under `.github/PULL_REQUEST_TEMPLATE/`; write flowing prose without headings when there is none). `gh pr create --body` does not apply the template automatically, so fill in that structure yourself. In SDD and checklist fields, tick only what was actually done. Put `Closes #xxxx` on an issue the work completes, to state the intent to close it.
4. Draft the title and body, present them together with the base branch, and get the user's approval. Do not run `gh pr create` before approval.
5. After approval, create it with `gh pr create --base <base>` (add `--draft` if asked) and return the URL.

## Title

- One line that stands on its own. Someone skimming the history reads nothing but the title.
- No titles that mean nothing without context, like "Fix bug", "Updates", or "Phase 1".

## Writing the body

- Open by stating the purpose in one everyday sentence. Not "the last line of defense against regressions was human review alone", but "CI checks were loose, so they were tightened".
- Include at least one sentence on why this approach was chosen. Code and the diff say what; only the body can say why.
- Do not write file paths, lint rule names, counts, or configuration keys. When detail is needed, "see the commits for details" is enough. Tool and feature names (knip, StrictMode, and the like) are things the reader should learn, so they are fine.
- When many files changed, add a line on what to read first. Name features, not paths. A diff is sorted alphabetically and nothing more; the reading order is the writer's job.
- Write the changes field in terms of the effect on the reader — what becomes possible, what stops being possible, what to watch out for — not as a list of changed files.
- In the verification field, write steps a reviewer can follow as they stand. For a UI change, leave before/after screenshot slots.
- No evaluative words. Not "much faster", but "3.2s → 0.4s".
- No tables and no bold. Headings, bullets, and body text only.

The language of the body follows the rules in `CLAUDE.md`. Read `z-japanese-proofreading` when writing in Japanese, and `z-writing-for-readers` in any language.

## Example

Before (the language of the implementation — only a restatement of the diff):

> - Enabled `no-unknown-files` in `eslint-plugin-boundaries` and fixed 42 violating files
> - Added three entries to `ignoreDependencies` in `knip.json`

After (the language of the effect on the reader):

> - CI now fails when a file sits outside the FSD layers. Put new files inside the layer they belong to
> - The false positives in knip are cleared out, so every unused-dependency warning from now on is real

## Before submitting

- No file paths, counts, or configuration keys left in
- A reviewer can act on the verification field alone
- It passes the check in `z-writing-for-readers`
