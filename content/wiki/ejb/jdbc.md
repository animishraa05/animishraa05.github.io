---
concept: JDBC
aliases: [Java Database Connectivity]
tags: [dev, database]
created: 2026-04-28
updated: 2026-04-28
---

## The Problem

How do Java applications interact with relational databases in a portable way, without being tied to specific database products?

## Core Idea

JDBC (Java Database Connectivity) is a standard Java API that provides universal database access. Applications use the JDBC API, while database-specific JDBC drivers handle the actual communication with each database.

## How It Works

- Application uses JDBC API to issue SQL statements
- JDBC Driver Manager selects the appropriate driver for the database
- Driver translates JDBC calls to database-specific protocol
- Results are returned through standard JDBC result sets

## Key Properties

- Part of Java SE standard edition
- Drivers for all major databases (MySQL, Oracle, PostgreSQL, etc.)
- Supports connection pooling through DataSource
- SQL statements via Statement, PreparedStatement, CallableStatement



## Visual Explanation

```dot
digraph JDBC {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Jdbc\nInput"]
  B [label="Jdbc\nCore Mechanism"]
  C [label="Jdbc\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_JDBC {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Jdbc" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- Built from: [[bean-managed-persistence|Bean-Managed Persistence]]
- Related: [[ejbload|ejbLoad()]], [[ejbstore|ejbStore()]], [[ejbcreate|ejbCreate()]], [[ejbremove|ejbRemove()]]
- Related: [[session-bean-relationships|Session Bean Relationships]], [[one-to-one-relationship|One-to-One Relationship]]

## Edge Cases & Gotchas

- Must close connections, statements, and result sets properly
- Use PreparedStatement to prevent SQL injection