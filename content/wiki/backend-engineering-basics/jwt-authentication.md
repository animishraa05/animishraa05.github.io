---
concept: JWT Authentication
aliases: [JWT, JSON Web Token, token-based auth, bearer token]
tags: [security, authentication]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

Sessions require server-side storage and don't work well across multiple servers. What if you need to scale horizontally without sticky sessions, or authenticate from mobile apps where cookies don't work? JWT provides a stateless solution.

## Core Idea

JWT (JSON Web Token) is a self-contained token that contains user information encoded as JSON, signed cryptographically. Instead of storing sessions in a database, the server embeds user data directly in the token. The client sends the token with each request; the server verifies the signature to trust the data.

## How It Works

1. **Login**: User submits credentials
2. **Token Creation**: Server verifies credentials, creates JWT with user ID and claims, signs with secret/key
3. **Token Sent**: Server returns JWT to client (in response body or Authorization header)
4. **Subsequent Requests**: Client sends JWT in Authorization header: `Bearer <token>`
5. **Verification**: Server verifies signature, extracts user info, processes request
6. **No Server Storage**: Token contains all needed information—no lookup required

JWT has three parts: header (algorithm), payload (claims), signature (verification).

## Key Properties

- Stateless—no server-side session storage needed
- Self-contained—token holds user info and claims
- Signed—server can verify authenticity without database lookup
- Scalable—any server can verify token, no shared session store needed
- Client stores token (localStorage or secure storage)
- Popular for APIs, SPAs, mobile apps

## Connections

- **Built from:** [[tls-handshake|TLS Handshake]] — tokens should be sent over HTTPS
- **Builds into:** [[api|API]] — JWT commonly secures REST APIs
- **Contrasts with:** [[session-authentication|Session Authentication]] — different auth paradigm
- **Related:** [[http|HTTP]] — JWT sent in Authorization header

## Edge Cases & Gotchas

- Tokens are immutable—if you need to revoke, you need a blacklist (defeats statelessness)
- Tokens in localStorage are vulnerable to XSS
- Token size larger than session ID (more bandwidth)
- No logout on server—you can only expire tokens on client
- Need to handle token refresh (short-lived access + long-lived refresh tokens)