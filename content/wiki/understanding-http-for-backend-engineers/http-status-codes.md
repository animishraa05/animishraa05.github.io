---
title: HTTP Status Codes
concept: true
aliases: [Status Codes, Response Codes]
tags: [networking, http]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Clients need a standardized way to understand whether their request succeeded, failed, or requires further action—without parsing custom error messages.

## Core Idea

HTTP status codes are standardized three-digit numbers that communicate the outcome of a request. The first digit indicates the category.

## How It Works

| Range | Meaning       | Key Codes                                                                              |
| ----- | ------------- | -------------------------------------------------------------------------------------- |
| 1xx   | Informational | 100 Continue, 101 Switching Protocols                                                  |
| 2xx   | Success       | 200 OK, 201 Created, 204 No Content                                                    |
| 3xx   | Redirection   | 301 Moved Permanently, 302 Found, 304 Not Modified                                     |
| 4xx   | Client Error  | 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 429 Too Many Requests |
| 5xx   | Server Error  | 500 Internal Server Error, 503 Unavailable                                             |

### Common Codes Explained

- **200 OK**: Request succeeded, body follows
- **201 Created**: Resource successfully created (POST)
- **204 No Content**: Success, no body to return (DELETE, OPTIONS)
- **400 Bad Request**: Client sent invalid data
- **401 Unauthorized**: No/invalid authentication
- **403 Forbidden**: Authenticated but insufficient permission
- **404 Not Found**: Resource doesn't exist
- **429 Too Many Requests**: Rate limit exceeded

```java
@GetMapping("/{id}")
public ResponseEntity<Note> getNote(@PathVariable Long id) {
    return noteService.findById(id)
        .map(ResponseEntity::ok)
        .orElse(ResponseEntity.notFound()); // 404
}

@PostMapping
public ResponseEntity<Note> createNote(@RequestBody NoteRequest req) {
    Note note = noteService.create(req);
    return ResponseEntity.status(HttpStatus.CREATED).body(note); // 201
}
```

## Connections

- **Built from:** [[http|HTTP]] (response structure)
- **Related to:** [[http-headers|HTTP Headers]] (error responses may include detail in headers)
- **Part of:** [[http-methods|HTTP Methods]] (which codes pair with which methods - 201 with POST, 204 with DELETE)
- **Related to:** CORS (403 Forbidden is CORS policy violation)

## Edge Cases & Gotchas

- 401 vs 403: 401 = not authenticated, 403 = authenticated but no permission
- 204 has no body—don't try to return JSON with 204
- 304 must not include response body (browser uses cached version)