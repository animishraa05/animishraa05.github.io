---
concept: TLS Handshake
aliases: [TLS, SSL, transport layer security, SSL handshake, HTTPS handshake]
tags: [security, tls]
created: 2026-04-12
updated: 2026-04-30
---

## The Problem

Without encryption, anyone between client and server can read or modify data (passwords, credit cards, messages). Without authentication, you can't verify you're talking to the real server. TLS solves both problems—but how do two machines agree on encryption without an attacker eavesdropping?

## Core Idea

TLS (Transport Layer Security) handshake is the negotiation process where client and server agree on encryption methods, exchange keys securely, and verify each other's identity before any actual data is sent. It's like two strangers meeting and agreeing on a secret language and verifying IDs before sharing secrets.

## How It Works

1. **Client Hello**: Client sends supported cipher suites, TLS version, and a random number
2. **Server Hello**: Server picks a cipher, sends its certificate, and its own random number
3. **Certificate Verification**: Client verifies the server's certificate against trusted Certificate Authorities (CAs)
4. **Key Exchange**: Both derive a shared secret key using Diffie-Hellman or RSA (the key itself is never sent)
5. **Finished**: Both confirm the handshake succeeded, switching to encrypted communication

After handshake, all data is encrypted using the agreed-upon cipher (e.g., AES-256-GCM).

## Key Properties

- Establishes encrypted channel before any application data
- Provides server authentication (client knows it's talking to the real server)
- Optionally provides client authentication (mutual TLS)
- Uses asymmetric encryption for key exchange, symmetric for data encryption (efficient)
- Runs on top of TCP, before HTTP begins

## Connections
- **Built from:** [[socket|Socket]] — TLS runs over TCP sockets
- **Built from:** [[tcp-handshake|TCP Handshake]] — TCP must be established first
- **Builds into:** [[https|HTTPS]] — HTTPS is HTTP over TLS
- **Builds into:** [[hsts|HSTS]] — HSTS enforces HTTPS/TLS usage
- **Related:** [[http|HTTP]] — TLS encrypts HTTP communication
- **Contrasts with:** [[http|HTTP]] — plain HTTP has no encryption or authentication
- **Related:** [[certificate-authority|Certificate Authority]] — CAs sign certificates for server verification

## Edge Cases & Gotchas

- Expired certificates cause browser warnings
- Self-signed certificates work for development but not production
- TLS termination usually happens at reverse proxy (Nginx), not at the app
- TLS 1.3 is faster (1 round trip vs 2 in TLS 1.2)
- Man-in-the-middle attacks are trivial on HTTP, nearly impossible on HTTPS