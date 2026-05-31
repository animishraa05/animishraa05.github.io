---
source: Lsp.md
source_path: sources/Lsp.md
content_hash: lsp-neovim-doc-2026
ingested: 2026-04-12
concepts_count: 7
tags: [dev, lsp]
---

## What concepts were extracted

1. **Language Server Protocol** — The standard protocol enabling editor-server communication for code intelligence
2. **vim.lsp** — Neovim's built-in Lua framework for LSP client management
3. **LSP Configuration** — How to define and merge LSP server configs in Neovim
4. **LSP Client** — The runtime LSP client object with capabilities, attached buffers, and request tracking
5. **Root Markers** — Files/directories used to identify project workspace boundaries
6. **LSP Events** — Autocmd events for LSP lifecycle (LspAttach, LspDetach, LspProgress, etc.)
7. **Semantic Tokens** — LSP server-provided code highlighting based on semantic meaning

## Wiki pages created

- [[language-server-protocol|Language Server Protocol]]
- [[vim-lsp|vim.lsp — Neovim LSP Framework]]
- [[lsp-configuration|LSP Configuration in Neovim]]
- [[lsp-client|LSP Client]]
- [[lsp-root-markers|Root Markers]]
- [[lsp-events|LSP Events]]
- [[lsp-semantic-tokens|Semantic Tokens]]

## Key takeaways

- Neovim has a built-in LSP client that requires no plugins for basic functionality
- Config uses a merge chain: global (\*) → runtimepath → after/ (highest priority)
- Root markers determine workspace; multiple can be specified with equal priority via nesting
- Key features enabled by default: diagnostics, document highlight, K→hover, omnifunc
- Semantic tokens provide additional highlighting beyond Treesitter syntax parsing

## Open questions

- How does LSP compare to Treesitter in terms of use cases and performance?
- What are the security implications of running language servers as subprocesses?

## Connections

- [[language-server-protocol|Language Server Protocol]] — protocol overview
- [[vim-lsp|vim.lsp]] — Neovim LSP framework
- [[lsp-configuration|LSP Configuration]] — config merge chain
- [[lsp-client|LSP Client]] — runtime client object
- [[lsp-root-markers|Root Markers]] — workspace detection
- [[lsp-events|LSP Events]] — lifecycle events
- [[lsp-semantic-tokens|Semantic Tokens]] — semantic highlighting
- [[vim-modes|Vim Modes]] — Vim fundamentals this builds on
