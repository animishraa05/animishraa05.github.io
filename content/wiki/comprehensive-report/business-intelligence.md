---
concept: Business Intelligence
aliases: [BI]
tags: [database, analytics]
created: 2026-09-19
updated: 2026-09-19
---

## The Problem

Stakeholders ask what happened but engineers hand them raw tables -- how do you turn warehouse data into decisions?

## Formal Definition

Per Wikipedia: "Business Intelligence is the layer of dashboards, KPIs and self-service queries that sit on top of a warehouse for decision making."

## Explanation

BI is the dashboard of a car -- warehouse is the engine, but driver only sees speed and fuel on the dials.

## How It Works

1. Define KPIs like CLV and RFM
2. Model marts for reporting
3. Build dashboards in BI tool
4. Schedule refresh via automation
5. Share insights with stakeholders

## Visual Explanation

```dot
digraph business_intelligence {
  rankdir=LR
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica"]
  A [label="Warehouse"]
  B [label="BI Layer"]
  C [label="Decision"]
  A -> B [label="step 1"]
  B -> C [label="step 2"]
}
```

## Semantic Network

```dot
graph semantic_business_intelligence {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  THIS [label="Business Intelligence" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  REL1 [label="Related" fillcolor="#f0f0f0"]
  REL2 [label="Prereq" fillcolor="#cce5ff"]
  THIS -- REL1 [label="related"]
  THIS -- REL2 [label="builds from"]
}
```

## Key Properties

- Self-service reduces ticket load
- Needs governance on metric definitions
- Drill-down needs good dimensional model

## Real-World Example

```python
SELECT rfm_segment, COUNT(*) FROM mart GROUP BY 1
```

## Connections

- **Built from:** [[rfm-segmentation|RFM Segmentation]] -- BI visualizes RFM
- **Built from:** [[customer-lifetime-value|Customer Lifetime Value]] -- KPI source
- **Related:** [[data-warehouse|Data Warehouse]] -- BI consumes warehouse
- **Related:** [[star-schema|Star Schema]] -- BI queries star schema

## Edge Cases & Gotchas

- Vanity metrics -- tracking visits not conversion
- Dashboard sprawl -- 50 dashboards nobody opens
