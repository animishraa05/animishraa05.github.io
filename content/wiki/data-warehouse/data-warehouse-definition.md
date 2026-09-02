---
concept: Data Warehouse Definition
aliases: [data warehouse, DWH, data warehousing, Inmon definition]
tags: [database, data-warehouse]
created: 2026-05-04
updated: 2026-05-04
---

## The Problem

Transactional databases (**OLTP**) are optimized for fast row-level operations — inserts, updates, deletes — on current data. When management needs to analyze 5-10 years of historical data across multiple departments, running complex aggregation queries directly on production databases degrades performance and competes with live customer traffic.

## Core Idea

A data warehouse is a **subject-oriented, integrated, time-variant, and nonvolatile** collection of data designed to support management's decision-making process. Coined by W.H. Inmon (1993), this definition establishes the four pillars that distinguish a warehouse from any ordinary database. It centralizes data from heterogeneous sources into a single, consistent store optimized for analytical queries rather than transaction processing.

## How It Works

The four characteristics defined by Inmon work together as a system:

1. **Subject-Oriented:** Data is organized around major business subjects (Customer, Product, Sales) rather than around specific applications (Invoicing app, Shipping app). The focus shifts from "how data is processed" to "what data means for decision makers."
2. **Integrated:** Data from multiple heterogeneous sources (relational databases, flat files, ERP systems, external APIs) is extracted, cleaned, and converted into a consistent format before entering the warehouse. Date formats, naming conventions, and units of measure are standardized.
3. **Time-Variant:** Every record in the warehouse carries an explicit or implicit time element. The warehouse stores historical snapshots (typically 5-10 years), enabling trend analysis, year-over-year comparisons, and temporal pattern recognition.
4. **Nonvolatile:** Once data enters the warehouse, it is never updated or deleted in place. The only operations are **initial loading** and **querying (read access)**. This physical separation from the operational environment eliminates the need for transaction processing, recovery, and concurrency control mechanisms.

Barry Devin's complementary definition emphasizes that a warehouse is a "single, complete and consistent store of data obtained from a variety of different sources made available to end users in a way they can understand and use in business context."

## Visual Explanation

```dot
digraph data_warehouse_definition {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=11]
  edge [fontname="Helvetica" fontsize=10]

  sources [label="Heterogeneous\nSources\n(RDBMS, Files, ERP)" fillcolor="#e8e8e8"]
  integrate [label="Integration\nClean & Standardize" fillcolor="#fff3cd"]
  warehouse [label="Data Warehouse\nSubject-Oriented\nTime-Variant\nNonvolatile" fillcolor="#ffd700" fontsize=12 shape=box3d]
  users [label="Decision Makers\nManagers, Analysts\n(Query Only)" fillcolor="#d4edda"]

  sources -> integrate [label="Extract"]
  integrate -> warehouse [label="Transform & Load"]
  warehouse -> users [label="Read-Only Access"]
}
```

## Semantic Network

```dot
graph semantic_data_warehouse_definition {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Data Warehouse\nDefinition" fillcolor="#ffd700" fontsize=13 style="filled,bold"]

  OLTP [label="OLTP Systems" fillcolor="#cce5ff"]
  INMON [label="Inmon 4 Characteristics" fillcolor="#cce5ff"]
  ETL [label="ETL Pipeline" fillcolor="#cce5ff"]
  OLAP [label="OLAP Systems" fillcolor="#d4edda"]
  DWH_ARCH [label="DWH Architecture" fillcolor="#d4edda"]
  SCHEMA [label="DWH Schemas" fillcolor="#d4edda"]

  THIS -- OLTP  [label="contrasts with" style=dotted]
  THIS -- INMON [label="built from"]
  THIS -- ETL   [label="built from"]
  THIS -- OLAP  [label="builds into"]
  THIS -- DWH_ARCH [label="builds into"]
  THIS -- SCHEMA   [label="builds into"]
}
```

## Key Properties

- **Decision support focus:** Built for analysis and business intelligence, not daily operations
- **Single source of truth:** Integrates scattered data into one consistent repository
- **Historical depth:** Stores 5-10 years of data vs. OLTP's current-state focus
- **Read-optimized:** No UPDATE/DELETE after loading; only SELECT queries
- **Scale:** Ranges from terabytes ($10^{12}$ bytes) to zettabytes ($10^{21}$ bytes)
- **No concurrency control:** Nonvolatility removes need for locking/rollback mechanisms

## Connections

- **Built from:** [[subject-oriented-dwh|Subject-Oriented]] — first pillar of Inmon's definition
- **Built from:** [[integrated-dwh|Integrated]] — second pillar of Inmon's definition
- **Built from:** [[time-variant-dwh|Time-Variant]] — third pillar of Inmon's definition
- **Built from:** [[nonvolatile-dwh|Nonvolatile]] — fourth pillar of Inmon's definition
- **Contrasts with:** [[oltp-vs-olap|OLTP vs OLAP]] — warehouse is OLAP, not OLTP
- **Builds into:** [[three-tier-dwh-architecture|Three-Tier DWH Architecture]] — physical implementation of the definition
- **Related:** [[dwh-scale|Data Warehouse Scale]] — the massive size ranges warehouses operate at

## Edge Cases & Gotchas

- **Inmon vs. Kimball:** Inmon advocates top-down (enterprise warehouse first, then data marts); Kimball advocates bottom-up (data marts first, then conformed dimensions). Both definitions are valid but lead to different architectures.
- **"Nonvolatile" is not "immutable":** Data is refreshed periodically — new data is appended, not old data modified.
- **Data warehouse is not a data lake:** Warehouses require structured, cleaned data; lakes accept raw, unstructured data.
- **Misconception:** A warehouse is not just "a big database." The four characteristics (subject-oriented, integrated, time-variant, nonvolatile) are what make it a warehouse.