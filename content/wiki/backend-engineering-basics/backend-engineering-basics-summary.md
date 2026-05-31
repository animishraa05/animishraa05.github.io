---
source: Backend Engineering Basics
source_path: sources/Backend Engineering Basics.md
content_hash: 401791f91ca599ff8d7991fbbf9a519adcca4d7f0af65201259c7b2629957856
ingested: 2026-04-12
concepts_count: 18
tags: [dev, backend]
---

# Source: Backend Engineering Basics

## Overview

A comprehensive first-principles introduction to backend engineering, covering how the internet works, HTTP, sockets, TLS, databases, authentication, and modern backend architecture. Designed for a BCA student learning backend from fundamentals.

## Concepts Extracted

- [[backend-as-program|Backend as Program]] — core concept: backend is just a program listening on a port
- [[ip-address|IP Address]] — unique machine identification on networks
- [[dns|DNS]] — translates domain names to IP addresses
- [[port|Port]] — identifies specific services on a machine
- [[socket|Socket]] — OS-managed communication endpoint
- [[tcp-handshake|TCP Handshake]] — establishes reliable TCP connection
- [[tls-handshake|TLS Handshake]] — establishes encrypted communication
- [[http-protocol|HTTP Protocol]] — text-based request-response protocol
- [[curl|curl]] — CLI tool for direct HTTP communication
- [[sql-database|SQL Database]] — structured relational data storage
- [[nosql-database|NoSQL Database]] — flexible schema data storage
- [[session-authentication|Session Authentication]] — server-side session-based auth
- [[jwt-authentication|JWT Authentication]] — stateless token-based auth
- [[backend-architecture|Backend Architecture]] — layered system structure
- [[backend-framework|Backend Framework]] — libraries that automate server basics

## Key Takeaways

- Backend is fundamentally a program—servers aren't special machines, they're software
- Everything builds on sockets—HTTP, TLS, databases all run on top of socket connections
- Frameworks are abstractions over fundamentals—knowing the basics makes any framework learnable
- TLS is typically terminated at reverse proxies (Nginx), not in the application code
- Session auth requires server storage; JWT is stateless but has revocation challenges

## Novelty

This source reinforces existing wiki content on HTTP, server, client-server model, and API concepts while adding foundational depth on sockets, TLS handshake internals, and the actual mechanics of how HTTP is built on top of sockets. The emphasis on "backend from first principles" provides strong conceptual grounding for networking and systems topics.

## Edge Cases & Questions Raised

- How does HTTP parsing differ between frameworks?
- What are the exact performance trade-offs between session and JWT auth at scale?
- When should you build from scratch vs use a framework?
- How do reverse proxies actually handle TLS termination in production?

## Connections

- [[backend-as-program|Backend as Program]] — core concept
- [[socket|Socket]] — communication endpoint
- [[tcp-handshake|TCP Handshake]] — connection establishment
- [[tls-handshake|TLS Handshake]] — encryption negotiation
- [[http-protocol|HTTP Protocol]] — application protocol
- [[dns|DNS]] — name resolution
- [[sql-database|SQL Database]] — relational storage
- [[nosql-database|NoSQL Database]] — flexible storage
- [[session-authentication|Session Authentication]] — server-side auth
- [[jwt-authentication|JWT Authentication]] — stateless auth
- [[backend-architecture|Backend Architecture]] — layered structure
- [[backend-framework|Backend Framework]] — abstraction layer