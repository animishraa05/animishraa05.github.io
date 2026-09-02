---
concept: Snowflake Schema
aliases: [snowflake schema, normalized star schema, normalized dimension]
tags: [database, data-warehouse]
created: 2026-05-04
updated: 2026-05-04
---

## The Problem

In a star schema, dimension tables are fully denormalized, leading to significant data redundancy. If a location dimension has 10,000 cities across 50 states and 10 countries, the "state" and "country" names are repeated thousands of times. This wastes storage space and can make dimension tables unwieldy. In some cases, this redundancy creates maintenance problems when attribute values need to be corrected.

## Core Idea

**Snowflake Schema** is an extension of the star schema where large dimension tables are **normalized** — split into additional tables to eliminate redundancy. The normalized dimensions branch out like a snowflake, creating a more complex but storage-efficient structure.

## How It Works

The snowflake schema takes the star schema's denormalized dimensions and normalizes them:

1. **Identify redundant attributes:** In the star schema's location dimension, "province_or_state" and "country" are repeated for every city in that state/country.
2. **Split into additional tables:**
   - The `location` dimension table is split: cities stay in the location table, but states move to a new `state` table, and countries to a `country` table.
   - The `item` dimension table is split: items stay in the item table, but suppliers move to a new `supplier` table.
3. **Establish hierarchical joins:** The fact table joins to the top-level dimension table, which joins to the next-level normalized table, and so on.
4. **Query impact:** A query that needed 1 join in the star schema may now need 2-3 joins in the snowflake schema.

**Example from source:**
- Star schema: `dim_item` contains `item_key, item_name, type, brand, supplier_type` (redundant supplier info)
- Snowflake schema: `dim_item` contains `item_key, item_name, type, brand, supplier_key` → joins to `dim_supplier` with `supplier_key, supplier_type`

## Visual Explanation

```dot
digraph snowflake_schema {
  rankdir=TB
  node [shape=box style=filled fontname="Helvetica" fontsize=11]
  edge [fontname="Helvetica" fontsize=10]

  fact [label="fact_sales" fillcolor="#ffd700" shape=diamond]

  dim_item [label="dim_item\nitem_key, name\nbrand, type\nsupplier_key" fillcolor="#cce5ff"]
  dim_loc [label="dim_location\nlocation_key\nstreet, city" fillcolor="#cce5ff"]

  dim_supplier [label="dim_supplier\nsupplier_key\nsupplier_type" fillcolor="#d4edda"]
  dim_city [label="dim_city\ncity_key\ncity_name" fillcolor="#d4edda"]

  fact -> dim_item [label="item_key"]
  fact -> dim_loc [label="location_key"]
  dim_item -> dim_supplier [label="supplier_key"]
  dim_loc -> dim_city [label="city_key"]
}
```

## Semantic Network

```dot
graph semantic_snowflake {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Snowflake\nSchema" fillcolor="#ffd700" fontsize=13 style="filled,bold"]

  STAR [label="Star Schema" fillcolor="#cce5ff"]
  DIM [label="Dimension Table" fillcolor="#cce5ff"]
  GALAXY [label="Fact Constellation\nSchema" fillcolor="#d4edda"]
  CUBE [label="Multidimensional\nData Model" fillcolor="#d4edda"]
  ROLAP [label="ROLAP Server" fillcolor="#d4edda"]

  THIS -- STAR [label="built from"]
  THIS -- DIM [label="builds into"]
  THIS -- GALAXY [label="related"]
  THIS -- CUBE [label="builds into"]
  THIS -- ROLAP [label="related"]
}
```

## Key Properties

- **Normalized dimensions:** Dimension tables split to eliminate redundancy
- **Storage efficient:** Less disk space needed compared to star schema
- **More joins required:** Queries need more joins, which can slow performance
- **Easier maintenance:** Updating a value (e.g., country name) requires changing only one record
- **Snowflake shape:** Normalized tables branch outward, creating a snowflake-like appearance

## Connections

- **Built from:** [[wiki/data-warehouse/star-schema|Star Schema]] — snowflake is a normalized variant of the star schema
- **Builds into:** [[wiki/data-warehouse/dimension-table|Dimension Table]] — normalized dimensions are still dimension tables
- **Related:** [[fact-constellation-schema|Fact Constellation Schema]] — another schema variant beyond star
- **Builds into:** [[multidimensional-data-model|Multidimensional Data Model]] — snowflake implements the dimensional model
- **Related:** [[rolap-server|ROLAP Server]] — ROLAP works well with snowflake schemas (relational tables)
- **Contrasts with:** [[wiki/data-warehouse/star-schema|Star Schema]] — the defining difference is normalization

## Edge Cases & Gotchas

- **Query performance degradation:** Each additional join in the snowflake adds query execution time. For very large warehouses, the star schema is usually faster.
- **Over-normalization:** Normalizing every dimension attribute creates a complex schema that is hard to understand and maintain. Only normalize large, highly redundant dimensions.
- **When to use snowflake:** Best when storage cost is a significant concern and query performance requirements are moderate.
- **Hybrid approach:** Some dimensions can be normalized (snowflake) while others remain denormalized (star) — a "partially snowflaked" schema.