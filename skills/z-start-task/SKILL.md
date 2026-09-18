---
name: z-start-task
description: Start from "which task are we doing?" by reading the plan documents against the issues, agree on scope and design through back-and-forth, then go on to create the branch, review the design, implement, and self-review. Use it whenever the intent is to pick up work — "what should I work on next", "let us start a task", "pick up that issue", 「次何やる?」「タスク始めたい」「Issue に着手したい」「リファクタリングの続きをやろう」
argument-hint: "[plan directory or issue number] [extra instructions](optional)"
allowed-tools: Bash(git *), Bash(gh issue *), Bash(gh pr *), Bash(gh repo *), Read, Edit, Write, Glob, Grep
---

Go from choosing the task to finished, self-reviewed work, building agreement at each step.
Never assume the repository-specific facts — base branch, where the plan documents live,
verification commands, development flow. Look them up in step 0 every time.

## Core principles

1. The conversation starts from "which task are we doing?". Never start working straight away.
2. Agreement is staged, coarse to fine. Write the opening of each stage at the level "How to explain" describes, and move to the finer discussion only once you have agreement.
3. Do not trust an issue as a specification. The plan documents and the current code are what is real. When an issue and reality disagree, suspect the issue and propose rewriting it.
4. Do not skip the agreement checkpoints. The order is: agree on the task → explain the whole picture and grill → branch → design approval → implementation. Do not do the next stage's work before you have approval.
5. For every proposal the user makes, write at least one alternative or one reason against it. When you have none, say "no objections" explicitly. Never reply with agreement alone.

## Development principles

- Do not change a file that is not in the agreed "what we are doing". For something you noticed "while in there", take one of the four exits in `z-write-task` — filing it is only one of them, and rarely the right one.
- When in doubt, choose the simpler option. If both layers can ship in the same PR, do not write a shim for the old schema (an Optional field, a preserved default).
- Search for an existing implementation before writing one. If you are writing the same thing twice, fold factoring it out into the design.
- Where code goes follows the dependency direction of the layering the repository uses.

## How to explain

Write the whole picture assuming the reader has read neither the issue nor the plan.

- Keep jargon, abbreviations, and in-house terms out of the first explanation. When one is unavoidable, add a one-line paraphrase on the spot
- Write prose first, in this order: what it is for, how things stand now, and what changes. Break it into tables and bullets only afterwards
- One metaphor is allowed. Do not stop at the metaphor: map it onto the real thing immediately after
- Call `z-show-me` when a picture is faster
- Hold to this level at the opening of each stage: the whole plan in step 2, the whole picture of the task in step 3, the outline of the design in step 5. Once you have agreement and the discussion turns to detail, normal vocabulary is fine

## Steps

### 0. Establish the repository's premises

Before starting the conversation, settle how work is actually done in this repository.

- Repository name: `gh repo view --json nameWithOwner -q .nameWithOwner`
- Base branch: look at the base of recently merged PRs (`gh pr list --state merged --limit 5 --json baseRefName`). Do not assume `main`. Ask the user when it is unclear.
- Plan documents: look in `docs/plans/`, `docs/specs/`, `plans/`, `ROADMAP.md`, and the like. If a README, INDEX, or audit file holds the overall picture, start from that.
- Development flow documents: read `CLAUDE.md`, `AGENTS.md`, `CONTRIBUTING.md`, and any flow documents under `docs/`. Where they define issue status handling, branch naming, or how to request review, they take precedence over the steps in this skill.
- Verification commands: identify what has to pass before pushing, from `Taskfile.yml`, `Makefile`, the scripts in `package.json`, and the CI configuration (`.github/workflows/`).
- Tools for exploring the code: use an index such as GitNexus where the environment has one, and Grep and Glob otherwise.

Where a premise you established might differ from what the user believes — the base branch, where the plans live — add a line confirming it to what you present in step 2.

### 1. Take stock

- Read the plan documents and grasp what the plan is trying to do
- Fetch what has been filed and what is in flight:
  ```
  gh issue list --state all --limit 100
  gh pr list
  git branch -a
  ```
- Build a picture of how far things have got, from open and closed issues, PRs in flight, and existing branches

When `$ARGUMENTS` carries a plan directory or an issue number, narrow to that; otherwise draw candidates from the whole plan. Respect any extra instructions after the number.

### 2. Discuss the task

