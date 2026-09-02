---
concept: Entity Bean
aliases: [EJB Entity Bean]
tags: [dev, ejb, persistence]
created: 2026-04-11
updated: 2026-04-28
---

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

- Built from: [[ejb-container|EJB Container]], [[primary-key|Primary Key]], [[entity-bean-identity|Entity Bean Identity]], [[entity-bean-instance-vs-data|Entity Bean Instance vs Data]], [[persistence-concepts|Persistence Concepts]]
- Builds into: [[bean-managed-persistence|Bean-Managed Persistence]], [[container-managed-persistence|Container-Managed Persistence]], [[entity-context|Entity Context]]
- Contrasts with: [[session-bean|Session Bean]], [[message-driven-bean|Message-Driven Bean]], [[session-bean-lifetime|Session Bean Lifetime]]
- Related: [[instance-pooling|Instance Pooling]], [[finder-methods|Finder Methods]], [[ejbload|ejbLoad()]], [[ejbstore|ejbStore()]], [[ejbcreate|ejbCreate()]], [[ejbremove|ejbRemove()]]
- Related: [[entity-bean-transactions|Entity Bean Transaction Rules]], [[one-to-one-relationship|One-to-One Relationship]], [[one-to-many-relationship|One-to-Many Relationship]], [[many-to-many-relationship|Many-to-Many Relationship]], [[serialization-vs-orm|Serialization vs ORM]]

## Edge Cases & Gotchas

- Entity beans represent data, not business logic
- Not suitable for complex workflow or algorithms (use session beans for that)
- The difference between entity bean instance and entity bean data is important