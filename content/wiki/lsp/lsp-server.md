---
concept: LSP Server
aliases: [language server]
tags: [dev, lsp]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

Editor knows syntax but not project types -- what provides hover, go-to-definition across files?

## Formal Definition

Per Wikipedia: "An LSP server is a process that implements Language Server Protocol to analyze workspace files and answer editor requests."

## Explanation

Server is the librarian -- editor asks where is definition of User, server knows every shelf in the project.

## How It Works

1. Client starts server via cmd
2. Client sends initialize with root
3. Server indexes workspace files
4. Client sends textDocument/hover etc
5. Server replies with location/markers

## Visual Explanation

```dot
digraph lsp_server {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Editor"]
  B [label="LSP Server"]
  C [label="Workspace"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_lsp_server {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="LSP Server" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Language-specific per project
- Runs out-of-process
- Communicates via JSON-RPC
- Advertises capabilities on init

## Real-World Example

```python
vim.lsp.config['clangd'] = {cmd={'clangd'}}
```

## Connections

- **Built from:** [[language-server-protocol|Language Server Protocol]] -- server speaks protocol
- **Related:** [[lsp-client|LSP Client]] -- client talks to server
- **Builds into:** [[lsp-semantic-tokens|LSP Semantic Tokens]] -- server provides tokens
- **Related:** [[lsp-configuration|LSP Configuration]] -- configures server

## Edge Cases & Gotchas

- Starting heavy server on huge monorepo slows init
- Mismatched filetypes -- server not attached
