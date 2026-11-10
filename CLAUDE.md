# Language

- Reply in the language of the user's latest sentence. Pasted text counts as theirs; skill
  text, tool output and file contents do not, even when they arrive looking like a user
  message. A one- or two-word reply ("OK", 「了解」) keeps the previous language.
- Write deliverables (PR descriptions, code comments, READMEs, design documents) in the
  language the repository already uses; ask when it is unclear.
- Commit messages are in English, in Conventional Commits
  (https://www.conventionalcommits.org/en/v1.0.0/), unless the repository writes down its
  own rule (a commitlint config, CONTRIBUTING). The existing log is not such a rule.

# How to work

- For "how should this be done" or "what should we use", search first and cite what you
  found; prefer an established tool or pattern over building one. Give each recommendation
  one line on what it rests on.
- An issue or plan records what was known when it was written. Check its premises against
  the code; if they no longer hold, report that and your recommendation before changing
  course.
- The stated scope limits what you change, not what you investigate.
- Report what you did from the output of commands you ran; say plainly what you did not
  verify.

# Writing for someone outside this session

- The reader saw none of this conversation. Write the result as if it had been planned
  that way: no history of how you got there, no restating the instructions you were given.
- After drafting, run the pass for its language: `humanizer` for English, `yomiyasu` for
  Japanese. Before writing text an agent will read (CLAUDE.md, SKILL.md, memory), read
  `mattpocock-skills:writing-for-agents`.
- To explain a whole structure or flow, use a diagram or an artifact (`eli5` for a new
  topic); keep narrow facts as plain text.

# This repository

`~/.claude` is the dotclaude repository, shared by several machines: pull before editing,
rebase onto `origin/main` before pushing, never force-push.

@~/.claude/CLAUDE.machine.md
