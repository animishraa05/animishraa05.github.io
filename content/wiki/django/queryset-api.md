---
concept: QuerySet API
aliases: [QuerySet, Django ORM Queries, django.db.models.QuerySet]
tags: [dev, django]
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

A QuerySet is a lazy, chainable collection of database queries represented by `django.db.models.QuerySet`, providing methods for filtering (`filter`, `exclude`), ordering (`order_by`), slicing, aggregation (`aggregate`, `annotate`), and relationship traversal (`select_related`, `prefetch_related`) that only executes SQL when evaluated.

## Explanation

The QuerySet API solves the problem of building complex database queries programmatically without writing raw SQL. It uses lazy evaluation — chaining `.filter().exclude().order_by()` builds an internal query plan but executes no SQL until iteration, `list()`, `len()`, `bool()`, or explicit `.all()`. This allows dynamic query composition based on runtime conditions while deferring expensive database round-trips.

## How It Works

1. **Manager access** — `Model.objects` returns a `Manager` with base `QuerySet`
2. **Chaining filters** — Each method returns new `QuerySet` with modified `query` attribute
3. **Query compilation** — On evaluation, `QuerySet.query` compiles to SQL via `SQLCompiler`
4. **SQL execution** — Database cursor executes; rows fetched
5. **Result hydration** — Rows converted to model instances (or dicts/values_list tuples)
6. **Caching** — Evaluated QuerySet caches results; re-iteration uses cache

## Visual Explanation

```dot
digraph queryset_api {
  rankdir=LR;
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=10];

  Manager [label="Post.objects\n→ Manager"];
  BaseQS [label="QuerySet\n(query=SELECT * FROM post)"];
  Filtered [label=".filter(published=True)\n→ QuerySet (WHERE published=1)"];
  Annotated [label=".annotate(comment_count=Count('comments'))\n→ QuerySet (GROUP BY)"];
  Ordered [label=".order_by('-created')\n→ QuerySet (ORDER BY)"];
  Evaluated [label="list(qs) or for p in qs\n→ SQL EXECUTED" fillcolor="#d4edda"];
  Results [label="[Post, Post, ...]\nCached in qs._result_cache"];

  Manager -> BaseQS [label="1. Base queryset"];
  BaseQS -> Filtered [label="2. Chain filter"];
  Filtered -> Annotated [label="3. Chain annotate"];
  Annotated -> Ordered [label="4. Chain order_by"];
  Ordered -> Evaluated [label="5. Evaluate (lazy)"];
  Evaluated -> Results [label="6. Hydrate & cache"];
}
```

## Semantic Network

```dot
graph semantic_queryset_api {
  layout=neato;
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled];
  edge [fontname="Helvetica" fontsize=9];

  THIS [label="QuerySet\nAPI" fillcolor="#ffd700" fontsize=13 style="filled,bold"];

  PRE1 [label="Models /\nORM" fillcolor="#cce5ff"];
  PRE2 [label="Model\nManagers" fillcolor="#cce5ff"];
  PRE3 [label="Field\nLookups" fillcolor="#cce5ff"];

  OUT1 [label="Filtering /\nExclusion" fillcolor="#d4edda"];
  OUT2 [label="Aggregation /\nAnnotation" fillcolor="#d4edda"];
  OUT3 [label="Relationship\nOptimization" fillcolor="#d4edda"];
  OUT4 [label="Bulk\nOperations" fillcolor="#d4edda"];
  OUT5 [label="Raw SQL\nEscape Hatch" fillcolor="#d4edda"];

  CON1 [label="SQLAlchemy\nQuery API" fillcolor="#ffe5cc"];
  CON2 [label="Raw\npsycopg2" fillcolor="#ffe5cc"];

  REL1 [label="Transactions\n(atomic)" fillcolor="#f0f0f0"];
  REL2 [label="Pagination\n(Paginator)" fillcolor="#f0f0f0"];

  THIS -- PRE1 [label="built from" style=dashed];
  THIS -- PRE2 [label="built from" style=dashed];
  THIS -- PRE3 [label="built from" style=dashed];
  THIS -- OUT1 [label="builds into"];
  THIS -- OUT2 [label="builds into"];
  THIS -- OUT3 [label="builds into"];
  THIS -- OUT4 [label="builds into"];
  THIS -- OUT5 [label="builds into"];
  THIS -- CON1 [label="contrasts with" style=dotted];
  THIS -- CON2 [label="contrasts with" style=dotted];
  THIS -- REL1 [label="related"];
  THIS -- REL2 [label="related"];
}
```

## Key Properties

- **Laziness**: No SQL until evaluation; `qs = Post.objects.all()` hits DB zero times
- **Immutability**: Each method returns new QuerySet; original unchanged
- **Caching**: First evaluation populates `_result_cache`; subsequent use cached
- **Field lookups**: `field__lookup` syntax — `exact`, `iexact`, `contains`, `icontains`, `gt`, `gte`, `lt`, `lte`, `in`, `startswith`, `endswith`, `range`, `date`, `year`, `month`, `day`, `isnull`, `regex`
- **Optimization**: `select_related` (FK, O2O → JOIN), `prefetch_related` (M2M, reverse FK → separate query + Python join)

## Connections

- Built from: [[models-orm|Models/ORM]] — QuerySet operates on model tables
- Built from: [[model-managers|Model Managers]] — Entry point via `Model.objects`
- Built from: [[field-lookups|Field Lookups]] — `__` syntax for filters
- Builds into: [[filtering-exclusion|Filtering/Exclusion]] — `filter()`, `exclude()`, `Q()` objects
- Builds into: [[aggregation-annotation|Aggregation/Annotation]] — `aggregate()`, `annotate()`, `Count`, `Sum`, `Avg`
- Builds into: [[relationship-optimization|Relationship Optimization]] — `select_related`, `prefetch_related`
- Builds into: [[bulk-operations|Bulk Operations]] — `bulk_create`, `bulk_update`, `update()`, `delete()`
- Contrasts with: [[sqlalchemy-query|SQLAlchemy Query]] — Explicit session, more flexible joins
- Contrasts with: [[raw-sql|Raw SQL]] — Full control, no ORM overhead
- Related: [[database-transactions|Transactions]] — `atomic()` for multi-query atomicity
- Related: [[pagination|Pagination]] — `Paginator` slices QuerySet for pages

## Edge Cases & Gotchas

- **QuerySet cloning**: `qs.filter(...)` returns new QuerySet; modifying `qs` in place doesn't work
- **Slicing evaluates**: `qs[:10]` executes SQL with `LIMIT`; `qs[5:10]` uses `OFFSET`/`LIMIT`
- **`len(qs)` vs `qs.count()`**: `len()` evaluates and caches; `count()` always does `SELECT COUNT(*)`
- **`exists()` vs `bool(qs)`**: `exists()` does `SELECT 1 ... LIMIT 1`; `bool()` evaluates full QuerySet
- **M2M `filter()` vs `exclude()`**: `Post.objects.filter(tags__name='django')` vs `exclude(tags__name='django')` — `exclude` matches posts with NO matching tags, not posts where ALL tags don't match