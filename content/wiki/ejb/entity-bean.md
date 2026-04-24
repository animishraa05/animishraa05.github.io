---
concept: Entity Bean
aliases: [EJB Entity Bean]
tags: [dev, ejb, persistence]
created: 2026-04-11
updated: 2026-04-11
---

# Entity Bean

## The Problem

How do you model persistent business data in EJB so that it survives beyond client sessions and can be shared across multiple clients?

## Core Idea

An entity bean is a persistent object that represents business data stored in permanent storage (typically a relational database). Entity beans are the "nouns" of EJB—representing things like bank accounts, customers, and products.

## How It Works

- Entity beans have an identity (primary key) that distinguishes them
- They survive server crashes and can live for months or years
- Multiple clients can share the same entity bean
- Lifetime is independent of any client session
- Container can manage persistence (CMP) or bean can manage it (BMP)
- Mapped to database tables via O/R mapping

## Key Properties

- Persistent (survives beyond client session)
- Has identity (primary key)
- Shared by multiple clients
- Can be mapped to relational database tables
- Models data, not process or workflow
- Can be accessed and modified by session beans

## Connections

- Contrasts with: [[session-bean|Session Bean]]
- Related: [[container-managed-persistence|Container-Managed Persistence]], [[bean-managed-persistence|Bean-Managed Persistence]], [[primary-key|Primary Key]]

## Edge Cases & Gotchas

- Entity beans represent data, not business logic
- Not suitable for complex workflow or algorithms (use session beans for that)
- The difference between entity bean instance and entity bean data is important

## Sources

- [[ejb-source-summary|EJB Source]]
