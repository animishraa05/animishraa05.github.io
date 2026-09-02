---
concept: Fact Constellation Schema
aliases: [fact constellation, galaxy schema, multiple fact tables]
tags: [database, data-warehouse]
created: 2026-05-04
updated: 2026-05-04
---

## The Problem

A single fact table can measure only one business process. But an enterprise needs to analyze multiple processes — sales, shipping, returns, inventory — simultaneously. Each process has its own metrics and may share some dimensions (Time, Item) with others. A single star schema cannot represent this multi-process reality.

## Core Idea

**Fact Constellation Schema** (also called **Galaxy Schema**) has **multiple fact tables** that share common dimension tables. It extends the star schema by allowing several fact tables (e.g., Sales, Shipping) to coexist and share dimensions (e.g., Time, Item, Location), enabling analysis across multiple business processes within a single model.

## How It Works

The galaxy schema involves:

1. **Multiple fact tables:** Each fact table represents a different business process.
   - `fact_sales`: `time_key, item_key, branch_key, location_key, dollars_sold, units_sold`
   - `fact_shipping`: `item_key, time_key, shipper_key, from_location, to_location, dollars_cost, units_shipped`

2. **Shared dimensions:** Some dimensions are common across fact tables.
   - `dim_time`, `dim_item`, `dim_location` are shared between Sales and Shipping.
   - `dim_branch` is specific to Sales.
   - `dim_shipper` is specific to Shipping.

3. **Process-specific dimensions:** Each fact table may have unique dimensions.
   - Sales has `branch_key`; Shipping has `shipper_key`, `from_location`, `to_location`.

4. **Cross-process analysis:** Shared dimensions enable queries that span multiple fact tables — e.g., "Compare sales revenue to shipping cost by item category."

## Visual Explanation

```dot
digraph fact_constellation {
  rankdir=TB
  node [shape=box style=filled fontname="Helvetica" fontsize=11]
  edge [fontname="Helvetica" fontsize=10]

  fact_sales [label="fact_sales\ndollars_sold\nunits_sold" fillcolor="#ffd700" shape=diamond]
  fact_ship [label="fact_shipping\ndollars_cost\nunits_shipped" fillcolor="#ffd700" shape=diamond]

  dim_time [label="dim_time\n(Shared)" fillcolor="#cce5ff"]
  dim_item [label="dim_item\n(Shared)" fillcolor="#cce5ff"]
  dim_loc [label="dim_location\n(Shared)" fillcolor="#cce5ff"]
  dim_branch [label="dim_branch\n(Sales only)" fillcolor="#d4edda"]
  dim_shipper [label="dim_shipper\n(Shipping only)" fillcolor="#d4edda"]

  fact_sales -> dim_time
  fact_sales -> dim_item
  fact_sales -> dim_loc
  fact_sales -> dim_branch

  fact_ship -> dim_time
  fact_ship -> dim_item
  fact_ship -> dim_loc
  fact_ship -> dim_shipper
}
```

## Semantic Network

```dot
graph semantic_constellation {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Fact Constellation\nSchema" fillcolor="#ffd700" fontsize=13 style="filled,bold"]

  STAR [label="Star Schema" fillcolor="#cce5ff"]
  SNOW [label="Snowflake Schema" fillcolor="#cce5ff"]
  FACT [label="Fact Table" fillcolor="#cce5ff"]
  DIM [label="Dimension Table" fillcolor="#cce5ff"]
  CUBE [label="Multidimensional\nData Model" fillcolor="#d4edda"]

  THIS -- STAR [label="built from"]
  THIS -- SNOW [label="related"]
  THIS -- FACT [label="builds into"]
  THIS -- DIM [label="builds into"]
  THIS -- CUBE [label="builds into"]
}
```

## Key Properties

- **Multiple fact tables:** Each represents a different business process
- **Shared dimensions:** Common dimensions (Time, Item, Location) are shared across fact tables
- **Process-specific dimensions:** Some dimensions are unique to individual fact tables
- **Enterprise-scale:** Designed for complex organizations with multiple business processes
- **Cross-process analysis:** Enables analysis spanning multiple business processes

## Connections

- **Built from:** [[star-schema|Star Schema]] — galaxy is an extension with multiple fact tables
- **Related:** [[snowflake-schema|Snowflake Schema]] — both are schema variants beyond the basic star
- **Builds into:** [[fact-table|Fact Table]] — galaxy uses multiple fact tables
- **Builds into:** [[dimension-table|Dimension Table]] — shared dimensions connect all fact tables
- **Builds into:** [[multidimensional-data-model|Multidimensional Data Model]] — galaxy implements the dimensional model at scale
- **Contrasts with:** [[star-schema|Star Schema]] — star has one fact table, galaxy has many

## Edge Cases & Gotchas

- **Complexity:** Managing multiple fact tables with shared and unique dimensions is significantly more complex than a single star schema.
- **Dimension conformance:** Shared dimensions must have consistent definitions across all fact tables. If "Time" means different things in Sales vs. Shipping, cross-process analysis fails.
- **Implementation challenge:** Galaxy schemas are difficult to design and maintain — they are the most complex of the three schema types.
- **When to use:** Only needed for enterprise-level companies with genuinely distinct but related business processes.