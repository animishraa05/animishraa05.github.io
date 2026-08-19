---
concept: Metadata Repository
aliases: [metadata repository, DWH metadata repository, warehouse metadata store]
tags: [database, data-warehouse]
sources_count: 1
last_source: dw1.md
created: 2026-05-04
updated: 2026-05-04
---

## The Problem

Metadata — the documentation describing what warehouse data means, where it came from, and how it was transformed — must be stored somewhere accessible to all tools and users that depend on it. If metadata is scattered across spreadsheets, code comments, and individual team members' knowledge, it becomes unusable and unreliable.

## Core Idea

A **metadata repository** is the centralized storage system that is an integral part of the data warehouse. It contains six key types of metadata: warehouse structure definitions, business metadata, operational metadata, source-to-warehouse mapping rules, summarization algorithms, and performance data. It serves as the single authoritative source for all warehouse documentation.

## How It Works

The metadata repository organizes metadata into six components:

1. **Definition of Data Warehouse:**
   - Schema description, views, dimension hierarchies, derived data definitions.
   - Data mart locations and their contents.

2. **Business Metadata:**
   - Data ownership information, business term definitions, changing policies.

3. **Operational Metadata:**
   - Data currency (active, archived, or purged).
   - Data lineage (history of migrations and transformations applied).

4. **Mapping from Operational Environment:**
   - Source databases and their contents.
   - Data extraction, cleaning, and transformation rules and defaults.
   - Data refresh and purging rules.
   - Security: user authorization and access control.

5. **Algorithms for Summarization:**
   - Dimension algorithms, data granularity definitions.
   - Aggregation and summarization rules.
   - Predefined queries and reports.

6. **Performance Data:**
   - Indices and profiles that improve data access and retrieval.
   - Rules for timing and scheduling of refresh, update, and replication cycles.

## Visual Explanation

```dot
digraph metadata_repository {
  rankdir=TB
  node [shape=box style=filled fontname="Helvetica" fontsize=11]
  edge [fontname="Helvetica" fontsize=10]

  repo [label="Metadata Repository" fillcolor="#ffd700" shape=box3d]

  subgraph cluster_contents {
    label="Six Components"
    style=dashed
    c1 [label="1. DWH Structure\nSchema, Views, Hierarchies" fillcolor="#cce5ff"]
    c2 [label="2. Business Metadata\nDefinitions, Ownership" fillcolor="#cce5ff"]
    c3 [label="3. Operational Metadata\nCurrency, Lineage" fillcolor="#cce5ff"]
    c4 [label="4. Source Mapping\nExtraction, Transformation Rules" fillcolor="#cce5ff"]
    c5 [label="5. Summarization\nAlgorithms, Aggregations" fillcolor="#cce5ff"]
    c6 [label="6. Performance Data\nIndices, Scheduling Rules" fillcolor="#cce5ff"]
  }

  repo -> c1
  repo -> c2
  repo -> c3
  repo -> c4
  repo -> c5
  repo -> c6
}
```

## Semantic Network

```dot
graph semantic_metadata_repo {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Metadata\nRepository" fillcolor="#ffd700" fontsize=13 style="filled,bold"]

  METADATA [label="Metadata in DWH" fillcolor="#cce5ff"]
  THREE_TIER [label="Three-Tier DWH\nArchitecture" fillcolor="#cce5ff"]
  ETL [label="ETL Pipeline\n(DWH)" fillcolor="#cce5ff"]
  ROLAP [label="ROLAP Server" fillcolor="#d4edda"]
  CHALLENGES [label="Metadata Management\nChallenges" fillcolor="#d4edda"]

  THIS -- METADATA [label="built from"]
  THIS -- THREE_TIER [label="builds into"]
  THIS -- ETL [label="related"]
  THIS -- ROLAP [label="builds into"]
  THIS -- CHALLENGES [label="related"]
}
```

## Key Properties

- **Six components:** Structure, business, operational, mapping, summarization, performance
- **Centralized:** Single authoritative source for all warehouse metadata
- **Tool-agnostic:** Serves query tools, ETL, reporting, loading, and DSS
- **Integrally linked:** The repository is part of the warehouse system, not external to it
- **Comprehensive:** Covers technical, business, and operational dimensions

## Connections

- **Built from:** [[metadata-in-dwh|Metadata in DWH]] — the repository stores all metadata categories
- **Built from:** [[three-tier-dwh-architecture|Three-Tier DWH Architecture]] — repository resides in Tier 1
- **Builds into:** [[rolap-server|ROLAP Server]] — ROLAP queries the repository for dimension mappings
- **Related:** [[etl-pipeline-dwh|ETL Pipeline (DWH)]] — ETL rules and transformation logic stored in repository
- **Related:** [[metadata-management-challenges|Metadata Management Challenges]] — challenges of maintaining the repository

## Edge Cases & Gotchas

- **Repository becomes stale:** If the warehouse schema changes and the repository is not updated, tools relying on it will break.
- **Access control:** The repository itself needs security — not all users should see all metadata (e.g., ETL transformation rules may be sensitive).
- **Versioning:** When transformation rules change, the repository should track both old and new versions for audit purposes.

## Sources

- [[dw1-summary|Source: Data Warehouse — Definitions, Architecture, ETL, OLAP]] — metadata repository components
