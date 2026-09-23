---
concept: true
aliases: []
tags: [dev, neovim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Syntax highlighting shows code structure (keywords, strings, comments) but not semantic meaning (is this a function? a class? deprecated?). Treesitter provides syntax-level highlighting, but LSP servers have additional semantic knowledge about the code that can enhance the editing experience.

## Core Idea

Semantic Tokens are LSP protocol extensions that let servers provide additional highlighting based on semantic meaning--identifying functions, variables, classes, parameters, and their modifiers (readonly, async, deprecated, etc.). This works alongside Treesitter, not replacing it.

## How It Works

1. Server advertises `textDocument/semanticTokens` capability during initialization
2. Server sends tokens as ranges with type (function, variable, class) and modifiers (readonly, async)
3. Neovim applies highlight groups: `@lsp.type.<type>.<filetype>`, `@lsp.mod.<mod>.<filetype>`
4. Can combine type+modifiers: `@lsp.typemod.<type>.<mod>.<filetype>`
5. LspTokenUpdate event fires when tokens change (for custom highlighting)

## Key Properties

- Adds to Treesitter highlighting, doesn't replace it
- Standard types: class, function, method, variable, parameter, etc.
- Standard modifiers: readonly, async, deprecated, static, abstract
- Highlight groups can be customized via `hi` or `nvim_set_hl`
- Priority: @lsp.type._ = semantic_tokens, @lsp.mod._ +1, @lsp.typemod.\* +2



## Visual Explanation

```dot
digraph true {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="True\nInput"]
  B [label="True\nCore Mechanism"]
  C [label="True\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_true {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="True" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- **Related:** [[treesitter|Treesitter]] -- provides syntax-level highlighting
- **Builds into:** [[lsp-events|LSP Events]] -- LspTokenUpdate for token changes
- **Related:** [[vim-lsp|vim.lsp]] -- handles semantic token integration

## Edge Cases & Gotchas

- Semantic highlights are additive to Treesitter--not a replacement
- Servers may use non-standard types/modifiers beyond the specification
- Disable by clearing highlight groups in ColorScheme autocmd
- LspTokenUpdate only supports highlight_token() call; other uses experimental