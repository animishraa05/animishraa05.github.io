---
concept: HTTP Request Response Cycle
aliases: []
tags: [networking, http]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

What actually happens between fetch() and response.json()?

## Formal Definition

Per Wikipedia: "The request-response cycle is the full round trip -- DNS, TCP, TLS, HTTP request, server handler, HTTP response, browser parse."

## Explanation

Like ordering food -- find restaurant address, travel there, place order, wait for kitchen, carry tray back.

## How It Works

1. Resolve host via DNS
2. Open TCP then TLS
3. Send HTTP request line+headers+body
4. Server routes and handles
5. Return status+headers+body

## Visual Explanation

```dot
digraph http_request_response_cycle {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Client"]
  B [label="Network"]
  C [label="Server"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_http_request_response_cycle {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="HTTP Request Response Cycle" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Stateless per request
- Keep-Alive reuses TCP
- 3 RTT before first byte with TLS

## Real-World Example

```python
curl -v https://api.example.com
```

## Connections

- **Built from:** [[http|HTTP]] -- cycle implements HTTP
- **Built from:** [[http-headers|HTTP Headers]] -- headers travel in cycle
- **Related:** [[http-status-codes|HTTP Status Codes]] -- status returned
- **Builds into:** [[cors|CORS]] -- CORS checked in cycle

## Edge Cases & Gotchas

- Assuming one TCP per request -- keep-alive reuses
- Forgetting preflight in cycle
