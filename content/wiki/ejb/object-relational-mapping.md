---
concept: Object-Relational Mapping
aliases: [O/R Mapping, ORM]
tags: [dev, ejb, persistence, database]
created: 2026-04-11
updated: 2026-05-13
---

## The Problem

How do you convert Java objects to relational database tables and vice versa without writing complex SQL for every operation?

## Core Idea

Object-Relational Mapping (O/R mapping) is the technology of converting in-memory Java objects to relational database data (and back). It decomposes objects into database fields and maps object instances to table rows.

## How It Works

- Java class maps to a database table
- Class fields map to table columns
- Object instance maps to a table row
- O/R mapper generates SQL (INSERT, UPDATE, DELETE, SELECT) automatically
- Can query database using object-oriented queries instead of raw SQL

## Key Properties

- Decomposes objects into relational data
- Enables arbitrary database queries (unlike serialization)
- Data is visually inspectable in the database
- Can be handcrafted or automated with tools like Hibernate, EclipseLink, and MyBatis
- EJB uses this for entity beans (CMP)
- Hibernate extends ORM with caching (1st/2nd level), HQL (object-oriented queries), and inheritance mapping strategies



## Visual Explanation

```dot
digraph Object_Relational_Mapping {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Object Relational Ma\nInput"]
  B [label="Object Relational Ma\nCore Mechanism"]
  C [label="Object Relational Ma\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_Object_Relational_Mapping {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Object Relational Ma" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- Built from: [[entity-bean|Entity Bean]]
- Related: [[container-managed-persistence|Container-Managed Persistence]], [[jdbc|JDBC]]

## Edge Cases & Gotchas

- Complex object relationships (inheritance, nested objects) are challenging
- Performance can vary based on mapping strategy
- Tool-specific quirks and limitations