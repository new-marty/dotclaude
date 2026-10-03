---
name: z-writing-for-readers
description: The norm for writing anything a reader outside this session will see (documentation, README, design document, PR description, commit message, issue, review comment) as a standalone deliverable rather than a continuation of the conversation. Language-independent; names the pass to run on the draft for its language (`z-humanizer` for English, `z-natural-japanese` and `z-japanese-proofreading` for Japanese). Not for short chat replies, code, or logs.
---

# Write for the reader

The reader was not in this session: not this conversation, not the instructions you were
given, not what your research turned up, not the files you opened. They may still know the
field well. Decide who the reader is, work out what they lack for their purpose, and give
them that. Write the text as a standalone deliverable, not as a continuation of the session.

A document that is correct but not read or not understood is as good as absent. When
completeness and readability pull apart, keep what the reader needs in the body and move
the rest to where it belongs, with a link.

These rules are for text people read. Text an agent reads and acts on (CLAUDE.md,
AGENTS.md, SKILL.md, memory, prompts) differs in a few places; see "Text for agents".

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
   rests on. The evidence and the details behind it may live in another document, as long
   as a link takes the reader there.
   Explain an acronym or term on first use and keep the same word afterwards; a reader takes
   a changed word for a changed meaning. Do not introduce a name that appears only once.

4. Decide on one point before you write.
   Do not say everything you could say. Narrow it to the one thing the reader should come
   away with, and put only the background needed to understand that up front.
   Do not present things in the order you researched or thought about them. Rearrange them
   into the order the reader will read them: the conclusion and the reason for it first,
   then how it works, then the details.

5. Let the title say what the document covers; open with what the title cannot say.
   A title the reader can read as "about X" tells them the subject. If the reader needs to
   know what you assume they already know, or what the document leaves out, say so in one
   or two sentences at the top; if neither applies, start with the content. Do not restate
   the title ("This document is a record of..."). Saying what is left out also tells the
   reader that a missing detail was left out on purpose.

6. Name the section in the heading, and put the informative words first.
   "How tags are assigned", not "Overview" or "Details". Style guides agree on this much
   (Google and Microsoft ask for descriptive headings; GOV.UK and Microsoft ask for the
   important words first). A heading that states the section's conclusion is stronger but
   reads as machine-made when every heading does it; use it for the two or three sections
   whose content a reader could not guess from a name, and keep the rest as names, in one
   grammatical shape.

7. Bullets are for items that are genuinely parallel; reasoning is prose.
   A cause and its effect, or a decision and why, go in sentences joined by "so", "but",
   "because". Steps go in a numbered list. Items in one list share one grammatical shape.
   Google's course notes that engineers like lists; digital.gov and NN/g warn that a page
   of bullets is as hard to read as a wall of text. Both are right, so the test is whether
   the items stand alone without a relation between them.

8. Bold is for the one thing the reader must not miss, at most once a section.
   Google, Microsoft and GOV.UK reserve bold for UI elements and forbid it for emphasis;
   GitHub's docs allow it sparingly. Bold labels on every list item are decoration. A
   template's field labels are structure, not emphasis, and do not count.

9. Write record numbers according to the kind of document.
   Internal identifiers (task, decision, issue and PR numbers) mean nothing to a reader who
   has not seen the tracker. In an explanation (README, guide, design note, research memo),
   say in words what the record is and make those words the link: "[the decision to repair
   unattended](...)". Never use a bare number as the link text. In a record or a procedure
   that other documents cite by number (a decision log, a runbook, a changelog), keep the
   number and add a few words the first time: "#35 (the decision to split machine-specific
   rules)". Dropping the number there breaks every reference to it. Machine-read trailers
   such as `Closes #12`, and public identifiers the reader would look up (an RFC, a CVE, an
   error code), stay as they are.

10. Abstract only what the reader's purpose does not need.
    You may state a detail more generally when the reader does not need it to act or to
    understand, and the meaning and scope stay the same. The test: would someone who knows
    the details call the sentence wrong? Then it is not an abstraction, it is an error.
    Procedures, safety information and numbers are never abstracted; keep them exact in the
    document made for them and link to it.

11. Give each document one purpose.
    Explanation (why), instructions (do this) and reference (look this up) go in separate
    documents. An explanation padded with steps or full lists is hard to read as either;
    link to the steps instead.

## Text for agents

An agent reading CLAUDE.md, AGENTS.md, a SKILL.md, a memory file or a prompt uses
identifiers as keys: it greps for a task number, opens a path, runs a command. So in text
for agents:

- Write exact commands, paths, identifiers and error strings as they are. A paraphrase
  gives the agent nothing to look up. Add a few words to an identifier so a person
  maintaining the file can read it: "T-297 (unattended repair)".
- Give each rule its reason in a clause. A model generalises from the reason to cases the
  rule does not name.
- Write only what the model lacks. Leave out what it already knows and what it can read
  from the code.
- State each fact once, in one place. Leave history, dates and changelogs to git. Delete
  stale or contradicting lines: given two conflicting instructions, a model picks one.
- Keep terms fixed, and keep always-loaded files short (CLAUDE.md under about 200 lines,
  SKILL.md under 500); move detail one level down.
- What must always happen belongs in a hook or a check, not in a sentence.

When one file serves both, write the explanation for people and put the agent detail where
agents look (README for people, AGENTS.md for agents).

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

Readability scores measure sentences, not understanding. For a document that matters, have
a reader with no session context read it (a fresh subagent given only the document, or the
person) and list every term they could not follow and every jump they could not make. Fix
those. A model reader is a cheap first check, not a verdict; the person makes the final
call.

Sources for these rules, with licences, are in `references/sources.md`.
