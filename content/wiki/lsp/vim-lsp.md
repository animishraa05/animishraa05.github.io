---
concept: true
aliases: [vim.lsp]
tags: [dev, neovim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Neovim needs a built-in way to connect to LSP servers without requiring external plugins. The built-in LSP client should handle the complexity of starting servers, managing clients, and exposing a Lua API for interacting with language servers.

## Core Idea

`vim.lsp` is Neovim's built-in Lua framework for creating LSP clients and building LSP-powered tools. It provides functions to start/configure language servers, handle LSP methods, and implement editor features using semantic analysis.

## How It Works

1. **Configuration**: Use `vim.lsp.config()` to define server configurations (cmd, filetypes, root_markers)
2. **Activation**: Use `vim.lsp.enable()` to auto-start LSP for matching buffers
3. **Client Management**: `vim.lsp.start()` creates a client; `vim.lsp.get_clients()` retrieves active clients
4. **Buffer Operations**: `vim.lsp.buf.*` functions operate on the current buffer (definition, references, hover)
5. **Handler System**: Custom handlers can intercept/override LSP responses at multiple levels

## Key Properties

- Built-in (no plugin required for basic LSP)
- Lua-native API (`vim.lsp.buf`, `vim.lsp.client`)
- Config merging from multiple sources (global, runtimepath, after/)
- Built-in keymaps and buffer-local options for common features
- Event-driven: LspAttach, LspDetach, LspProgress, etc.

## Connections

- **Built from:** [[language-server-protocol|LSP]] — the protocol it implements
- **Builds into:** [[lsp-configuration|LSP Configuration]], [[lsp-client|LSP Client]], [[lsp-events|LSP Events]], [[lsp-semantic-tokens|Semantic Tokens]]
- **Related:** [[lsp-root-markers|Root Markers]] — workspace detection
- **Contrasts with:** Treesitter — syntax parsing vs semantic analysis

## Edge Cases & Gotchas

- Config files in runtimepath are eagerly evaluated
- Global keymaps are created unconditionally on startup
- Default buffer-local settings (omnifunc, tagfunc, formatexpr) can conflict with other plugins
- Large workspaces: file watching can cause performance issues on Linux