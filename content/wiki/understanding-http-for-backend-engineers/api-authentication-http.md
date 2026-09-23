---
concept: API Authentication over HTTP
aliases: [auth]
tags: [security, http]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

How does server know request is from logged-in user without storing session on server?

## Formal Definition

Per Wikipedia: "API authentication over HTTP often uses token in Authorization header -- Bearer JWT or session cookie -- verified per request."

## Explanation

Like wristband at festival -- gate checks band each entry, does not remember your face.

## How It Works

1. Client logs in, gets token
2. Client sends Authorization: Bearer <jwt> each request
3. Server verifies signature/expiry
4. Server loads principal
5. Returns 401 if invalid

## Visual Explanation

```dot
digraph api_authentication_http {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Login"]
  B [label="Bearer Token"]
  C [label="Verify"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_api_authentication_http {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="API Authentication over HTTP" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Stateless -- token carries claims
- Short expiry plus refresh
- Bearer must be over HTTPS
- Revocation needs denylist

## Real-World Example

```python
Authorization: Bearer eyJ...
```

## Connections

- **Built from:** [[http-headers|HTTP Headers]] -- auth travels in header
- **Related:** [[http-status-codes|HTTP Status Codes]] -- 401/403
- **Related:** [[statelessness|Statelessness]] -- stateless auth fits
- **Builds into:** [[cors|CORS]] -- creds needs CORS allow

## Edge Cases & Gotchas

- Storing JWT in localStorage XSS risk
- Long-lived token without refresh
