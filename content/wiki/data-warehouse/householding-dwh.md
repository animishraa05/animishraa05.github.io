---
concept: Householding DWH
aliases: [householding, household grouping, address-based deduplication]
tags: [database, data-warehouse]
created: 2026-05-04
updated: 2026-05-04
---

## The Problem

A company sends marketing catalogues to every customer individually, unaware that five customers live at the same address (a single household). This wastes resources — five catalogues are printed and mailed when one would suffice. For a company sending 1 million catalogues at Rs. 50 each (Rs. 50 million total), even a 2% reduction through householding saves Rs. 1 million. Without identifying households, the company wastes money on redundant communications.

## Core Idea

**Householding** is the process of identifying all members of a household (people living at the same address) and grouping them together to enable household-level decisions rather than individual-level decisions. It eliminates redundant communications, reduces marketing costs, and enables household-level analysis (e.g., "total household spending").

## How It Works

Householding operates during the ETL transformation phase:

1. **Address normalization:** Standardize addresses across all source records — consistent formatting, spelling, ZIP code validation. This is essential because "123 Main St." and "123 Main Street, Apt 4B" must be recognized as the same address.
2. **Household identification:** Group records that share the same normalized address into household clusters. Fuzzy matching handles minor variations (typos, abbreviations).
3. **Household ID assignment:** Assign a unique household identifier to all members of each cluster.
4. **Household-level aggregation:** Compute household-level metrics — total household income, combined purchase history, household size.
5. **Deduplication of communications:** When generating marketing mailings, send one per household instead of one per individual.

**Cost savings example:** 1 million catalogues at Rs. 50 each = Rs. 50 million. A 2% reduction through householding eliminates 20,000 unnecessary mailings, saving Rs. 1 million.

## Visual Explanation

```dot
digraph householding {
  rankdir=TB
  node [shape=box style=filled fontname="Helvetica" fontsize=11]
  edge [fontname="Helvetica" fontsize=10]

  subgraph cluster_individuals {
    label="Before Householding (Individual)"
    style=dashed
    c1 [label="John — 123 Main St" fillcolor="#f8d7da"]
    c2 [label="Jane — 123 Main St" fillcolor="#f8d7da"]
    c3 [label="Bob — 123 Main St" fillcolor="#f8d7da"]
    c4 [label="Alice — 456 Oak Ave" fillcolor="#f8d7da"]
  }

  household [label="Household Identification\nAddress Normalization\nFuzzy Matching" fillcolor="#fff3cd" shape=diamond]

  subgraph cluster_households {
    label="After Householding (Household)"
    style=dashed
    h1 [label="HH-001: John, Jane, Bob\n(123 Main St)\n→ 1 mailing" fillcolor="#d4edda"]
    h2 [label="HH-002: Alice\n(456 Oak Ave)\n→ 1 mailing" fillcolor="#d4edda"]
  }

  {c1 c2 c3} -> h1 [label="group"]
  c4 -> h2 [label="group"]
}
```

## Semantic Network

```dot
graph semantic_householding {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="Householding\nDWH" fillcolor="#ffd700" fontsize=13 style="filled,bold"]

  ETL [label="ETL Pipeline\n(DWH)" fillcolor="#cce5ff"]
  SCRUB [label="Data Scrubbing" fillcolor="#cce5ff"]
  INTEGRATED [label="Integrated DWH" fillcolor="#cce5ff"]
  METADATA [label="Metadata in DWH" fillcolor="#d4edda"]
  LOAD [label="Loading (DWH)" fillcolor="#d4edda"]

  THIS -- ETL [label="built from"]
  THIS -- SCRUB [label="built from"]
  THIS -- INTEGRATED [label="related"]
  THIS -- METADATA [label="related"]
  THIS -- LOAD [label="builds into"]
}
```

## Key Properties

- **Address-based grouping:** Identifies households by matching normalized addresses
- **Cost reduction:** Eliminates redundant communications, saving significant marketing expenses
- **Household-level analysis:** Enables analysis at household granularity (total household spending, household size)
- **Fuzzy matching required:** Handles address variations, typos, and abbreviations
- **Direct financial impact:** Measurable ROI — savings can be calculated precisely

## Connections

- **Built from:** [[etl-pipeline-dwh|ETL Pipeline (DWH)]] — householding is part of the Transform phase
- **Built from:** [[data-scrubbing|Data Scrubbing]] — address normalization is a scrubbing technique
- **Related:** [[integrated-dwh|Integrated DWH]] — householding requires integration across sources
- **Builds into:** [[loading-dwh|Loading (DWH)]] — household IDs are loaded as new attributes
- **Related:** [[metadata-in-dwh|Metadata in DWH]] — householding rules and mappings stored in metadata

## Edge Cases & Gotchas

- **Multi-unit addresses:** Apartments, shared offices, and dormitories complicate household identification — same building, different households.
- **Address changes:** When a household moves, the system must recognize the new address as the same household.
- **Privacy concerns:** Grouping individuals by address may raise privacy issues, especially in regulated industries.
- **False matches:** Fuzzy matching can incorrectly group unrelated people at similar addresses (e.g., "123 Main St" vs "123 Main St NE").