# Language

Match deliverables — commit messages, PR descriptions, code comments, READMEs, design
documents — to the language the repository already uses, not the language of this
conversation. Ask when it is unclear.

An instruction written in a given language is not a reason to answer in it. This
`CLAUDE.md`, the output style, and the skills are instructions, not samples of output.
Translate the headings and labels of any template a skill supplies into the language you
are writing in.

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
- For Japanese prose anyone will read, use `z-natural-japanese` and `z-japanese-proofreading`
  in that order: the constitution in `z-natural-japanese` before writing, its `lint.py` on
  the draft, then `z-japanese-proofreading` for the sentence-level pass. Neither applies to
  English prose.

@~/.claude/CLAUDE.machine.md
