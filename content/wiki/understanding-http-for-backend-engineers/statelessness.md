---
title: Statelessness
concept: true
aliases: [HTTP Statelessness]
tags: [networking, http]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Server memory grows without bound if every interaction must be preserved. Scaling becomes impossible when specific servers must handle specific clients.

## Core Idea

Each HTTP request contains all information needed for the server to process it. The server has no memory of past requests--every interaction is independent.

## How It Works

When a client requests a resource, the request includes authentication credentials, headers, URL, and body. After the server responds, it forgets the interaction entirely. The next request is treated as completely new.

```java
// Every request must include auth - server has no memory
@GetMapping("/api/users/{id}")
public ResponseEntity<User> getUser(
    @PathVariable Long id,
    @RequestHeader("Authorization") String token) {
    // Token must be sent every time - no session from previous requests
    return ResponseEntity.ok(userService.findById(id));
}
```

## Key Properties

- **Simplicity**: No session store, cleanup, or synchronization needed
- **Scalability**: Any server can handle any request; load balancing is trivial
- **Resilience**: Server crash doesn't affect client state--no session to restore



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

- **Built from:** [[http|HTTP]] (the protocol that enforces this property)
- **Related:** [[rest-api|REST Architecture]] (stateless APIs follow HTTP pattern)
- **Contrasts with:** Circuit Switching (stateful connection holding)
- **Related:** Broadcast Links (one-to-many pattern)

## Edge Cases & Gotchas

- Stateful applications require tokens/cookies sent with every request
- Without state management, users would re-authenticate on every action
- Performance cost of re-sending data is acceptable given scale benefits