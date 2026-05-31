---
concept: ejbLoad()
tags: [dev, ejb]
created: 2026-04-28
updated: 2026-04-28
---

# ejbLoad()

## The Problem

How does an entity bean synchronize its in-memory state with the database when the container loads data for a specific entity? How does the bean know which database row to load?

## Core Idea

`ejbLoad()` is a container callback that loads entity state from the database into the bean instance. In BMP, the bean must call `getPrimaryKey()` to determine which record to load, then execute a SELECT query.

## How It Works

1. Container calls `ejbLoad()` on the bean instance
2. Bean calls `ctx.getPrimaryKey()` to get the current entity's ID
3. Bean acquires JDBC connection
4. Bean executes `SELECT` query using the primary key
5. Bean populates its fields from the ResultSet

## Key Properties

- Called when container assigns a data instance to a bean
- Called after `ejbActivate()` or at the start of a transaction
- In BMP: developer writes the SELECT logic
- In CMP: container auto-generates the SELECT
- Must call `getPrimaryKey()` to know which data to load

## Connections

- Built from: [[entity-bean|Entity Bean]], [[getprimarykey|getPrimaryKey()]], [[entity-context|Entity Context]]
- Builds into: [[ejbstore|ejbStore()]] (opposite operation)
- Related: [[jdbc|JDBC]], [[ejbactivate|ejbActivate()]]

## Edge Cases & Gotchas

- Not called on every method—only when loading from DB is needed
- Called BEFORE business methods in the ready state
- Don't confuse with `ejbActivate()` which acquires resources, not data

## Sources

- [[ejb-continued-summary|EJbContinued]]