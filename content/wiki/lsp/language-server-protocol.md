---
concept: true
aliases: []
tags: [dev, neovim]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Code editors need to provide intelligent features like go-to-definition, refactoring, and completion. Before LSP, each language required custom integration with every editor--a massive N×M problem. LSP standardizes communication between tools and language analyzers.

## Core Idea

The Language Server Protocol (LSP) is a protocol that defines communication between a code editor (client) and a language analysis tool (server). LSP standardizes features like autocomplete, go-to-definition, find references, hover information, rename, and formatting across all languages.

## How It Works

1. **Client-Server Architecture**: The editor acts as an LSP client; the language analyzer runs as a separate process (language server)
2. **JSON-RPC Communication**: Messages are sent over stdin/stdout using JSON-RPC 2.0
3. **Standardized Methods**: Features are exposed via methods like `textDocument/definition`, `textDocument/completion`, `textDocument/rename`
4. **Initialization**: Client and server exchange capabilities during initialization
5. **Document Synchronization**: Server receives notifications when files change via `textDocument/didOpen`, `textDocument/didChange`, etc.

## Key Properties

- Language-agnostic protocol (works with any programming language)
- Server provides semantic, project-level analysis (unlike ctags)
- Bidirectional: client sends requests, server sends notifications and responses
- Capabilities negotiation: servers declare supported features
- Standardized request/response format



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

- **Built from:** JSON-RPC 2.0 -- underlying wire protocol
- **Builds into:** Neovim's vim.lsp -- specific client implementation
- **Related:** Treesitter -- alternative code understanding (syntax parsing vs LSP semantic analysis)
- **Related:** Ctags -- traditional navigation approach

## Edge Cases & Gotchas

- Servers are third-party; each language requires separate installation
- Not all servers implement all features--check capabilities
- Large projects may have performance issues with file watching
- Dynamic registration allows servers to add capabilities after initialization