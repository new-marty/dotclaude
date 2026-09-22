# The briefing page

The briefing is published as an Artifact and the terminal carries only the opening lines and
the link. `assets/briefing-example.html` is a real briefing, complete, and it is both the
design spec and the starting point: copy it, replace the content, keep the CSS and the class
names untouched. Rebuilding the look every morning wastes the run and gives the reader a
page that moves under them — the same information has to sit in the same place every day.

## One page, always the same link

The page is a standing one, updated in place. `~/.claude/cache/z-catch-up/artifact.json`
holds `{"url": "..."}` from the first publish.

- The file exists → pass that `url` to the Artifact tool, so the reader keeps one bookmark.
- It does not → publish without `url`, then write the returned URL into that file.
- The user asks to keep today's page → publish a new one and leave the file alone.

## What goes where

| Part | Holds |
| --- | --- |
| `header` | title, the date, days since the last run, the repositories covered |
| `.lede` ×2 | what all the work is for, and where it stands as a whole. Written to survive alone |
| `.counts` | あなたの番 / チーム待ち / 手つかず / 盤面のずれ / 未読通知. `.hot` on the first |
| `section.stream` | one stream: heading, `.progress` chip with the epic and its count, `.why` paragraph, then the items |
| `.item` | `.id` the number, `.what` the work in plain words, `.state` the pull request and its state. `.mine` or `.team` on the row |
| `.drift` | only when the board disagrees with reality. Leave the whole block out when it does not |
| `.tail` | the parked count with the plan's reason, and what moved while they were away |

`.mine` rows carry the `.turn.mine` badge inside `.what`. Nothing else is coloured: the one
signal on the page is whose move it is, and adding a second one destroys the first.

## Rules the page inherits

Everything in `SKILL.md` about the writing still holds — the work described in plain words,
the number never the subject, no hand-wrapped prose. The page adds one of its own: an item
is one row, however long the sentence. Rows of unequal height are fine; truncation is not.

Read `artifact-design` before changing the design, not before filling it in.
