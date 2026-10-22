# Coverage

The three checks every package passes, the tables they read, and how to run them. Size
never relaxes these: a small app with a missing empty state ships a blank screen just the
same.

Contents: table formats; check 1, forgotten screens; check 2, flows and screens; check 3,
states; evidence labels; running the script; checking by hand.

## Table formats

`scripts/check_package.py` reads only tables that are introduced by a marker comment on the
line above. Column headings may be in the user's language, except where noted, because the
script reads columns by position. Write `n/a: <reason>` (with the English `n/a:`) for
anything deliberately left out, so the script can tell a decision from a gap.

IDs: screens `SC-01`, `SC-02`…; flow steps `F<flow>-<step>`, such as `F1-03`. Keep IDs stable
once written; other tables refer to them.

```markdown
<!-- ux:screens -->
| ID | Name | Purpose | Primary action | Used by |
| --- | --- | --- | --- | --- |
| SC-01 | Holds | See what is ready to pick up | Pick up | F1-02, F2-01 |
```

"Used by" is the last column and lists the flow steps or object actions that lead here
(`F1-02`, or `object: Book list`), for the reader. The script checks that the step IDs in it
exist; whether a screen is reached is decided by the other tables (check 2).

```markdown
<!-- ux:objects -->
| Object | List | Detail | Create / edit |
| --- | --- | --- | --- |
| Book | SC-03 | SC-04 | n/a: added only by the nightly catalogue import |
```

```markdown
<!-- ux:flow-steps -->
| Step | Actor | Action | System response | Screen | Failure branches |
| --- | --- | --- | --- | --- | --- |
| F1-01 | member | taps "Place hold" | hold created, position shown | SC-04 | already holding → show existing hold; limit reached → explain limit and link to holds |
```

The "Failure branches" cell is never empty: list the branches, or write
`none: <reason>`.

```markdown
<!-- ux:sweep -->
| Item | Decision |
| --- | --- |
| sign-in | SC-08 |
| account deletion | n/a: accounts are managed by the library system |
```

```markdown
<!-- ux:states -->
| Screen | empty | loading | error | permission | offline | conflict | extreme |
| --- | --- | --- | --- | --- | --- | --- | --- |
| SC-01 | "No holds yet" + link to search | skeleton rows | keep list, banner with retry | n/a: every member may see their own holds | cached list, actions disabled with reason | hold cancelled elsewhere → row greys out with note | 200 holds: group by status |
```

In the states table the English column keys (`empty`, `loading`, `error`, `permission`,
`offline`, `conflict`, `extreme`) must appear in the headings, optionally followed by a
translation such as `empty (空)`. Add more columns where the case needs them (limit reached,
needs setup, session expired, destructive action, first run, returning after a gap).

## Check 1: no forgotten screens

- **Objects.** For every object in the `ux:objects` table, decide on a list, a detail and a
  create/edit screen. Each cell is a screen ID or `n/a: reason`.
- **Sweep.** The `ux:sweep` table has one row for each item below, using the English key at
  the start of the first column (a translation may follow). Each decision is a screen ID or
  `n/a: reason`.

  `sign-in`, `sign-up`, `password reset`, `first run`, `account settings`,
  `account deletion`, `data export`, `invite and roles`, `billing and limits`,
  `notifications`, `email and message templates`, `search results`, `help`,
  `terms and consent`, `not found`, `server error`, `maintenance`, `session expired`

  Add rows the domain needs (for a rental product: deposit, extension, late return).

## Check 2: flows and screens connect both ways

- Every step in `ux:flow-steps` names, in its Screen column (the fifth), a screen that
  exists in `ux:screens`. `TBD` is allowed only until S3.
- Every screen in `ux:screens` is named by a flow step's Screen column, an object cell or a
  sweep row. A screen that nothing leads to is either missing a flow or not needed.
- Every step has failure branches or `none: reason` in its last column.

## Check 3: every screen has its states

Every screen in `ux:screens` has a row in `ux:states`, and no cell is empty. What to think
about for each class:

| Class | Ask |
| --- | --- |
| empty | First use with nothing yet; no results for this filter; everything cleared. Do these differ? |
| loading | First load, refresh, next page, one item updating. What stays on screen? |
| error | One field, the whole form, one section, the whole page. Is what the person typed kept? |
| permission | Read-only, hidden, or shown with who can grant access? |
| offline | Slow or no network. What still works? |
| conflict | Someone else changed or took the same thing. Who wins, and what does the loser see? |
| extreme | 0, 1, many; the longest text; translated text that grows; very large numbers. |

Model each data area's state as one value from a list (`empty | loading | ready | error`),
not as separate yes/no flags, so impossible combinations such as "loading and error" cannot
be specified.

## Evidence labels

The script counts `[user]`, `[source: URL]`, `[data: path]` and `[guess]` across the
package. It fails if there are no labels, warns when a `[source: …]` has no URL, and warns
at the top of its report when more than 70% of labels are `[guess]`; say so at the top of
the package in that case, because the reader should know how much rests on inference.

## Running the script

```sh
python3 ~/.claude/skills/z-design-ux/scripts/check_package.py docs/ux/<slug>/
```

It accepts a directory (reads every `.md` file in it) or one file, and skips fenced code
blocks, so examples of the format inside the package are not read as tables. It exits 0
when every check passes and 1 otherwise, and prints each problem with the file, line and
table. It also rejects rows whose cell count differs from the header, duplicate screen
IDs, `n/a` or `none` without a colon and reason, and reasons that are too short or only
say "not needed"; and it reports for human review when more than 40% of the state cells
are `n/a` or when one `n/a` reason is repeated in more than four cells (a copied reason is
usually a state that was skipped, not decided; reworded copies are not detected).

## Checking by hand

Where Python cannot run, go through checks 1 to 3 and the evidence rules above, row by row,
and write "checked by hand" with the date at the top of the package.
