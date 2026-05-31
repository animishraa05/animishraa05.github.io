---
concept: DWH Evolution
aliases: [data warehouse evolution, history of data warehousing, 60s to 90s DWH]
tags: [database, data-warehouse]
sources_count: 1
last_source: dw1.md
created: 2026-05-04
updated: 2026-05-04
---

## The Problem

Data warehousing did not emerge fully formed — it evolved over decades as a response to the growing need for better data analysis tools. Understanding this evolution reveals why modern warehouses have their current architecture and why certain design decisions (subject-oriented, nonvolatile, integrated) were made.

## Core Idea

**Data warehouse evolution** traces the progression from 1960s batch reporting systems through 1990s data warehouses with integrated OLAP engines. Each decade addressed limitations of the previous approach: 60s batch reports were inflexible, 70s terminal-based systems lacked desktop integration, 80s desktop tools could only access operational databases, and 90s warehouses finally integrated historical data with analytical engines.

## How It Works

The evolution unfolded in four major phases:

1. **1960s — Batch Reports:**
   - Data was processed in batch jobs, producing printed reports.
   - **Problems:** Hard to find and analyze information; inflexible and expensive — every new request required reprogramming.
   - **Limitation:** No interactive analysis possible.

2. **1970s — Terminal-based DSS and EIS:**
   - Decision Support Systems (DSS) and Executive Information Systems (EIS) provided interactive terminal access.
   - **Problems:** Still inflexible; not integrated with desktop tools (spreadsheets, word processors).
   - **Limitation:** Users were locked into specific terminal interfaces.

3. **1980s — Desktop Data Access and Analysis Tools:**
   - Query tools, spreadsheets, and GUIs made analysis accessible on personal computers.
   - **Problems:** Easier to use, but could only access operational databases (not historical data).
   - **Limitation:** Analyzing production data degraded operational performance.

4. **1990s — Data Warehousing with Integrated OLAP:**
   - The modern era: dedicated warehouses with integrated OLAP engines and tools.
   - **Solution:** Separate analytical database (nonvolatile, historical, subject-oriented) with multidimensional analysis capabilities.
   - **Breakthrough:** Combined historical data integration with desktop-friendly analytical tools.

## Visual Explanation

```dot
digraph dwh_evolution {
  rankdir=LR
  node [shape=box style=filled fontname="Helvetica" fontsize=11]
  edge [fontname="Helvetica" fontsize=10]

  sixties [label="1960s\nBatch Reports\n(Inflexible, Expensive)" fillcolor="#f8d7da"]
  seventies [label="1970s\nTerminal DSS/EIS\n(No Desktop Integration)" fillcolor="#ffe5cc"]
  eighties [label="1980s\nDesktop Tools\n(Only Operational Data)" fillcolor="#fff3cd"]
  nineties [label="1990s\nData Warehouse + OLAP\n(Historical + Integrated)" fillcolor="#d4edda"]

  sixties -> seventies -> eighties -> nineties [label="evolution"]
}
```

## Semantic Network

```dot
graph semantic_evolution {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="DWH Evolution" fillcolor="#ffd700" fontsize=13 style="filled,bold"]

  DWH_DEF [label="Data Warehouse\nDefinition" fillcolor="#cce5ff"]
  OLTP [label="OLTP vs OLAP" fillcolor="#cce5ff"]
  THREE_TIER [label="Three-Tier DWH\nArchitecture" fillcolor="#d4edda"]
  OLAP_SRV [label="OLAP Servers" fillcolor="#d4edda"]
  OLAP_OPS [label="OLAP Operations" fillcolor="#d4edda"]

  THIS -- DWH_DEF [label="builds into"]
  THIS -- OLTP [label="builds into"]
  THIS -- THREE_TIER [label="builds into"]
  THIS -- OLAP_SRV [label="builds into"]
  THIS -- OLAP_OPS [label="builds into"]
}
```

## Key Properties

- **Four phases:** 60s (batch), 70s (terminal), 80s (desktop), 90s (warehouse + OLAP)
- **Problem-driven:** Each phase solved the previous phase's limitations
- **Increasing flexibility:** From reprogramming every query to interactive analysis
- **Data access expansion:** From batch reports → terminals → desktop → integrated warehouse
- **OLAP integration:** The 90s breakthrough was combining historical data with multidimensional analysis

## Connections

- **Builds into:** [[data-warehouse-definition|Data Warehouse Definition]] — evolution explains why the four characteristics exist
- **Builds into:** [[oltp-vs-olap|OLTP vs OLAP]] — the 80s limitation (only operational data) motivated the OLAP/OLTP split
- **Builds into:** [[three-tier-dwh-architecture|Three-Tier DWH Architecture]] — the architecture is the culmination of the evolution
- **Builds into:** [[olap-servers|OLAP Servers]] — OLAP integration was the 90s breakthrough
- **Related:** [[dwh-benefits|DWH Benefits]] — benefits represent the solution to all historical limitations

## Edge Cases & Gotchas

- **Pre-history:** Before the 1960s, data analysis was entirely manual — paper records and human calculation.
- **The term "data warehouse":** Coined by Bill Inmon in the early 1990s, formalizing concepts that had been evolving for decades.
- **Parallel developments:** The evolution described is specific to business intelligence; scientific computing had its own parallel evolution.

## Sources

- [[dw1-summary|Source: Data Warehouse — Definitions, Architecture, ETL, OLAP]] — evolution from 60s to 90s