- Put "which task are we doing?" to the user with AskUserQuestion. Format:
  - Two or three sentences of the whole picture first: what this plan is trying to do. Do not assume the user holds the whole picture
  - At most three candidates. For each: what the issue does in one line, how it sits against dependencies and PRs in flight, and your recommendation with its reason
- Share here anything the plan-against-issues comparison turned up: gaps never filed, work tracked twice, drift from the plan, a change in urgency. When issues need rewriting, propose that before picking up a task
- When filing or rewriting an issue, make the body say what happens if it is left alone (an incident, a longer lead time), and make the acceptance criteria verifiable

### 3. Explain the whole picture and grill it into shape

This is where agreement is won. Do not skip this stage and start working. Do not reorder it either.

1. Explain the whole picture of the chosen task. At the level "How to explain" describes, in prose, in this order:
   - What this task is for. What goes wrong if it is left alone
   - How the current code or operation works, and where the problem is
   - What will be different when it is done (from the user's side, and from the code's side)

   If you do not have the material to explain it, research the current code and the related documents first. Look it up yourself before asking the user
2. Give "what we are doing" and "what we are not doing", two or three lines each
3. Call `z-grilling`. Ask at least one question on each of five things: the boundary of the scope, consistency with existing behavior, whether data migration is needed, how errors are handled, and how far the tests go. Anything not asked here comes back as rework after implementation
4. Where the grilling exposed a mismatch, rewrite "what we are doing / what we are not doing" and agree again
5. If a development flow document found in step 0 defines issue status handling, change the status here to mark the work started

### 4. Create the branch in a worktree

- Do not run `git checkout -b` or `git switch -c` on the main or base branch checkout. Several tasks run in parallel, and occupying that checkout with one task gets in the way of the others
- Create the branch and the worktree together with the EnterWorktree tool. Fall back to `git worktree add` only where that tool is unavailable
- Run `git fetch origin <base>` first so the branch starts from the base branch. Name the branch by the convention found in step 0, or `{type}/{number}-{short-description}` (feat / fix / refact / docs / chore) when there is none
- When the work touches the same files as a PR in flight, propose branching from that PR's branch instead, and say that the PR's base will need adjusting
- Leave with ExitWorktree when the task is done. Ask the user whether to keep or remove the worktree

### 5. Decide the design and the approach

- Investigate the current code. Understand the blast radius before proposing a design
- Check the design against the conventions read in step 0: layering, UI conventions, migration procedure, whether spec-driven development applies
- Present the outline of the approach as one or two paragraphs of prose and get agreement. Do not break the outline into tables or lists
- Once the outline is agreed, list the implementation-level decisions step 3 could not settle — how to split functions, whether an existing implementation can be reused. Call `z-grilling` again if any remain. What is settled here becomes the scope and the order of implementation
- When it is settled, present the scope, the order of work, what is out of scope, and how it will be verified, and ask for review
- This is the only point at which the work may be split into more than one pull request. If it does not fit in one, call `z-write-task` to file the Tasks; splitting anywhere earlier can only follow the shape of the code
- When the user asks "what do you think?", stop at options and a recommendation. Do not run ahead into implementation
- Do not implement until the user approves

### 6. Implement

- Do not change a file that is not in the agreed "what we are doing". Match how the existing files are written
- Before changing a symbol with a wide blast radius, list its callers
- When you add or change tests and the repository tracks test requirements in a document, include that in the same change
- When you change a mechanism, an operational procedure, or CI, write a lasting explanation of it — without being asked

### 7. Self-review and call it done

- Self-review with the `code-review` skill, or the repository's own review skill. Read your code as someone else's. Look at correctness, scope creep, where the code was placed, and naming. Fix what it finds before moving on
- Run the verification commands identified in step 0. In a repository where the formatter is a separate job from lint, run the formatter before pushing too
- Commit and push. Match the language and the format of the commit message to the recent commit log
- If a flow document found in step 0 defines pre-PR work such as a QA checklist, say here that it will be needed
- Do not create the PR. Just say that `z-create-pr` can create it

## Cautions

- Do not create a PR automatically
- Do not force push. Fix an already-pushed branch with an additional commit
- Where commit signing uses 1Password, a locked vault fails with `failed to write commit object`. Ask for it to be unlocked and retry
- When an issue is too large, propose splitting it before proceeding
- Do not commit or push directly to a protected branch
- Create branches in a worktree (step 4). Keep the base branch checkout free for any other task at any time
