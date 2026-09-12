---
name: z-show-me
description: Help the user understand the current topic visually with concise diagrams, code-shape sketches, and focused HTML artifacts. 日本語でも同じく使う - 「図で見せて」「構造を見せて」「どこがどう変わるのか図にして」など。
---

<!-- Vendored from https://github.com/humanlayer/skills/blob/main/plugins/show-me/skills/show-me/SKILL.md
     (MIT License, Copyright (c) 2026 HumanLayer). The body is upstream's except
     for the final bullet on HTML output, which is rewritten for this
     environment, and the "この環境での出し方" section, which is a local
     addition. The `name` field is renamed to `z-show-me`. -->

Help the user understand the current topic of conversation visually. Skip the preamble and keep prose brief. Pick the smallest view that makes the key point clear.

- Show logic or an algorithm as pseudocode:

```text
on(save)
  if content is unchanged
    return cached result
  write new content
  return fresh result
```

- Show runtime control flow as a call tree:

```text
submitForm
  createSession
    persistPrompt
    launchAgent
  navigateToSession
```

- Show UI structure as a component tree, including state and module boundaries that matter:

```tsx
<SessionPage> (apps/example/src/routes/session.tsx)
  useSessionEvents()
  <SessionToolbar>
    <RunSkillButton> (packages/ui)
```

- Show file responsibility or a broad refactor as a shallow file tree:

```text
src/
├── commands/       # parses user actions
├── sessions/       # owns session state
└── transport/      # sends API requests
```

- Show component interaction, control flow, or data flow with Mermaid:

```mermaid
sequenceDiagram
    participant User
    participant UI
    participant Daemon
    User->>UI: choose command
    UI->>Daemon: send expanded prompt
    Daemon-->>UI: stream result
```

- Use `diff` when the point is what changes and the surrounding shape already exists. Match the diff shape to the topic.

For a component change:

```diff
 <SessionPage>
   useSessionEvents()
   <SessionToolbar>
+    <RunSkillButton />
   <SessionTimeline>
+    <SkillResultCard />
```

For a file-layout change:

```diff
 src/
 ├── commands/
+│   └── show-me.ts       # expands the slash command
 ├── sessions/
-└── transport.ts
+└── transport/
+    ├── client.ts
+    └── stream.ts
```

For a call-tree or call-stack change:

```diff
 submitForm
   createSession
     persistPrompt
+    expandSkillMention
     launchAgent
-  navigateToSession
+  navigateToSession
+    subscribeToEvents
```

For a state or control-flow change:

```diff
 on(save)
-  write content
+  if content is unchanged
+    return cached result
+  write new content
+  invalidate cache
```

- Show the whole block when most of it is new, when omitted context would hide ownership or order, or when the user needs a copyable target shape:

```ts
function expandSkill(command: string): string {
  const skillName = command.slice(1)
  return `use the ${skillName} skill`
}
```

- For a visual UI, layout, state comparison, or concept too dense for Mermaid, write one focused HTML file — a diagram, an infographic, or a short slide deck, whichever fits the point. Match the product's colors, type, spacing, and components; use real labels and data; support desktop and mobile. Then hand it to the user (see below).

### この環境での出し方

HTML を書いたら、`open` コマンドで開かない。次のどちらかで渡す。

- **Artifact ツール** — 共有できる URL になる。読者が複数いる図、あとで見返す資料、
  リンクを渡したいものはこれ。先に `artifact-design` スキルを読む。図を含むなら
  `artifact-diagramming` も読む。
- **SendUserFile ツール** — その場で見せて終わりの図。`display: "render"` を指定する。

擬似コード・呼び出し木・ファイル木・mermaid・diff は、HTML にせず応答本文に直接書く。
mermaid は Artifact でもそのまま描画される。

### guidance

Place each visual next to the short text it supports. Keep only the calls, files, props, states, and boundaries needed to answer the user's current question or the options to resolve the current discussion point.

You may use one of these, you may use several, it is unlikely you will use all of them. Use your judgement and don't overwhelm the user.
