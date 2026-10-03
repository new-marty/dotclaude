---
name: z-eli5
description: >-
  Explain an unfamiliar topic from zero as a standalone HTML artifact with big pictures and few words. Use when the user types /z-eli5 <topic>, or asks to be taught something they know nothing about. Also triggers on Japanese: 「小学生でもわかるように説明して」「そもそも何なのか一から教えて」など。To show the structure or the changes of whatever is being discussed as a diagram, use z-show-me instead.
argument-hint: "<topic you want explained>"
---

<!-- Vendored from https://github.com/anthropics/claude-plugins-community/blob/main/eli5/skills/eli5/SKILL.md,
     by Thariq Shihipar (plugin.json: MIT; repository: Apache-2.0). The body is
     upstream's except for the clause on writing the artifact in the user's
     language and passing the text through the language pass named in
     `z-writing-for-readers`, which are local additions. The `name`
     field is renamed to `z-eli5` and Japanese trigger phrases are appended to
     `description`. -->

# eli5

Explain like I'm someone who knows nothing about this topic, using a HTML artifact with big pictures and few words. Write the artifact in the language the user is writing in. Before it is published, the text goes through the language pass in `z-writing-for-readers`: `z-humanizer` for English, `z-natural-japanese` (the constitution before writing, `lint.py` on the draft) and then `z-japanese-proofreading` for Japanese.

Topic: $ARGUMENTS
