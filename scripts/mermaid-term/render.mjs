#!/usr/bin/env node
// Convert mermaid text into an ASCII diagram on stdout.
// Claude Code's TUI does not render mermaid, so any diagram pasted into a reply goes
// through here.
//
//   node render.mjs diagram.mmd
//   echo 'flowchart LR; A --> B' | node render.mjs
//
// When the input contains ```mermaid fences, only their contents are converted, in order.
// A diagram type it cannot convert is returned as the original code rather than crashing.

import { readFileSync } from 'node:fs'
import { renderMermaidASCII } from 'beautiful-mermaid'
import stringWidth from 'string-width'

const FENCE = /^[ \t]*```+[ \t]*mermaid[^\n]*\n([\s\S]*?)^[ \t]*```+[ \t]*$/gm
const ZERO_WIDTH = '​'

// beautiful-mermaid sizes a box by character count, so a label made of full-width
// characters overflows it. The two-character label 検証 occupies four columns in a
// terminal. Pad the label with as many zero-width characters as the shortfall, split
// across both sides, and the library counts the right number of columns. The padding is
// invisible in a terminal, so box and contents both line up.
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
