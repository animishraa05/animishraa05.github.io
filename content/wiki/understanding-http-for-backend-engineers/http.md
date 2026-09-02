---
title: HTTP
concept: true
aliases: [Hypertext Transfer Protocol]
tags: [networking, http]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Without a standardized protocol, every client and server would need custom communication logic. The internet would fragment into isolated systems that cannot interoperate.

## Core Idea

HTTP (Hypertext Transfer Protocol) is the standardized language that enables any client—a browser, mobile app, Postman, or CLI tool—to communicate with any server, regardless of technology stack.

## How It Works

HTTP operates at the Application Layer (Layer 7) of the OSI model, using TCP as its transport protocol. The client initiates communication by sending a request, and the server responds with an appropriate message.

Key architectural decisions:

- **Statelessness**: Each request is independent; the server retains no memory of past interactions
- **Client-Server Model**: Communication is always client-initiated; the server cannot spontaneously send data
- **Standardized Message Format**: HTTP defines consistent structures for requests and responses

## Key Properties

- Runs over TCP (reliable delivery) for HTTP 1.x/2.x, over QUIC/UDP for HTTP 3.0
- Text-based (1.x) or binary (2.x, 3.x) message framing
- Extensible via headers without protocol changes
- Works with persistent connections (1.1+) for efficiency

## Connections

- **Built from:** [[packet-switching|Packet Switching]] (transported as network packets)
- **Related:** [[circuit-switching|Circuit Switching]] (alternative transport paradigm)
- **Contrasts with:** WebSocket (bidirectional, server-can-send)
- **Related:** HTTPS (encrypted HTTP variant)

## Edge Cases & Gotchas

- HTTP is text-based in 1.x—binary data must be encoded (Base64)
- Without state management, every request must re-authenticate
- Servers cannot push data to clients without WebSockets or polling