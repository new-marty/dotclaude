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
import stringWidth from 'string-width'

const FENCE = /^[ \t]*```+[ \t]*mermaid[^\n]*\n([\s\S]*?)^[ \t]*```+[ \t]*$/gm
const ZERO_WIDTH = '​'

// beautiful-mermaid は枠の幅を文字数で決めるため、全角文字のラベルは枠からはみ出す。
// 「検証」は 2 文字だが端末では 4 桁を占める。そこで、はみ出す桁数と同じ数だけ
// 表示幅 0 の文字をラベルの前後に足し、ライブラリに正しい桁数を数えさせる。
// 端末では足した文字が見えないので、枠と中身の両方が揃う。
function padWideChars(code) {
  return code.replace(/[^\x00-\x7F]+/gu, (run) => {
    const shortfall = stringWidth(run) - [...run].length
    if (shortfall <= 0) return run
    const left = Math.floor(shortfall / 2)
    return ZERO_WIDTH.repeat(left) + run + ZERO_WIDTH.repeat(shortfall - left)
  })
}

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
    return renderMermaidASCII(padWideChars(trimmed))
  } catch (err) {
    failed = true
    process.stderr.write(`render.mjs: ${err.message}\n`)
    return trimmed
  }
})

process.stdout.write(rendered.join('\n\n') + '\n')
process.exit(failed ? 1 : 0)
