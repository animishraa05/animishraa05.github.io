---
title: HTTP Versions
concept: true
aliases: [HTTP 1.0, HTTP 1.1, HTTP 2.0, HTTP 3.0]
tags: [networking, http]
sources_count: 1
last_source: understanding-http-for-backend-engineers
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Early HTTP was inefficient—each request opened a new TCP connection, adding latency. The protocol needed evolution to handle modern web scale.

## Core Idea

HTTP has evolved through four major versions, each adding performance and capability improvements while maintaining backward compatibility at the application level.

## How It Works

### HTTP 1.0 (1991)

- Each request opens a new TCP connection
- No persistent connections—significant latency
- Text-based protocol

### HTTP 1.1 (1997)

- **Persistent connections**: Multiple requests over one TCP connection
- Chunked transfer encoding
- Better caching (ETag, If-None-Match)
- Pipelining (later disabled due to HOL blocking)

### HTTP 2.0 (2015)

- **Multiplexing**: Multiple requests/responses in parallel over one connection
- Binary framing (more efficient to parse than text)
- Header compression (HPACK)
- Server Push (server sends resources before client asks)

### HTTP 3.0 (2022)

- Built on **QUIC** (runs over UDP, not TCP)
- Faster connection establishment
- No head-of-line blocking (even with packet loss)
- Continues multiplexing benefits

## Key Properties

| Version | Transport      | Key Feature               |
| ------- | -------------- | ------------------------- |
| 1.0     | TCP/new        | None (baseline)           |
| 1.1     | TCP/persistent | Reusable connections      |
| 2.0     | TCP/binary     | Multiplexing, server push |
| 3.0     | QUIC/UDP       | No HOL blocking           |

## Connections

- **Evolves from:** [[http|HTTP]] (the protocol)
- **Relates to:** Packet Switching (underlying transport mechanism)
- **Related to:** HTTP Headers (HPACK compression in HTTP/2)
- **Related to:** CORS (pre-flight benefits from version capabilities)

## Edge Cases & Gotchas

- HTTP/2 doesn't require encryption (but browsers only support h2 over TLS)
- HTTP/3 still has limited server support
- HTTP/1.1 pipelining was disabled due to bugs—HTTP/2 fixed this

## Sources

- [[understanding-http-for-backend-engineers-summary|Understanding HTTP for Backend Engineers]]
