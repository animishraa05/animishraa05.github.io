---
title: HTTP Methods
concept: true
aliases: [HTTP Verbs]
tags: [networking, http]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Clients need a standardized way to indicate what action they want the server to perform on a resource.

## Core Idea

HTTP methods (also called verbs) define the intent of a request. Each method has semantic meaning that clients and servers can rely on.

## How It Works

| Method | Intent           | Side Effects |
| ------ | ---------------- | ------------ |
| GET    | Fetch data       | None (safe)  |
| POST   | Create resource  | May create   |
| PUT    | Replace entirely | Idempotent   |
| PATCH  | Partial update   | May mutate   |
| DELETE | Remove           | Idempotent   |

```java
@RestController
@RequestMapping("/api/notes")
public class NoteController {
    @GetMapping("/{id}")        // Fetch
    @PostMapping               // Create
    @PutMapping("/{id}")       // Replace
    @PatchMapping("/{id}")     // Partial update
    @DeleteMapping("/{id}")    // Remove
}
```

## Key Properties

- **Safe methods**: GET, HEAD, OPTIONS — do not modify server state
- **Idempotent methods**: GET, PUT, DELETE — same result despite repeated calls
- **Non-idempotent**: POST, PATCH — repeated calls produce different results

## Connections

- **Built from:** [[http|HTTP]] (the protocol that defines these)
- **Related:** [[http-status-codes|HTTP Status Codes]] (codes pair with methods)
- **Contrasts with:** Circuit Switching (connection-held methods)
- **Related:** Statelessness (methods are independent requests)

## Edge Cases & Gotchas

- Use PATCH for most updates—PUT replaces entirely
- POST creates new resources; calling twice typically creates two records
- DELETE is idempotent—deleting already-deleted resource returns same response