---
concept: HTTP Response
aliases: [HTTP reply, server response, 200 OK]
tags: [networking, http]
sources_count: 1
last_source: https.md
created: 2026-04-30
updated: 2026-04-30
---

# HTTP Response

## The Problem

The server has processed the request—now it needs to send back the result. Without a structured response format, the client wouldn't know if the request succeeded, what data was returned, or how to interpret it.

## Core Idea

An HTTP response is the server's reply containing: status code (200, 404, etc.), headers (content-type, cache-control), and body (HTML, JSON, etc.).

## How It Works

A typical HTTP response looks like:

```
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 1234

<html>...</html>
```

1. **Status Line**: HTTP version + status code + reason phrase
2. **Headers**: Metadata (content-type, cache settings, cookies)
3. **Body**: The actual data (HTML page, JSON, image, etc.)

The browser processes the response based on headers and status code.

## Visual Explanation

```dot
digraph G {
    rankdir=LR;
    node [shape=box, style=rounded];
    
    Server [label="Server"];
    Response [label="HTTP/1.1 200 OK\nContent-Type: text/html\n\n<html>...</html>"];
    Browser [label="Browser"];
    
    Server -> Response [label="sends"];
    Response -> Browser [label="over TCP/TLS"];
}
```

## Key Properties

- Status codes: 2xx (success), 3xx (redirect), 4xx (client error), 5xx (server error)
- Headers tell browser how to handle the response (content-type, caching)
- Body contains the actual resource (HTML, CSS, JS, images)
- Responses can be cached based on cache headers

## Connections

- **Built from:** [[http-request|HTTP Request]] — response is the reply to a request
- **Builds into:** [[browser-rendering|Browser Rendering]] — HTML response gets rendered
- **Related:** [[http-status-codes|HTTP Status Codes]] — 200, 404, 500, etc.
- **Related:** [[http-headers|HTTP Headers]] — headers control response behavior

## Edge Cases & Gotchas

- 204 No Content has no body (valid response)
- 301/302 redirects cause browser to make a new request
- 304 Not Modified uses cached version (saves bandwidth)
- Chunked transfer encoding streams large responses

## Sources

- [[https-summary|HTTP HTTPS DNS URL Source]]
