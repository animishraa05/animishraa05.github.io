---
concept: Bean-Managed Persistence
aliases: [BMP]
tags: [dev, ejb, persistence]
created: 2026-04-11
updated: 2026-04-11
---

# Bean-Managed Persistence

## The Problem

How do you have full control over how entity beans interact with the database?

## Core Idea

With bean-managed persistence (BMP), the developer writes explicit JDBC code (or uses other database APIs) in the entity bean to handle all database operations. The developer is responsible for implementing ejbCreate(), ejbRemove(), ejbFind(), and other data access methods.

## How It Works

- Developer writes JDBC code in bean methods
- ejbCreate() inserts data into the database
- ejbRemove() deletes data from the database
- Finder methods (ejbFindByPrimaryKey, etc.) query the database
- Container calls these methods, but developer implements the SQL logic

## Key Properties

- Full control over database operations
- Developer writes JDBC code
- More flexibility than CMP
- More code to maintain
- Container still provides middleware services

## Connections

- Built from: [[entity-bean|Entity Bean]]
- Contrasts with: [[container-managed-persistence|Container-Managed Persistence]]
- Related: [[ejbcreate|ejbCreate()]], [[ejbremove|ejbRemove()]]

## Edge Cases & Gotchas

- More error-prone than CMP
- Database-specific code may reduce portability
- Must handle transactions manually in some cases

## Sources

- [[ejb-source-summary|EJB Source]]
