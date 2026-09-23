---
concept: LSP Initialization
aliases: [initialize]
tags: [dev, lsp]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

Server starts but does not know project root or capabilities -- how do they handshake?

## Formal Definition

Per Wikipedia: "Initialization is the initialize/initialized exchange where client sends rootUri and capabilities and server returns its capabilities."

## Explanation

Handshake like phone call -- client says who it is and what language it speaks, server says what help it can offer.

## How It Works

1. Client sends initialize with root and caps
2. Server responds with serverCapabilities
3. Client sends initialized notification
4. Server starts workspace indexing
5. Features become available

## Visual Explanation

```dot
digraph lsp_initialization {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Client"]
  B [label="Initialize"]
  C [label="Server Ready"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_lsp_initialization {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="LSP Initialization" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Root from root_markers
- Capabilities negotiation prevents unsupported calls
- Once per attachment

## Real-World Example

```python
vim.lsp.enable('lua_ls') # triggers initialize
```

## Connections

- **Built from:** [[lsp-configuration|LSP Configuration]] -- config feeds init
- **Built from:** [[lsp-root-markers|LSP Root Markers]] -- root sent in init
- **Builds into:** [[lsp-diagnostics|LSP Diagnostics]] -- diagnostics after init
- **Related:** [[lsp-server|LSP Server]] -- server initializes

## Edge Cases & Gotchas

- Init before root detected -- server indexes wrong dir
- Advertising caps server lacks -- client calls missing method
