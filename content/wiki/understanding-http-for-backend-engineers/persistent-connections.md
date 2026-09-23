---
concept: Persistent Connections
aliases: [keep-alive]
tags: [networking, http]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

Why is second API call faster than first?

## Formal Definition

Per Wikipedia: "Persistent connections keep TCP/TLS open after response so next HTTP exchange skips handshake -- called keep-alive."

## Explanation

Like keeping phone line open -- second question does not need redial.

## How It Works

1. First request does TCP+TLS+HTTP
2. Server replies with Connection: keep-alive
3. Socket stays open idle
4. Second request reuses socket
5. Timeout closes after idle

## Visual Explanation

```dot
digraph persistent_connections {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="First Request"]
  B [label="Keep-Alive"]
  C [label="Reuse"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_persistent_connections {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Persistent Connections" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Saves 1-2 RTT per reuse
- Needs idle timeout
- Head-of-line blocking in HTTP/1.1
- HTTP/2 multiplexes over one

## Real-World Example

```python
Connection: keep-alive
```

## Connections

- **Built from:** [[http|HTTP]] -- persistence is HTTP feature
- **Related:** [[http-request-response-cycle|HTTP Request Response Cycle]] -- cycle benefits
- **Related:** [[http-versions|HTTP Versions]] -- HTTP/1.1 added keep-alive
- **Contrasts with:** [[statelessness|Statelessness]] -- stateless but transport reused

## Edge Cases & Gotchas

- Leaking sockets -- no close on error
- Pooling without limit -- too many open
