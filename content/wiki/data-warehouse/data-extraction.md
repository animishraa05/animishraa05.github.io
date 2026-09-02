---
concept: Data Extraction DWH
aliases: [data extraction, extracting data from sources, DWH extraction phase]
tags: [database, data-warehouse]
created: 2026-05-04
updated: 2026-05-04
---

## The Problem

A company's data is scattered across production databases, legacy mainframe systems, internal office tools, external consultant reports, and metadata repositories. Each source has its own format, access protocol, and data model. Before any analysis can happen, this scattered data must be gathered and brought into a single pipeline for processing.

## Core Idea

**Data extraction** is the first phase of the ETL pipeline. It involves gathering raw data from multiple heterogeneous sources — production databases, legacy systems, internal office systems, external systems, and metadata — and capturing it in its **"as is"** state without any modification. Extraction is the foundation upon which all subsequent cleaning, transformation, and loading depend.

## How It Works

The extraction process targets five categories of data sources:

1. **Production databases:** The live operational systems (OLTP) where daily business transactions are recorded — sales records, customer registrations, inventory updates.
2. **Legacy data:** Older systems that may use outdated formats or protocols but still contain valuable historical data. These often require specialized gateways or adapters.
3. **Internal office systems:** Department-level systems like HR databases, project management tools, and internal reporting systems.
4. **External systems:** Data from outside the organization — market research reports, demographic data, partner data, consultant-provided profiles.
5. **Metadata:** Data about the structure, origin, and meaning of the other data sources — schema definitions, data dictionaries, and transformation rules.

Extraction uses **gateways** (ODBC, JDBC, OLE-DB) to establish connections to each source and pull data through standardized API calls. The extracted data is captured without modification — it is the raw input that will be cleaned and transformed in the next ETL phase.

## Visual Explanation

```dot
digraph data_extraction {
  rankdir=TB
  node [shape=box style=filled fontname="Helvetica" fontsize=11]
  edge [fontname="Helvetica" fontsize=10]

  subgraph cluster_sources {
    label="Heterogeneous Sources"
    style=dashed
    prod [label="Production\nDatabases" fillcolor="#f8d7da"]
    legacy [label="Legacy\nSystems" fillcolor="#f8d7da"]
    office [label="Internal Office\nSystems" fillcolor="#f8d7da"]
    external [label="External\nSystems" fillcolor="#f8d7da"]
    meta [label="Metadata\nRepositories" fillcolor="#f8d7da"]
  }

  gateway [label="Gateway APIs\n(ODBC, JDBC, OLE-DB)" fillcolor="#fff3cd"]
  extracted [label="Extracted Data\n(\"As Is\" State)" fillcolor="#d4edda"]
  next [label="→ Data Cleaning\n& Transformation" fillcolor="#cce5ff"]

  prod -> gateway
  legacy -> gateway
  office -> gateway
  external -> gateway
  meta -> gateway
  gateway -> extracted -> next
}
```

## Semantic Network

```dot
graph semantic_extraction {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Data Extraction\nDWH" fillcolor="#ffd700" fontsize=13 style="filled,bold"]

  ETL [label="ETL Pipeline\n(DWH)" fillcolor="#cce5ff"]
  GATEWAY [label="DWH Gateway" fillcolor="#cce5ff"]
  SCRUB [label="Data Scrubbing" fillcolor="#d4edda"]
  INTEGRATED [label="Integrated DWH" fillcolor="#cce5ff"]
  THREE_TIER [label="Three-Tier DWH\nArchitecture" fillcolor="#d4edda"]

  THIS -- ETL [label="built from"]
  THIS -- GATEWAY [label="built from"]
  THIS -- SCRUB [label="builds into"]
  THIS -- INTEGRATED [label="related"]
  THIS -- THREE_TIER [label="builds into"]
}
```

## Key Properties

- **"As is" capture:** Data is extracted without modification — cleaning happens in the next phase
- **Five source categories:** Production, legacy, office, external, metadata
- **Gateway-dependent:** Uses ODBC, JDBC, OLE-DB for uniform access to heterogeneous sources
- **First ETL phase:** Foundation of the entire pipeline — garbage extraction produces garbage analysis
- **Volume awareness:** Must handle large data volumes efficiently to avoid impacting source systems

## Connections

- **Built from:** [[etl-pipeline-dwh|ETL Pipeline (DWH)]] — extraction is the first phase
- **Built from:** [[dwh-gateway|DWH Gateway]] — gateways provide the technical extraction mechanism
- **Builds into:** [[data-scrubbing|Data Scrubbing]] — extracted data flows into scrubbing
- **Related:** [[integrated-dwh|Integrated DWH]] — extraction gathers the heterogeneous data that integration unifies
- **Builds into:** [[three-tier-dwh-architecture|Three-Tier DWH Architecture]] — extraction feeds data into Tier 1

## Edge Cases & Gotchas

- **Extraction impact on source systems:** Heavy extraction queries can slow down live production systems. Extraction should be scheduled during off-peak hours or use read replicas.
- **Incremental vs. full extraction:** Full extraction pulls everything each time (slow, safe); incremental extraction only pulls changes since last run (fast, complex to implement).
- **Legacy system access:** Old systems may lack modern APIs, requiring custom connectors or screen-scraping techniques.
- **Partial extraction:** If a source is unavailable during extraction, the warehouse will have incomplete data for that cycle.