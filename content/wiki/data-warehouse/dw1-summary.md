---
source: Data Warehouse — Definitions, Architecture, ETL, OLAP
source_path: sources/dw1.md
ingested: 2026-05-04
concepts_count: 40
---

## What This Source Is

A comprehensive Gemini conversation covering the full spectrum of Data Warehousing fundamentals. The source includes textbook definitions (Inmon's four characteristics, Devin's definition), OLTP vs. OLAP comparison with a 16-point memory formula, three-tier architecture, complete ETL pipeline details (extraction, scrubbing, enrichment, conditioning, scoring, householding, loading, refresh), DWH server models (Enterprise, Data Marts, Virtual), data mart types (Dependent, Independent, Hybrid), dimensional schemas (Star, Snowflake, Galaxy/Fact Constellation), multidimensional data model and data cubes, all five OLAP operations (roll-up, drill-down, slice, dice, pivot), four OLAP server types (ROLAP, MOLAP, HOLAP, Specialized SQL), and comprehensive metadata coverage (categories, repository, management challenges).

## Concepts Extracted

**Created (40 pages in `wiki/dw1/`):**

- [[data-warehouse-definition|Data Warehouse Definition]] — Inmon's 4 characteristics, Devin's definition
- [[subject-oriented-dwh|Subject-Oriented DWH]] — organizing data around business subjects
- [[integrated-dwh|Integrated DWH]] — resolving format inconsistencies across sources
- [[time-variant-dwh|Time-Variant DWH]] — historical perspective with time elements
- [[nonvolatile-dwh|Nonvolatile DWH]] — read-only after load, no in-place updates
- [[oltp-vs-olap|OLTP vs OLAP]] — 5-dimension comparison of transaction vs analytical processing
- [[three-tier-dwh-architecture|Three-Tier DWH Architecture]] — bottom (storage), middle (OLAP), top (presentation)
- [[dwh-gateway|DWH Gateway]] — ODBC, JDBC, OLE-DB for uniform source access
- [[etl-pipeline-dwh|ETL Pipeline (DWH)]] — four-phase backend process
- [[data-extraction|Data Extraction]] — gathering raw data from five source categories
- [[data-scrubbing|Data Scrubbing]] — standardizing values, units, names, entities
- [[enrichment-dwh|Enrichment]] — augmenting data with external sources
- [[conditioning-dwh|Conditioning]] — converting data types to warehouse standards
- [[scoring-dwh|Scoring]] — computing probability scores for events
- [[householding-dwh|Householding]] — grouping by address to reduce marketing costs
- [[loading-dwh|Loading (DWH)]] — batch load with checkpoint support
- [[dwh-refresh|DWH Refresh]] — data shipping vs. transaction shipping
- [[dwh-server-models|DWH Server Models]] — Enterprise, Tiered, Virtual architectures
- [[data-mart-types|Data Mart Types]] — Dependent, Independent, Hybrid
- [[star-schema|Star Schema]] — denormalized, one fact table, many dimensions
- [[snowflake-schema|Snowflake Schema]] — normalized dimensions, branching structure
- [[fact-constellation-schema|Fact Constellation Schema]] — multiple fact tables with shared dimensions
- [[multidimensional-data-model|Multidimensional Data Model]] — data cubes, facts and dimensions
- [[fact-table|Fact Table]] — central table with measures and foreign keys
- [[dimension-table|Dimension Table]] — descriptive attributes providing context
- [[olap-operations|OLAP Operations]] — roll-up, drill-down, slice, dice, pivot
- [[olap-servers|OLAP Servers]] — ROLAP, MOLAP, HOLAP, Specialized SQL
- [[rolap-server|ROLAP Server]] — relational storage, dynamic SQL
- [[molap-server|MOLAP Server]] — pre-computed cubes, MDDB storage
- [[holap-server|HOLAP Server]] — hybrid: ROLAP detail + MOLAP aggregations
- [[metadata-in-dwh|Metadata in DWH]] — business, technical, operational categories
- [[metadata-repository|Metadata Repository]] — six-component centralized storage
- [[metadata-management-challenges|Metadata Management Challenges]] — scattered data, no standards
- [[dwh-application-areas|DWH Application Areas]] — seven industry use cases
- [[dwh-benefits|DWH Benefits]] — seven analytical and operational advantages
- [[dwh-scale|DWH Scale]] — terabytes to zettabytes hierarchy
- [[dwh-evolution|DWH Evolution]] — 60s batch to 90s warehouse + OLAP

**Syntheses created (3):**

- [[schema-comparison|Star vs Snowflake vs Galaxy]] — schema architecture tradeoffs
- [[olap-server-comparison|ROLAP vs MOLAP vs HOLAP]] — server architecture tradeoffs
- [[inmon-vs-kimball|Inmon vs Kimball]] — top-down vs bottom-up approach

## Key Takeaways

- **Inmon's 4 characteristics** (subject-oriented, integrated, time-variant, nonvolatile) are the defining features that separate a data warehouse from any other database
- **OLTP vs OLAP** is the fundamental split: OLTP runs the business (fast, current, ER model), OLAP analyzes the business (historical, star schema, read-only)
- **ETL is the engine** — without proper scrubbing, enrichment, and transformation, the warehouse produces unreliable analysis (garbage in, garbage out)
- **Schema choice is a spectrum** — star (fast) → snowflake (efficient) → galaxy (expressive) — not a binary decision
- **ROLAP vs MOLAP** is about computation timing: compute at query time (flexible but slow) vs. compute at load time (fast but rigid)
- **Metadata is the roadmap** — without it, a warehouse is an unreadable data swamp
- **Data mart approach** reflects organizational maturity: start with Kimball (fast wins), evolve toward Inmon (consistency)

## Open Questions

- How do modern columnar databases (Redshift, BigQuery, Snowflake) fit into the ROLAP/MOLAP/HOLAP classification?
- What are the real-world performance differences between Data Shipping and Transaction Shipping at petabyte scale?
- How do cloud-native data warehouses handle the ETL refresh cycle differently from on-premise systems?
- What is the role of data lakes vs. data warehouses in modern data architecture?
- How do slowly changing dimensions (SCD Types 1-7) interact with the nonvolatile characteristic?

## Connections

- [[data-warehouse-definition|Data Warehouse Definition]] — central concept from this source
- [[star-schema|Star Schema]] — Kimball's dimensional modeling
- [[oltp-vs-olap|OLTP vs OLAP]] — fundamental paradigm distinction
- [[etl-pipeline-dwh|ETL Pipeline (DWH)]] — backend process for populating the warehouse
- [[olap-servers|OLAP Servers]] — middle-tier analytical engines
