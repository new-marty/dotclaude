---
name: z-wait-what
description: "いまの説明が伝わらなかったときに、抜けていた前提を足して言い直させる。説明を読んで話の筋が追えなかったとき、ユーザーが打って使う。"
disable-model-invocation: true
---

<!-- Adapted from https://github.com/mattpocock/skills/blob/main/skills/productivity/wait-what/SKILL.md
     (MIT License, Copyright (c) 2026 Matt Pocock). This file is a Japanese
     rewrite of upstream's single instruction, with the `z-japanese-proofreading`
     clause added locally. In the frontmatter, `name` is renamed to
     `z-wait-what`, `description` is rewritten in Japanese, and
     `disable-model-invocation: true` is added. -->

待って、話がどこへ向かっているのか分からなくなった。いまの説明を言い直してほしい。抜けていた前提を先に足し、その場で開いていない用語は開き、`CONTEXT.md`（複数あるなら `CONTEXT-MAP.md` が指すもの）の言葉を使う。日本語で書くなら `z-japanese-proofreading` の規範に沿った平易な日本語で、英語で書くなら ASD-STE100 Simplified Technical English で。
