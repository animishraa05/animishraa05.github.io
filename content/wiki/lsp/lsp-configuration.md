---
concept: true
aliases: []
tags: [dev, neovim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Different language servers need different startup commands, file type associations, and workspace detection rules. Users and plugins need a unified way to define and share LSP configurations without code duplication.

## Core Idea

LSP Configuration in Neovim uses `vim.lsp.config()` to define server settings, with a merge chain that allows global defaults, plugin configs, and user overrides to coexist.

## How It Works

1. **Definition**: `vim.lsp.config('server-name', {cmd = {...}, filetypes = {...}, root_markers = {...}})`
2. **Enable**: `vim.lsp.enable('server-name')` activates auto-attachment for matching buffers
3. **Merge Priority** (lowest to highest):
   - Global config (`vim.lsp.config('*', {...})`)
   - `lsp/<name>.lua` files in runtimepath
   - `after/lsp/<name>.lua` files
   - Direct config calls in init.lua
4. **Config sources**: Can also use `lsp/<name>.lua` files in runtimepath

## Key Properties

- Wildcard `*` config applies to all servers
- root_markers can be nested for equal-priority markers: `{{'a', 'b'}, 'c'}`
- Config merging uses `vim.tbl_deep_extend` with "force" behavior
- Config files in runtimepath may be eagerly evaluated (performance note)
- "after/" directory follows standard Vim after-directory semantics

## Connections

- **Built from:** [[vim-lsp|vim.lsp]] — the framework providing config()
- **Builds into:** [[lsp-client|LSP Client]] — configs become client instances via enable/start
- **Related:** [[lsp-root-markers|Root Markers]] — part of config that determines workspace
- **Related:** [[lsp-events|LSP Events]] — lifecycle events triggered for configured clients

## Edge Cases & Gotchas

- Using `vim.lsp.config['name']` has side-effect of resolving config
- Prefer `vim.lsp.is_enabled()` to check status without resolving
- Place configs in `after/lsp/` to override plugin defaults