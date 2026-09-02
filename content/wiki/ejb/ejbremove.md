---
concept: ejbRemove()
tags: [dev, ejb]
created: 2026-04-28
updated: 2026-04-28
---

## The Problem

How does an entity bean delete its database record when a client calls remove() on the EJB object? How does the bean know which record to delete when instances are pooled?

## Core Idea

`ejbRemove()` is a container callback that deletes the entity's database record. In BMP, the bean must call `getPrimaryKey()` to identify which record to delete, then execute a DELETE query.

## How It Works

1. Client calls `proxy.remove()` on EJB object
2. Container calls `ejbRemove()` on the bean instance
3. In BMP: bean calls `ctx.getPrimaryKey()` to get the entity ID
4. Bean executes `DELETE` query to remove the database row
5. After returning, bean goes back to the pool—data is gone

## Key Properties

- Only deletes the database record, not the Java object itself
- Bean can be pooled and reused for different data after removal
- In BMP, developer writes DELETE logic
- In CMP, container auto-generates the DELETE

## Connections

- Built from: [[entity-bean|Entity Bean]], [[getprimarykey|getPrimaryKey()]]
- Related: [[ejbcreate|ejbCreate()]], [[ejbload|ejbLoad()]], [[bean-managed-persistence|Bean-Managed Persistence]]

## Edge Cases & Gotchas

- Different from session bean `ejbRemove()`—that deletes the bean from RAM, this deletes database data
- Must call `getPrimaryKey()` because bean instances are pooled and reused
- No parameters are passed—bean's identity must be queried from context