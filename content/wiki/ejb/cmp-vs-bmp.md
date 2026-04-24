---
title: CMP vs BMP — Entity Bean Persistence
type: comparison
tags: [dev, ejb, persistence]
created: 2026-04-11
updated: 2026-04-11
---

# CMP vs BMP — Entity Bean Persistence

## Overview

Entity beans represent persistent data in EJB. The key architectural decision is who handles the persistence: the container (CMP) or the bean itself (BMP).

## Comparison

| Feature                    | Container-Managed Persistence (CMP) | Bean-Managed Persistence (BMP) |
| -------------------------- | ----------------------------------- | ------------------------------ |
| **Developer writes JDBC?** | No                                  | Yes                            |
| **O/R Mapping**            | Defined at deployment time          | Hand-coded                     |
| **Portability**            | High (storage-independent)          | Lower (DB-specific code)       |
| **Code Size**              | Smaller bean                        | More code to maintain          |
| **Control**                | Less control over SQL               | Full control over SQL          |
| **Complexity**             | Simpler for developers              | More error-prone               |

## How It Works

### CMP (Container-Managed Persistence)

1. Developer writes entity bean with no persistence logic
2. Using vendor tools, developer defines how fields map to database columns
3. At deployment, container generates the SQL code
4. Container handles all INSERT, UPDATE, DELETE, SELECT automatically

### BMP (Bean-Managed Persistence)

1. Developer writes JDBC code in ejbCreate(), ejbRemove(), finder methods
2. Developer handles all SQL statements manually
3. Container calls the methods but doesn't generate SQL
4. More flexibility but more responsibility

## When to Use

### Use CMP When:

- Simple persistence needs
- Portability across databases is important
- Want to minimize code
- Standard CRUD operations suffice

### Use BMP When:

- Need complex SQL queries
- Require fine-grained control over database operations
- Using legacy or unusual data sources
- Specific database optimizations needed

## Key Insight

CMP is the EJB "magic"—the container does the heavy lifting. BMP gives you the keys to the car. Choose based on your team's expertise and the complexity of your data access needs.

## Connections

- [[container-managed-persistence|Container-Managed Persistence]]
- [[bean-managed-persistence|Bean-Managed Persistence]]
- [[entity-bean|Entity Bean]]
- [[object-relational-mapping|Object-Relational Mapping]]
