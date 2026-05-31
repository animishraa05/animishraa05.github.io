---
concept: Fact Table
aliases: [fact, measure, business metric]
tags: [database, data-warehouse]
sources_count: 2
last_source: dw1.md
created: 2026-04-14
updated: 2026-05-04
---

# Fact Table

## The Problem
Business analysts need to answer questions like "total revenue by city" or "orders per day." Storing this data in normalized transactional tables requires expensive JOINs across multiple normalized tables. Fact tables centralize the quantitative metrics for fast analytical queries.

## Core Idea
A fact table is the central table in a star schema, containing measurable business events (orders, clicks, transactions) with foreign keys to dimension tables. Each row represents one event, and columns contain quantitative measures (revenue, quantity, delivery_time).

## How It Works
1. **Foreign keys**: References to dimension primary keys (customer_id, restaurant_id, date_id)
2. **Measures**: Quantitative metrics that can be aggregated (net_total, delivery_time_min, quantity)
3. **Degenerate dimensions**: Low-cardinality attributes (status, platform, payment_method) kept directly in fact
4. **Binary flags**: Integer flags (is_delivered, is_cancelled) stored as SMALLINT for easy SUM()

In food delivery:
- `fact_orders`: order_id, customer_id, restaurant_id, agent_id, date_id, net_total, delivery_time_min, is_delivered (SMALLINT), status, platform, method
- `fact_order_items`: order_item_id, order_id, item_id, quantity, unit_price, revenue

A query to find top restaurants by revenue:
```sql
SELECT r.name, SUM(o.net_total) AS revenue
FROM fact_orders o
JOIN dim_restaurant r ON o.restaurant_id = r.restaurant_id
GROUP BY r.name
ORDER BY revenue DESC
```

## Key Properties
- **Grain**: The level of detail—one row per order, one row per line item
- **Additive measures**: Can be summed (revenue), non-additive (ratings must be averaged)
- **Foreign key constraints**: Enforce referential integrity with dimensions
- **Composite indexes**: On frequently filtered columns (date_id, customer_id, status)
- **Denormalization**: customer_id and date_id included in fact_order_items to avoid JOINs

## Connections
- Built from: [[wiki/comprehensive-report/star-schema|Star Schema]] — fact tables are the center
- Builds into: [[data-warehouse|Data Warehouse]] — fact tables are core warehouse components
- Related: [[wiki/comprehensive-report/dimension-table|Dimension Table]] — fact tables reference dimensions
- Related: [[sql-database|SQL Database]] — fact tables are implemented in SQL
- Related: [[etl-pipeline|ETL Pipeline]] — ETL populates fact tables

## Edge Cases & Gotchas
- **Inconsistent grain**: Mixing row-per-order with row-per-line-item in same table causes double-counting
- **NULL in measures**: Aggregations like SUM() ignore NULLs—use COALESCE or fill nulls with 0
- **Integer flags vs boolean**: Using SMALLINT (0/1) instead of BOOLEAN enables SUM(is_delivered) directly
- **Degenerate dimension misuse**: Creating separate tables for 3-5 value attributes adds overhead with no benefit
## Sources

- [[../comprehensive-report-summary|FoodFlow Analytics Comprehensive Report]]
- [[dw1-summary|Data Warehouse — Definitions, Architecture, ETL, OLAP]] — fact table with measures and foreign keys, fact constellation with multiple facts
