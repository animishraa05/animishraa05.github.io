---
source: EJbContinued.md
source_path: sources/EJbContinued.md
content_hash: null
ingested: 2026-04-28
concepts_count: 15
tags: [dev, ejb]
---

## Concepts Extracted

1. **Entity Context** — Interface providing container services and entity identity info
2. **getPrimaryKey()** — Method to retrieve the current entity's primary key (critical for BMP)
3. **Finder Methods** — Methods to locate existing entity records (SELECT operations)
4. **ejbLoad()** — Callback to load entity state from database (SELECT)
5. **ejbStore()** — Callback to persist entity state to database (UPDATE)
6. **ejbCreate()** — Callback to create new entity in database (INSERT)
7. **ejbRemove()** — Callback to delete entity from database (DELETE)
8. **ejbPostCreate()** — Post-creation callback after EJB object is created
9. **ejbHome()** — Global operations on the entity class (not specific instance)
10. **setEntityContext()** — Context initialization when bean is created
11. **unsetEntityContext()** — Cleanup when bean is destroyed
12. **JDBC** — Java Database Connectivity for database access in BMP
13. **Primary Key** — Unique identifier for entity records
14. **Pooled Instance Reuse** — How entity beans are pooled and reused
15. **Cache Inconsistency** — Risk when external systems modify database directly

## Key Takeaways

- Entity beans are pooled and can be reused to represent different data instances
- BMP requires developer to write SQL/JDBC code; CMP generates it automatically
- `getPrimaryKey()` is critical in `ejbLoad()` and `ejbRemove()` to know which data to access
- In `ejbStore()`, no need to call `getPrimaryKey()` because data is already in memory
- Finder methods must begin with `ejbFind` prefix and return primary keys to container
- Home methods operate on the class level, not specific instances

## Connections to Existing Concepts

This source expands on:
- [[bean-managed-persistence|Bean-Managed Persistence]] — adds detailed callback methods
- [[container-managed-persistence|Container-Managed Persistence]] — contrasts with CMP auto-generation
- [[entity-bean|Entity Bean]] — adds lifecycle and persistence details
- [[instance-pooling|Instance Pooling]] — explains how instances are reused
- [[ejb-container|EJB Container]] — discusses container callbacks and context

## Open Questions

- How do transaction attributes affect when ejbLoad/ejbStore are called?
- What are the performance implications of BMP vs CMP?