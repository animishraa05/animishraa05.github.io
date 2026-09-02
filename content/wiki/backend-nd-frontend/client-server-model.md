---
title: Client-Server Model
concept: client-server-model
aliases: [client-server architecture]
tags: [systems, client-server]
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How do you structure an application where one side (client) handles user interaction while another side (server) manages data and processing? What is the fundamental architecture?

## Core Idea

The client-server model is a distributed architecture where clients request services from servers. The client handles most user-facing tasks while the server manages data and logic. Front end maps to client, back end maps to server.

## How It Works

1. **Client**: Initiates requests, renders UI, captures user input, displays results
2. **Server**: Receives requests, processes logic, accesses data, returns responses
3. **Communication**: Through network protocols (HTTP, WebSocket)
4. **Separation**: Client and server can be on different machines, even geographically separated
5. **Responsibilities**: Client focuses on presentation, server focuses on data/processing

This separation allows scaling—multiple clients can connect to one server, and servers can be scaled independently from clients.

## Key Properties

- Client makes requests, server provides responses
- Client is typically front end, server is typically back end
- Network communication between client and server
- Server is usually more powerful, shared across clients
- Client can be thin or thick (rich client with more logic)
- Stateless or stateful communication patterns

## Connections

**Built from:**

- [[client|Client]] — Requesting entity in the model
- [[server|Server]] — Responding entity in the model

**Builds into:**

- [[front-end|Front End]] — Client side is front end
- [[back-end|Back End]] — Server side is back end
- [[api|API]] — Communication interface between client and server

**Related:**

- [[http|HTTP]] — Common protocol for client-server communication
- [[scalability|Scalability]] — Benefit of client-server separation

## Edge Cases & Gotchas

- Network latency affects responsiveness
- Server failure affects all connected clients
- Requires well-designed APIs for communication
- Security considerations for network communication