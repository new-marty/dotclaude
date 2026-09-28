# Language

Match deliverables — PR descriptions, code comments, READMEs, design documents — to the
language the repository already uses, not the language of this conversation. Ask when it
is unclear. Commit messages follow the next section instead.

An instruction written in a given language is not a reason to answer in it. This
`CLAUDE.md`, the output style, and the skills are instructions, not samples of output.
Translate the headings and labels of any template a skill supplies into the language you
are writing in.

# Commit messages

Write them in English, in the Conventional Commits format:
`<type>[(scope)][!]: <description>`, then an optional body and footers
(https://www.conventionalcommits.org/en/v1.0.0/). Use `feat` for a new feature and `fix`
for a bug fix; for the rest, pick from `build`, `chore`, `ci`, `docs`, `perf`,
`refactor`, `style`, `test`. Mark a breaking change with `!` or a `BREAKING CHANGE:`
footer.

The only exception is a rule the repository writes down: a commitlint config, CONTRIBUTING,
or similar. Then follow it exactly. The existing commit log is not such a rule, even when
it is in Japanese or in another format, because agents wrote much of it.

This rule covers the commits a reviewer reads on the branch. PR titles follow `z-create-pr`,
so where a squash merge turns the title into the commit on the base branch, that commit
carries no prefix. Leave it that way.

# How to work

1. **Look it up before asserting it.**
   - Before answering "how should this be written", "what should we use", or "what is the
     best practice", search the web instead of writing from memory, and cite what you
     found. Check whether an established pattern or an existing implementation already
     covers it; build your own only after confirming none does.
   - Do not give a recommendation while research that could overturn it is still
     outstanding. Attach one line to each recommendation saying what it rests on.
   - If it is overturned anyway, state only the new fact and the new recommendation. Do
     not recount how the previous one came about.

2. **Check before starting.**
   - An issue, ticket, or plan records what was known when it was written; it is not a
     specification. Decide what to build and how by reading the code and researching the
     standard approach. "Because it says so" is not a reason.
   - When your research contradicts the plan, do not quietly switch. Report the
     contradiction and your recommendation first.
   - If the task is part of a sequence, look at the tasks before and after it first.
   - The stated scope bounds what you change, not what you consider. When the cause lies
     outside it, investigate that far and still change only what is in scope.

3. **Report from output, not memory.**
   When stating what you did or what changed, write it from the output of commands you ran
   this turn. For anything you have no output for, say you did not verify it.

# When to read a skill

- Read `z-writing-for-readers` before writing anything a reader outside this session will
  see: documentation, READMEs, design documents, PR descriptions, commit messages, issues.
- After the draft, run the pass for its language. English: `z-humanizer`. Japanese:
  `z-natural-japanese` (the constitution before writing, its `lint.py` on the draft) and
  then `z-japanese-proofreading`. Neither pass applies to the other language.

@~/.claude/CLAUDE.machine.md
