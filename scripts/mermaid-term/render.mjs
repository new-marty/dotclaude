#!/usr/bin/env node
// mermaid のテキストを ASCII 図に変換して stdout に出す。
// Claude Code の TUI は mermaid を図にしないので、応答に貼る図はここを通す。
//
//   node render.mjs diagram.mmd
//   echo 'flowchart LR; A --> B' | node render.mjs
//
// 入力に ```mermaid フェンスがあれば、その中身だけを順に変換する。
// 変換できない図種は、元のコードをそのまま返して落ちない。

import { readFileSync } from 'node:fs'
import { renderMermaidASCII } from 'beautiful-mermaid'

const FENCE = /^[ \t]*```+[ \t]*mermaid[^\n]*\n([\s\S]*?)^[ \t]*```+[ \t]*$/gm

const src = process.argv[2]
  ? readFileSync(process.argv[2], 'utf8')
  : readFileSync(0, 'utf8')

const blocks = [...src.matchAll(FENCE)].map((m) => m[1])
const diagrams = blocks.length > 0 ? blocks : [src]

let failed = false

const rendered = diagrams.map((code) => {
  const trimmed = code.trim()
  if (!trimmed) return ''
  try {
    return renderMermaidASCII(trimmed)
  } catch (err) {
    failed = true
    process.stderr.write(`render.mjs: ${err.message}\n`)
    return trimmed
  }
})

process.stdout.write(rendered.join('\n\n') + '\n')
process.exit(failed ? 1 : 0)
