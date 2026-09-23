---
concept: LSP Completion
aliases: [autocomplete]
tags: [dev, lsp]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

How does editor show function arguments after typing dot?

## Formal Definition

Per Wikipedia: "LSP completion is textDocument/completion request where client sends prefix and server returns completion items with label, kind and insertText."

## Explanation

Completion is waiter suggesting dishes -- you typed 'use', server suggests 'useState, useEffect'.

## How It Works

1. Trigger omnifunc or autotrigger
2. Client sends completion request with prefix
3. Server scores candidates
4. Client shows popup
5. User picks via CTRL-Y

## Visual Explanation

```dot
digraph lsp_completion {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Prefix"]
  B [label="Server Rank"]
  C [label="Popup"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_lsp_completion {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="LSP Completion" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Trigger characters like . and (
- Fuzzy scoring server-side
- Snippet insert with placeholders

## Real-World Example

```python
vim.lsp.completion.enable(true, client.id, bufnr, {autotrigger=true})
```

## Connections

- **Built from:** [[lsp-server|LSP Server]] -- server provides items
- **Related:** [[lsp-client|LSP Client]] -- client requests
- **Builds into:** [[vim-lsp|Vim LSP]] -- vim shows popup
- **Contrasts with:** [[lsp-semantic-tokens|LSP Semantic Tokens]] -- completion vs highlighting

## Edge Cases & Gotchas

- Slow server -- completion lag blocks typing
- No triggerCharacters -- completion only on manual CTRL-X CTRL-O
