---
concept: HTTPS and TLS
aliases: [TLS]
tags: [security, http]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

How does HTTP become tamper-proof on public WiFi?

## Formal Definition

Per Wikipedia: "HTTPS is HTTP over TLS -- handshake negotiates cipher, verifies cert, then encrypts headers and body."

## Explanation

Like sending letter in locked box -- only server has key, postman cannot read.

## How It Works

1. ClientHello with ciphers
2. Server replies cert + ServerHello
3. Client verifies CA chain
4. Key exchange derives session key
5. HTTP encrypted inside TLS record

## Visual Explanation

```dot
digraph https_tls {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="ClientHello"]
  B [label="Certificate"]
  C [label="Encrypted HTTP"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_https_tls {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="HTTPS and TLS" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Cert binds domain to key
- TLS terminates at load balancer often
- Mixed http/https leaks
- Session resumption saves RTT

## Real-World Example

```python
openssl s_client -connect api.example.com:443
```

## Connections

- **Built from:** [[http|HTTP]] -- HTTPS wraps HTTP
- **Related:** [[http-request-response-cycle|HTTP Request Response Cycle]] -- cycle includes TLS
- **Related:** [[cors|CORS]] -- CORS still applies over HTTPS
- **Builds into:** [[http-headers|HTTP Headers]] -- headers encrypted

## Edge Cases & Gotchas

- Self-signed cert trusted by client -- breaks auth
- Terminating TLS but logging plaintext
