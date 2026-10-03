# Sources for z-writing-for-readers

Each rule in `SKILL.md` and what it rests on. Quoted or closely paraphrased material keeps
its licence; everything else is written from scratch.

| Rule | Source | Licence |
| --- | --- | --- |
| Decide who the reader is and give what they lack | Google Technical Writing, [Audience](https://developers.google.com/tech-writing/one/audience) | not stated on the page |
| A correct document that is not understood is as good as absent; keep what the reader needs, link the rest | 文化審議会「[公用文作成の考え方](https://www.bunka.go.jp/seisaku/bunkashingikai/kokugo/hokoku/pdf/93651301_01.pdf)」(2022): secondary information goes to another page; trying to be exact makes writers cram everything in | Japanese government terms of use |
| Details may live elsewhere behind a link; do not repeat facts across pages | GitLab documentation [style guide](https://docs.gitlab.com/development/documentation/styleguide/) (single source of truth, link instead of restating, keep links per page limited) | not stated on the page |
| Explain acronyms on first use, keep terms fixed, do not introduce a name used once, not in headings | [Microsoft Writing Style Guide](https://learn.microsoft.com/en-us/style-guide/acronyms); Google developer documentation [style guide](https://developers.google.com/style) | CC BY 4.0 (both) |
| Conclusion and reason first | NN/g, [How users read on the web](https://www.nngroup.com/articles/how-users-read-on-the-web/) (79% scan; inverted pyramid) | cited only |
| Title says the subject; open with assumed knowledge and what is left out | Google Technical Writing, [Large documents](https://developers.google.com/tech-writing/two/large-docs) (state what the document covers, what prior knowledge it expects, what it does not cover) | not stated on the page |
| Descriptive link text, never a bare number | Google style guide, [Link text](https://developers.google.com/style/link-text) | CC BY 4.0 |
| Record numbers by kind of document | No style guide addresses internal identifiers. This is the repository owner's rule (2026-10-03), set after a test in which rewriting a decision log without its numbers dropped a related line and broke references | — |
| Abstract only what the purpose does not need; never procedures, safety information or numbers | 公用文作成の考え方 (above); [digital.gov plain language](https://digital.gov/guides/plain-language) | US government site |
| One purpose per document | [Diátaxis](https://diataxis.fr/) (tutorial, how-to, reference, explanation); JIS Z 82079-1 (IEC/IEEE 82079-1) (concept, instruction, reference information) | Diátaxis: CC BY-SA 4.0, cited and paraphrased, not copied |
| Text for agents keeps identifiers; reasons with rules; only what the model lacks | Anthropic, [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) (lightweight identifiers fetched just in time); [Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices); [Prompting best practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices) | cited only |
| One fact in one place; conflicting instructions; size limits; hooks for what must happen | Claude Code docs, [memory](https://code.claude.com/docs/en/memory) | cited only |
| README for people, AGENTS.md for agents | [AGENTS.md](https://agents.md/) | cited only |
| Readability scores are not comprehension; test with a reader | NN/g (above); digital.gov plain language ("write, design, test"); the reader-testing step in Anthropic's [doc-coauthoring](https://github.com/anthropics/skills/tree/main/skills/doc-coauthoring) skill (a fresh Claude with no conversation context reads the document) | idea only, no text copied |

The rule that an identifier in agent-facing text gets a few words for the person
maintaining it is an inference from the context-engineering post, not something a source
states.
