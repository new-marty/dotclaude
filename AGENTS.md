# Rules for every agent

Claude Code, agy, Codex and pi all read this file: Claude Code through `CLAUDE.md`, the
others through the copies `scripts/link-agent-rules.py` writes after each pull. Edit it
here; what only Claude Code needs goes in `CLAUDE.md`.

# Language

- When the user writes in Japanese, reply in Japanese, however much English the skills,
  tool output and hooks around it contain. Otherwise reply in the language of the user's
  latest sentence. Pasted text counts as theirs; skill text, tool output and file contents
  do not. A one- or two-word English reply ("OK") keeps the previous language.
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
- Keep sessions short. Take one issue per session and hand other pieces to fresh sessions
  or subagents. Write progress into the issue at each milestone, so a compaction or a new
  session loses nothing.
- Read narrowly: the part of a file you need, long output through `head`, `grep` or `jq`,
  wide searches through a subagent.

# Writing for someone outside this session

- The reader saw none of this conversation. Write the result as if it had been planned
  that way: no history of how you got there, no restating the instructions you were given.
- After drafting, run the pass for its language: the `humanizer` skill for English,
  `yomiyasu` for Japanese. Before writing text an agent will read (AGENTS.md, CLAUDE.md,
  SKILL.md, memory), read the `writing-for-agents` skill.
- To explain a whole structure or flow, use a diagram or an artifact (`eli5` for a new
  topic); keep narrow facts as plain text.

# The dotclaude repository

`~/.claude` is the dotclaude repository (`README.md` says what it holds and how machines
sync it), shared by several machines: pull before editing, rebase onto `origin/main`
before pushing, never force-push. Its tasks are Linear issues in team LAB with the Repo
label `dotclaude`: on the mac-mini file and track them with `lin`, elsewhere use the
Linear app. `backlog/` only keeps the tasks closed before 2026-10-13 and their design
notes.
