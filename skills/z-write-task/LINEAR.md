# Filing in Linear (`lin`)

Read this at step 1 and step 7 of `SKILL.md` when the project's `AGENTS.md` or `CLAUDE.md`
names Linear and the `lin` CLI as its tracker. Check the flags against `lin add --help`
when the CLI changes.

Go through `lin`. Do not wrap it in a script, and do not call the Linear API directly.
`lin` fills in the Repo label from the current git top-level, so run it inside the
repository the item belongs to.

## Establishing the premises

```sh
lin list                 # open issues of the current repository (--all for every repository)
lin add --help           # the types and priorities
```

## Searching before writing

```sh
lin list --all --state Todo      # filter by state or --type, then read titles
lin show LAB-12                  # body, relations, comments
```

`lin` has no free-text search. Scan the listing, and open the likely hits with `show`.

## What maps and what does not

| In `SKILL.md` | In Linear |
| --- | --- |
| Issue type | `--type Research|Decision|Feature|Fix|Chore`. Bug is `Fix`, a Story that changes what someone can do is `Feature`, upkeep is `Chore`. Optional |
| Epic | An issue that produces no PR. Its children name it with `--parent <ID>` |
| Parent / sub-issue | `--parent <ID>` at creation |
| Blocked-by | `--after <ID>[,<ID>]` |
| Acceptance criteria | One `--ac` per criterion. With at least one, the issue starts in Todo; without, in Triage. They are a checklist, so do not repeat them in the body |
| Body | `--detail`: Problem and Desired outcome only |
| Findings comment | `lin comment <ID> -m "..."` |
| Priority | `--priority urgent|high|normal|low` (default normal). Leave it out unless the person asked |
| Repo label | Automatic from the current repository; `--repo <name>` to override. A leaf issue stays inside one repository; work across repositories is a parent with one child per repository |
| `Closes #n` on the PR | Not applicable. Close with `lin done <ID> -m "..."` when the work lands |

## Filing

```sh
lin add --title "[invoice] Download a single invoice as PDF" \
  --type Feature \
  --detail $'## Problem\n<three to five lines>\n\n## Desired outcome\n<one or two lines>' \
  --ac "<observable criterion 1>" \
  --ac "<observable criterion 2>"
```

The result names the new ID. Then post the findings, if any:

```sh
lin comment LAB-12 -m $'## Findings at filing\n...'
```

## Reading

```sh
lin show LAB-12                  # body, relations, comments
lin list --state Todo            # open work
lin next                         # the next unblocked Todo, by priority
```

## References

An issue is named by its ID, `LAB-12`. Write the ID and the title when the reference is
from another repository.
