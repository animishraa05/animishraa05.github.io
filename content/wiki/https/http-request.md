---
concept: HTTP Request
aliases: [HTTP GET, HTTP POST, request message]
tags: [networking, http]
sources_count: 1
last_source: https.md
created: 2026-04-30
updated: 2026-04-30
---

## The Problem

After establishing a TCP (and possibly TLS) connection, the browser needs to ask the server for a specific resource. Without a structured request format, servers wouldn't understand what the client wants.

## Core Idea

An HTTP request is a structured message from client to server containing: method (GET, POST, etc.), target URL path, headers (cookies, user-agent), and optional body (for POST/PUT).

## How It Works

A typical HTTP request looks like:

```
GET / HTTP/1.1
Host: google.com
User-Agent: Mozilla/5.0
Cookie: session=abc123
```

1. **Request Line**: Method + path + HTTP version
2. **Headers**: Key-value pairs (Host, User-Agent, Cookie, etc.)
3. **Body**: Optional data (for POST requests with form data/JSON)

The server reads this and determines what to return.

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Browser [label="Browser"];
    Request [label="GET / HTTP/1.1\nHost: google.com\nUser-Agent: ..."];
    Server [label="Server"];
    
    Browser -> Request [label="sends"];
    Request -> Server [label="over TCP/TLS"];
}
```

## Key Properties

- Methods: GET (fetch), POST (submit), PUT (update), DELETE, etc.
- Headers provide metadata (cookies, auth, content-type)
- Body present only for methods that send data (POST, PUT)
- HTTP/1.1 requires Host header (virtual hosting)

## Connections

- **Built from:** [[tcp-handshake|TCP Handshake]] — TCP connection must exist first
- **Built from:** [[tls-handshake|TLS Handshake]] — for HTTPS, TLS wraps HTTP
- **Builds into:** [[http-response|HTTP Response]] — server replies to request
- **Related:** [[http-headers|HTTP Headers]] — headers are part of the request
- **Related:** [[http-methods|HTTP Methods]] — GET, POST, PUT, DELETE

## Edge Cases & Gotchas

- GET requests shouldn't have a body (though some servers accept it)
- Large headers can cause issues (proxy limits)
- Missing Host header fails in HTTP/1.1
- Request smuggling possible with malformed headers

## Sources

- [[https-summary|HTTP HTTPS DNS URL Source]]
