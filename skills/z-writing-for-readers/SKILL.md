---
name: z-writing-for-readers
description: The norm for writing anything a reader outside this session will see (documentation, README, design document, PR description, commit message, issue, review comment) as a standalone deliverable rather than a continuation of the conversation. Language-independent; names the pass to run on the draft for its language (`z-humanizer` for English, `z-natural-japanese` and `z-japanese-proofreading` for Japanese). Not for short chat replies, code, or logs.
---

# Write for the reader

The reader knows none of it: not this conversation, not the instructions you were given,
not what your research turned up, not the files you opened. Write the text as a standalone
deliverable, not as a continuation of the session.

## Rules

1. Write it as the final form.
   Your false starts, your earlier mistakes and their corrections, the path your research
   took, the instructions given mid-conversation — none of these exist for the reader.
   Structure the text as if you had planned and researched it this way from the start.
   References that depend on that history — "we will avoid doing X", "as decided above" —
   get rewritten into sentences that carry their own background, or deleted.

2. Do not repeat the instructions back.
   Directions like "write this for xxx" or "use this format" shape how you write; they are
   not declared inside the deliverable. Show only the result.

3. Give each conclusion enough context for the reader to check it.
   Explain proper nouns, in-house terms, and file names on first use, along with the
   reasoning behind a judgment. The body alone should let the reader follow what the claim
   rests on.

4. Decide on one point before you write.
   Do not say everything you could say. Narrow it to the one thing the reader should come
   away with, and put only the background needed to understand that up front.
   Do not present things in the order you researched or thought about them. Rearrange them
   into the order the reader will read them.

5. Name the section in the heading, and put the informative words first.
   "How tags are assigned", not "Overview" or "Details". Style guides agree on this much
   (Google and Microsoft ask for descriptive headings; GOV.UK and Microsoft ask for the
   important words first). A heading that states the section's conclusion is stronger but
   reads as machine-made when every heading does it; use it for the two or three sections
   whose content a reader could not guess from a name, and keep the rest as names, in one
   grammatical shape.

6. Bullets are for items that are genuinely parallel; reasoning is prose.
   A cause and its effect, or a decision and why, go in sentences joined by "so", "but",
   "because". Steps go in a numbered list. Items in one list share one grammatical shape.
   Google's course notes that engineers like lists; digital.gov and NN/g warn that a page
   of bullets is as hard to read as a wall of text. Both are right, so the test is whether
   the items stand alone without a relation between them.

7. Bold is for the one thing the reader must not miss, at most once a section.
   Google, Microsoft and GOV.UK reserve bold for UI elements and forbid it for emphasis;
   GitHub's docs allow it sparingly. Bold labels on every list item are decoration. A
   template's field labels are structure, not emphasis, and do not count.

## The language pass

After the draft, run the pass for its language, then the check below. English:
`z-humanizer`. Japanese: `z-natural-japanese` (the constitution before writing, its
`lint.py` on the draft) and then `z-japanese-proofreading`. Neither pass applies to the
other language.

## The check

When you have finished, ask of each sentence: "with the log of this session gone, can the
intended reader understand this sentence? Is the information needed to understand it
present in the body?"
Rewrite or delete every sentence whose answer is no.
