---
concept: Instance Pooling
aliases: [EJB Pooling]
tags: [dev, ejb, performance]
created: 2026-04-11
updated: 2026-04-11
---

# Instance Pooling

## The Problem

How does EJB efficiently handle many client requests without creating a new bean instance for each request?

## Core Idea

Instance pooling is a technique where the EJB container maintains a pool of pre-created bean instances that can be shared among clients. This avoids the overhead of creating and destroying bean objects for each request.

## How It Works

- Container pre-creates a number of bean instances at startup
- When a client needs a bean, container assigns one from the pool
- After method completes, instance returns to pool for reuse
- Container can adjust pool size based on demand
- Stateless session beans are ideal for pooling since they have no client-specific state

## Key Properties

- Applies primarily to stateless session beans
- Improves performance and scalability
- Reduces object creation/destruction overhead
- Container controls pool size
- All pooled instances of a stateless bean are equivalent

## Connections

- Built from: [[stateless-session-bean|Stateless Session Bean]]
- Related: [[ejb-container|EJB Container]]

## Edge Cases & Gotchas

- Stateful session beans generally cannot be pooled (each has unique state)
- Pool size configuration is vendor-specific
- Too small pool causes client wait times; too large wastes memory

## Sources

- [[ejb-source-summary|EJB Source]]
