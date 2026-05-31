---
title: Client
concept: client
aliases: [client computer]
tags: [systems, client]
sources_count: 1
last_source: front-end-and-back-end-wikipedia
created: 2026-04-12
updated: 2026-04-12
---

## The Problem

How do users interact with networked services? What handles the user interface and initiates requests to servers?

## Core Idea

A client is a computer or software that requests services from a server. In the client-server model, the client is typically the front end, handling user interaction and presentation.

## How It Works

1. **User Interface**: Displays information and captures user input
2. **Request Initiation**: Sends requests to servers for data or services
3. **Response Processing**: Receives and processes server responses
4. **Local Processing**: May perform some computation locally
5. **State Management**: May maintain some client-side state

Clients can be web browsers, mobile apps, desktop applications, or any software that consumes server services.

## Key Properties

- Initiates requests to servers
- Typically handles presentation and user interaction
- Can be lightweight (thin client) or feature-rich (thick/rich client)
- Runs on user devices, often less powerful than servers
- May cache data for offline or performance reasons

## Connections

**Builds into:**

- [[front-end|Front End]] — Client typically runs front end components

**Related:**

- [[client-server-model|Client-Server Model]] — Client is one side of the model
- [[back-end|Back End]] — Server counterpart to client

## Edge Cases & Gotchas

- Cannot securely store secrets (tokens, keys)
- Limited by device capabilities
- Network dependency affects functionality

## Sources

- [[front-end-and-back-end-wikipedia-summary|Front End and Back End — Wikipedia]]
