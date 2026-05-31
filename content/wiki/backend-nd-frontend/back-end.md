---
title: Back End
concept: back-end
aliases: [backend, server-side, server]
tags: [dev, backend]
sources_count: 1
last_source: front-end-and-back-end-wikipedia
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

While users interact with the front end, the actual data processing, storage, and business logic must happen somewhere secure and centralized. How do you handle data management and processing behind the scenes?

## Core Idea

Back end refers to the data management and processing layer behind the scenes. It handles data storage, business logic, and server operations. In the client-server model, the back end typically resides on the server.

## How It Works

1. **Data Storage**: Manages databases and persists application data
2. **Business Logic**: Processes data according to application rules and workflows
3. **Authentication & Authorization**: Verifies user identity and permissions
4. **API Implementation**: Exposes endpoints for front end communication
5. **Security**: Protects against threats, validates input, encrypts sensitive data
6. **Scalability**: Handles increased load through clustering, caching, load balancing

In web development, back end includes server languages (PHP, Python, Ruby, Java, Node.js), databases, APIs, security practices, and system architecture.

## Key Properties

- Server-side execution, often remote from users
- Handles data management and persistence
- Implements business logic and rules
- Exposes APIs for front end consumption
- Must ensure security, authentication, authorization
- Manages scalability and high availability
- Includes database administration and data access layers

## Connections

**Built from:**

- [[server|Server]] — Back end typically runs on servers
- [[business-logic|Business Logic]] — Back end implements business rules
- [[data-access-layer|Data Access Layer]] — Back end handles data access

**Builds into:**

- [[full-stack|Full Stack]] — Back end combined with front end forms full stack
- [[api|API]] — Back end implements APIs for front end consumption

**Related:**

- [[server|Server]] — Back end runs on servers
- [[front-end|Front End]] — Complements back end as the client-side counterpart
- [[client-server-model|Client-Server Model]] — Underlying architecture for front end/back end split
- [[scalability|Scalability]] — Back end must handle growth in usage
- [[high-availability|High Availability]] — Back end must remain operational

## Edge Cases & Gotchas

- Server failures affect all users—high availability is critical
- Database bottlenecks can cripple performance
- Security vulnerabilities in back end expose all data
- Must validate all input—even from trusted front ends

## Sources

- [[front-end-and-back-end-wikipedia-summary|Front End and Back End — Wikipedia]]
