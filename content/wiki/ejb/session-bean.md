---
concept: Session Bean
aliases: [EJB Session Bean]
tags: [dev, ejb, enterprise-java]
created: 2026-04-11
updated: 2026-04-11
---

# Session Bean

## The Problem

How do you model business processes and workflow logic in a server-side Java application that can be managed by a container and participate in transactions?

## Core Idea

A session bean is a server-side component that represents work being performed for client code. It implements business logic, rules, algorithms, and workflow. Session beans are business process objects—not persistent data objects.

## How It Works

- Client code accesses session beans through the EJB container
- The container intercepts all calls, providing middleware services (security, transactions, concurrency)
- Session beans are non-persistent—they exist only in memory during a client session
- When the client disconnects, the session bean can be destroyed
- Session beans do not survive server or machine crashes

## Key Properties

- Non-persistent (in-memory only)
- Short-lived (lifetime of client session)
- Not shared between multiple clients
- Can perform database operations but are not themselves persistent
- Two subtypes: stateful and stateless

## Connections

- Built from: [[ejb-container|EJB Container]]
- Builds into: [[stateful-session-bean|Stateful Session Bean]], [[stateless-session-bean|Stateless Session Bean]]
- Contrasts with: [[entity-bean|Entity Bean]]
- Related: [[ejb-home-interface|Home Interface]], [[ejb-object|EJB Object]]

## Edge Cases & Gotchas

- Session beans cannot survive application server crashes
- If client times out, container may destroy the session bean
- Do not rely on ejbRemove() for critical cleanup—it may never be called if container crashes

## Sources

- [[ejb-source-summary|EJB Source]]
