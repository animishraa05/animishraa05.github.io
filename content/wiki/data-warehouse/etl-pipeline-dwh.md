---
concept: ETL Pipeline DWH
aliases: [ETL pipeline DWH, extract transform load warehouse, DWH backend process]
tags: [database, data-warehouse]
sources_count: 1
last_source: dw1.md
created: 2026-05-04
updated: 2026-05-04
---

## The Problem

Raw operational data from multiple heterogeneous sources is inconsistent, incomplete, and formatted differently across systems. Loading this "dirty" data directly into the warehouse would produce unreliable analysis results — garbage in, garbage out. The warehouse needs a systematic pipeline that extracts data from sources, cleans and standardizes it, transforms it into a uniform structure, and loads it reliably into the warehouse.

## Core Idea

The **ETL (Extract, Transform, Load) pipeline** is the four-phase backend process that populates and refreshes a data warehouse. **Extract** gathers raw data from heterogeneous sources. **Transform** cleans, standardizes, enriches, and restructures the data. **Load** inserts the cleaned data into the warehouse. **Refresh** propagates ongoing source updates to keep the warehouse current.

## How It Works

### Phase 1: Data Extraction
- Gathers data from multiple heterogeneous sources: production databases, legacy systems, internal office systems, external systems, and metadata.
- Data is captured in its **"as is"** (raw) state — no modifications at this stage.
- Uses **gateways** (ODBC, JDBC, OLE-DB) to connect to diverse source systems.

### Phase 2: Data Cleaning and Transformation
This is the heaviest phase, involving multiple sub-processes:
- **Data scrubbing:** Standardizes values (encoding, units, attribute names, name resolution).
- **Enrichment:** Augments operational data with external sources (e.g., survey reports).
- **Conditioning:** Converts source data types to target warehouse data types.
- **Scoring:** Computes probabilities (e.g., customer purchase likelihood).
- **Householding:** Groups records by shared attributes (e.g., same address) to eliminate redundancy.

### Phase 3: Loading
- Inserts cleaned data into the warehouse.
- Checks integrity constraints, sorts, and summarizes data.
- Uses **batch load utilities** with **checkpoint** support — if a load fails, it resumes from the last checkpoint rather than restarting.
- Must handle very large data volumes; sequential loads can take hours.

### Phase 4: Refresh
- Propagates source updates to the warehouse.
- Two techniques: **Data Shipping** (remote snapshots with after-row triggers) and **Transaction Shipping** (transaction log scanning and replication).

## Visual Explanation

```dot
digraph etl_pipeline {
  rankdir=LR
  node [shape=box style=filled fontname="Helvetica" fontsize=11]
  edge [fontname="Helvetica" fontsize=10]

  sources [label="Heterogeneous\nSources" fillcolor="#e8e8e8"]
  extract [label="Extract\nRaw \"as is\" Data" fillcolor="#f8d7da"]
  clean [label="Clean & Transform\nScrubbing, Enrichment\nConditioning, Scoring" fillcolor="#fff3cd"]
  load [label="Load\nBatch Insert\nIntegrity Checks\nCheckpoints" fillcolor="#d4edda"]
  warehouse [label="Data Warehouse" fillcolor="#cce5ff" shape=box3d]
  refresh [label="Refresh\nData Shipping\nTransaction Shipping" fillcolor="#ffe5cc"]

  sources -> extract -> clean -> load -> warehouse
  sources -> refresh -> warehouse [style=dashed]
}
```

## Semantic Network

```dot
graph semantic_etl_pipeline {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="ETL Pipeline\nDWH" fillcolor="#ffd700" fontsize=13 style="filled,bold"]

  INTEGRATED [label="Integrated DWH" fillcolor="#cce5ff"]
  GATEWAY [label="DWH Gateway" fillcolor="#cce5ff"]
  SCRUB [label="Data Scrubbing" fillcolor="#cce5ff"]
  REFRESH [label="DWH Refresh" fillcolor="#d4edda"]
  THREE_TIER [label="Three-Tier DWH\nArchitecture" fillcolor="#d4edda"]
  DWH_DEF [label="Data Warehouse\nDefinition" fillcolor="#d4edda"]

  THIS -- INTEGRATED [label="built from"]
  THIS -- GATEWAY [label="built from"]
  THIS -- SCRUB [label="builds into"]
  THIS -- REFRESH [label="builds into"]
  THIS -- THREE_TIER [label="builds into"]
  THIS -- DWH_DEF [label="builds into"]
}
```

## Key Properties

- **Four phases:** Extract, Transform, Load, Refresh — each with distinct responsibilities
- **Batch-oriented:** Loading happens in batches, not row-by-row, for performance
- **Checkpoint support:** Failed loads resume from the last checkpoint, not from scratch
- **Data quality critical:** Scrubbing and transformation determine the warehouse's analytical accuracy
- **Resource intensive:** Transformation and scrubbing are CPU/memory intensive operations

## Connections

- **Built from:** [[integrated-dwh|Integrated DWH]] — ETL implements the integration characteristic
- **Built from:** [[dwh-gateway|DWH Gateway]] — gateways provide the extraction mechanism
- **Builds into:** [[data-scrubbing|Data Scrubbing]] — scrubbing is a core transformation sub-process
- **Builds into:** [[dwh-refresh|DWH Refresh]] — refresh is the fourth phase of ETL
- **Builds into:** [[three-tier-dwh-architecture|Three-Tier DWH Architecture]] — ETL feeds Tier 1
- **Related:** [[data-warehouse-definition|Data Warehouse Definition]] — ETL enables all four Inmon characteristics

## Edge Cases & Gotchas

- **Garbage In, Garbage Out:** Poor scrubbing produces unreliable analysis. The transformation phase is where most ETL failures occur.
- **Full load vs. incremental:** Full loads rebuild the entire warehouse (slow but safe); incremental loads only process changes (fast but complex to implement correctly).
- **Load failure recovery:** Without checkpoints, a 10-hour load that fails at hour 9.5 must restart completely.
- **Schema evolution:** When source systems change their schema, ETL pipelines must be updated — this is a common maintenance burden.

## Sources

- [[dw1-summary|Source: Data Warehouse — Definitions, Architecture, ETL, OLAP]] — ETL four phases, backend process details
