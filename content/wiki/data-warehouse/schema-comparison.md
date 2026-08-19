---
title: Star vs Snowflake vs Galaxy — DWH Schema Comparison
type: synthesis
tags: [database, data-warehouse]
created: 2026-05-04
updated: 2026-05-04
---

## What's Being Compared

The three schema architectures for data warehouses — Star, Snowflake, and Fact Constellation (Galaxy) — represent a progression from simple to complex dimensional modeling. Understanding their tradeoffs is essential for choosing the right schema for a given warehouse's scale, query patterns, and organizational complexity.

## The Core Tension

The fundamental tradeoff is **query simplicity vs. storage efficiency vs. modeling expressiveness**. Star schema maximizes query speed through denormalization but wastes storage. Snowflake reduces storage through normalization but adds join complexity. Galaxy supports multi-process analysis but introduces significant design complexity.

## Comparison

| Dimension | [[star-schema|Star Schema]] | [[snowflake-schema|Snowflake Schema]] | [[fact-constellation-schema|Fact Constellation]] |
|-----------|--------------|--------------|--------------|
| Fact tables | One | One | Multiple (shared dimensions) |
| Dimension normalization | Fully denormalized | Normalized (split tables) | Depends (can be star or snowflake per fact) |
| Query complexity | Minimal (1-2 joins) | Moderate (3+ joins) | High (multi-fact queries) |
| Storage efficiency | Low (high redundancy) | High (normalized) | Medium (shared dims reduce redundancy) |
| Query speed | Fastest | Moderate | Varies per fact table |
| Maintenance complexity | Low | Moderate | High |
| Best for | Single-process, moderate scale | Storage-constrained environments | Multi-process enterprise |
| Use case | Department-level analytics | Cost-sensitive deployments | Enterprise-wide BI |

## When to Choose Star Schema

- Single business process (e.g., just sales analysis)
- Query speed is the highest priority
- Storage cost is not a concern
- Business users write their own queries and need simple schemas

## When to Choose Snowflake Schema

- Large dimension tables with significant redundancy
- Storage costs are a concern
- Query performance requirements are moderate
- Maintenance of dimension values is frequent (normalized updates are easier)

## When to Choose Fact Constellation

- Multiple business processes need cross-analysis (sales + shipping + returns)
- Enterprise-scale deployment
- Shared dimensions exist across processes (Time, Item, Location)
- Organization has mature data governance

## The Insight

The three schemas are not mutually exclusive — they form a **design spectrum**. A single warehouse can use star schema for some subject areas, snowflake for others, and galaxy for the enterprise view. The choice is not "which schema" but "which schema for which subject area." The progression from star → snowflake → galaxy mirrors the organization's growth from department-level analysis to enterprise-wide intelligence.

## Connections

- [[wiki/data-warehouse/star-schema|Star Schema]] — simplest schema, foundation for both others
- [[snowflake-schema|Snowflake Schema]] — normalized variant of star
- [[fact-constellation-schema|Fact Constellation Schema]] — multi-fact extension
- [[multidimensional-data-model|Multidimensional Data Model]] — all three implement this model
- [[wiki/data-warehouse/dimension-table|Dimension Table]] — normalization decisions affect dimension design
- [[data-mart-types|Data Mart Types]] — schema choice interacts with data mart architecture
