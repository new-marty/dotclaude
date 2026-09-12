---
name: z-eli5
description: Explain a topic like I'm a 5 year old. Use when the user types /eli5 <topic> or asks for a dead-simple picture explainer of how something works. 日本語でも同じく使う - 「小学生でもわかるように説明して」「絵で説明して」「そもそも何なのか一から教えて」など。
---

<!-- Vendored from https://github.com/anthropics/claude-plugins-community/blob/main/eli5/skills/eli5/SKILL.md
     (Apache-2.0). The body is upstream's except for the clause on writing the
     artifact in the user's language, which is a local addition. The `name`
     field is renamed to `z-eli5` and Japanese trigger phrases are appended to
     `description`. -->

# eli5

Explain like I'm someone who knows nothing about this topic, using a HTML artifact with big pictures and few words. Write the artifact in the language the user is writing in.

Topic: $ARGUMENTS
