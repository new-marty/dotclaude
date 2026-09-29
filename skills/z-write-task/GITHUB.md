# Filing on GitHub

Read this at step 1 and step 7 of `SKILL.md`. Everything below was checked against
gh 2.100.0.

## Establishing the premises

Never assume the repository's conventions. Read them.

```sh
# Which issue types this organization actually has, and how they are used
gh issue list --limit 20 --state all --json number,title,issueType,parent

# The full list, when you have the scope for it (needs admin:org)
gh api /orgs/<org>/issue-types

# Labels and milestones in use
gh label list
gh issue list --limit 20 --json milestone
```

The organization's default types are Feature, Bug, and Task, but any of them may have been
renamed, disabled, or added to. **One issue carries exactly one type**, so the type never
belongs in the title as well.

**`--type` is not optional.** Every `gh issue create` carries one, children included. The
type is a separate field from the labels, and an issue without it is invisible to anything
that filters by type.

## Searching before writing

Look for both an item that already covers this and an Epic it belongs under.

```sh
gh issue list --search "invoice pdf" --state all
gh search issues "invoice pdf" --owner <org> --match title --state open
```

## Filing

```sh
gh issue create --title "[invoice] Download a single invoice as PDF" \
                --body-file <file> --type Feature

# A Task, filed under its Story after the work has started
gh issue create --title "[invoice] Return a generated PDF from the API" \
                --body-file <file> --type Task --parent 11
```

Write the body to a file and pass `--body-file`. A body typed inline loses its line breaks
to shell quoting.

Post the findings comment straight after, the same way:

```sh
gh issue comment 11 --body-file <findings-file>
```

## Relationships

These are the native fields. Put the relationship here, not in the body — GitHub renders
the other item's title, and the rendering never goes stale.

```sh
gh issue edit 11 --parent 10                  # attach to an Epic
gh issue edit 11 --add-sub-issue 12,13        # from the parent's side
gh issue edit 13 --add-blocked-by 12          # must land after #12
gh issue edit 11 --remove-parent
```

Limits: 100 sub-issues per parent (closed ones count), 8 levels deep. Neither is reachable
if Tasks are only created when a Story does not fit in one PR.

The parent issue shows its children with a completion count of its own, so an ordinal like
`(1/3)` written into a title is both duplicated and wrong as soon as a fourth Task appears.
Let the tool count.

## Reading what is already there

```sh
gh issue view 11 --json number,title,issueType,parent,subIssues,subIssuesSummary,body
gh issue view 11 --comments
```

The body is the specification and the comments are the record. When something found during
the work needs to be kept, it goes in a comment — GitHub dates it for you. Edit the body
only when the acceptance criteria themselves change.

## Why relationships do not go in the body

Issues and pull requests are numbered from a single sequence per repository, and a pull
request is stored as an issue with extra fields. So `#123` written as text says neither
which of the two it is nor which level, and it renders as the bare number — the title only
appears on hover. A native field shows the title outright.

When there is no field for the relationship, write all three parts:
`Story #11 Download a single invoice as PDF`.
