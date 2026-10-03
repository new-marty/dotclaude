# Filing in Backlog.md

Read this at step 1 and step 7 of `SKILL.md` when the tracker is Backlog.md. Re-check
the flags against `backlog task create --help` and `backlog task edit --help` when the
CLI is upgraded.

Go through the `backlog` CLI. Do not create or edit the task `.md` files by hand: the CLI
keeps IDs, ordering and the structured sections consistent.

## Establishing the premises

```sh
backlog task list --plain                  # what exists, grouped by status
backlog task create --help                 # the configured types and priorities
```

Read the project's `config.yml` (in `backlog/`, `.backlog/` or the root) for the statuses,
labels and `task_prefix`. The types and priorities appear in the
`--help` output of `create`. Use only those values.

## Searching before writing

```sh
backlog search "invoice pdf" --plain
backlog search "invoice pdf" --type task --status "To Do" --plain
```

## What maps and what does not

| In `SKILL.md` | In Backlog.md |
| --- | --- |
| Issue type | `--type`. Map by what the item does, as in the table in `SKILL.md`: Bug is `bug`, a Story that changes what someone can do is `feature`, upkeep is `chore` or `enhancement`, a Task is `task` |
| Epic | A task that produces no PR. Its children name it with `-p <epic-id>` |
| Parent / sub-issue | `-p <id>` at creation. The task view shows it |
| Blocked-by | `--depends-on <id>` (`--dep`) |
| Acceptance criteria | One `--ac` per criterion. They are a structured, checkable list, so do not repeat them in the description |
| Body | `--description`: Problem and Desired outcome only |
| Findings comment | `backlog task edit <id> --comment "..."`, which appends a comment. `--notes` is a separate field for the implementer, not for this |
| Labels | `-l` / `--add-label`, only those in `config.yml` or already in use. Labels do not stand in for the type |
| Milestone | `-m`. Not needed for the three levels; use it only if the project already does |
| Priority, assignee | `--priority`, `-a @name`. Leave them out unless the person asked |
| Projects board | Not applicable. Status is the board |
| `Closes #n` on the PR | Not applicable. Move the task with `backlog task edit <id> -s "Done"` when the work lands |

## Filing

Title, description and criteria go in one `create`. Multi-line values need real newlines,
so use `$'...'`, not a literal `\n`.

```sh
backlog task create "[invoice] Download a single invoice as PDF" \
  --type feature \
  --description $'## Problem\n<three to five lines>\n\n## Desired outcome\n<one or two lines>' \
  --ac "<observable criterion 1>" \
  --ac "<observable criterion 2>" \
  --plain
```

`--plain` prints the whole new task block and its file path. The ID is the `TASK-n` in
the header; a child gets a dotted ID such as `task-1.1`. Then post the findings, if any.
The CLI stamps each comment with its date and time, so the heading needs no date:

```sh
backlog task edit task-12 --comment $'## Findings at filing\n...' --plain
```

Standalone `---` lines are reserved in comments; do not use them.

Relationships set later:

```sh
backlog task edit task-13 --depends-on task-12
```

The parent can only be set at creation (`-p`). `edit` has no parent flag, so file the
parent first.

## Reading

```sh
backlog task view task-12 --plain          # description, AC, notes, comments, dependencies
backlog task list -p task-10 --plain       # the children of an Epic
```

## References

A task is named by its ID, `task-12`. Write the ID and the title when the reference is
from another repository.
