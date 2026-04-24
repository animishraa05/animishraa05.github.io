---
concept: true
aliases: []
tags: [dev, neovim]
sources_count: 1
last_source: lsp
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Plugins and users need to react to LSP lifecycle events—attach to buffers, respond to progress, handle document changes. Neovim needs a way to signal when these events occur so users can customize behavior.

## Core Idea

LSP Events are Neovim autocmd events triggered during LSP client lifecycle: LspAttach (client initializes), LspDetach (client disconnects), LspProgress (server sends progress), LspRequest (request status changes), LspNotify (notification sent), LspTokenUpdate (semantic token changed).

## How It Works

1. **LspAttach**: Fired after client initializes and attaches to buffer; provides `client_id` in event data
2. **LspDetach**: Fired just before client detaches; clean up custom handlers here
3. **LspProgress**: Triggered on progress notifications; use for statusline updates
4. **LspRequest**: Fires on request send, completion, or cancellation; track pending work
5. **LspNotify**: Fires after each successful notification to server
6. **LspTokenUpdate**: Fires when semantic tokens change; for custom token highlighting

## Key Properties

- Use `vim.api.nvim_create_autocmd()` with event name
- Event data passed to callback contains client_id, method, params, etc.
- LspProgress pattern can be filtered by work done kind (begin/report/end)
- Dynamic registration may add capabilities after LspAttach

## Connections

- **Built from:** [[lsp-client|LSP Client]] — events relate to client lifecycle
- **Builds into:** [[vim-lsp|vim.lsp]] — vim.lsp triggers these events
- **Related:** [[lsp-semantic-tokens|Semantic Tokens]] — LspTokenUpdate for token changes

## Edge Cases & Gotchas

- Dynamic registration can happen after LspAttach; handle registerCapability event
- LspDetach is the place to remove buffer-local autocmds (like format on save)
- LspRequest with type=complete deletes pending request after handler runs
- LspTokenUpdate is experimental beyond calling highlight_token()

## Sources

- [[lsp-summary|LSP — Neovim Documentation]]
