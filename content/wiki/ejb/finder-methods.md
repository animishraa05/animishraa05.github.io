---
concept: Finder Methods
aliases: [ejbFindByPrimaryKey, ejbFindAllProducts]
tags: [dev, ejb]
created: 2026-04-28
updated: 2026-04-28
---

## The Problem

How do clients locate existing entity beans representing database records? Unlike session beans, entity beans persist beyond a single client interaction, so they need methods to find and load existing data.

## Core Idea

Finder methods are special methods on entity beans that search the database and return one or more primary keys of matching entity records. They don't create new data--they locate existing records.

## How It Works

- Defined on Home Interface (e.g., `findByPrimaryKey(String id)`)
- Implemented in bean class with `ejb` prefix: `ejbFindByPrimaryKey(AccountPK key)`
- Bean executes SQL SELECT query using JDBC
- Returns primary key to container, container creates EJB Object (proxy)
- Can return single key or Collection of keys

## Key Properties

- Must begin with `ejbFind` prefix
- Must implement at minimum `ejbFindByPrimaryKey()` -- required
- Return type: Primary Key object or Collection of Primary Keys
- Container generates for CMP, developer writes for BMP



## Visual Explanation

```dot
digraph Finder_Methods {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Finder Methods\nInput"]
  B [label="Finder Methods\nCore Mechanism"]
  C [label="Finder Methods\nOutput"]
  A -> B [label="triggers"]
  B -> C [label="produces"]
}
```

## Semantic Network

```dot
graph semantic_Finder_Methods {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Finder Methods" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related Concept" fillcolor="#f0f0f0"]
  REL2 [label="Builds Into" fillcolor="#d4edda"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds into"]
}
```
## Connections

- Built from: [[entity-bean|Entity Bean]], [[home-interface|Home Interface]]
- Builds into: [[primary-key|Primary Key]], [[bean-managed-persistence|Bean-Managed Persistence]]
- Contrasts with: [[ejbcreate|ejbCreate()]] (creates new vs finds existing)
- Related: [[finder-exception|FinderException]]

## Edge Cases & Gotchas

- Finder methods run while bean is still in the pool--before acquiring specific data
- Don't confuse with `ejbCreate()` which inserts new records
- Can return empty Collection but typically throw FinderException if not found
- Must NOT call `getPrimaryKey()` in finders--bean has no identity yet