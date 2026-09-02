---
concept: Star Schema
aliases: [star schema design, kimball dimensional model]
tags: [database, data-warehouse]
created: 2026-04-14
updated: 2026-05-04
---

## The Problem
Relational databases are optimized for transactional operations (INSERT, UPDATE, DELETE), not analytical queries that aggregate millions of rows. A normalized transactional schema requires multiple JOINs to answer business questions, which becomes slow and complex at scale.

## Core Idea
Star schema is a denormalized data modeling approach where a central fact table (containing measurable business events) is surrounded by dimension tables (containing descriptive attributes). This design minimizes JOINs for analytical queries—a query typically joins only the fact table with one or more dimension tables.

## How It Works
1. **Fact tables** sit at the center, containing quantitative metrics (orders, revenue, quantities) and foreign keys to dimensions
2. **Dimension tables** surround the facts, containing descriptive attributes (customer names, restaurant cuisines, dates)
3. Each dimension has a primary key (surrogate key) that joins to the fact table
4. Dimensions are denormalized—all related attributes live in a single table rather than being split across normalized tables

For example, a food delivery schema might have:
- `fact_orders`: 80,000 rows with order_id, customer_id, restaurant_id, agent_id, date_id, net_total
- `dim_customer`: 5,000 rows with customer_id, name, city, age_group, is_premium
- `dim_restaurant`: 200 rows with restaurant_id, name, city, cuisine_type, rating
- `dim_date`: 731 rows with date_id, full_date, day, month, year, is_weekend, is_holiday

A query like "total revenue by city for Q1 2024" only needs:
```sql
SELECT r.city, SUM(o.net_total)
FROM fact_orders o
JOIN dim_date d ON o.date_id = d.date_id
JOIN dim_restaurant r ON o.restaurant_id = r.restaurant_id
WHERE d.year = 2024 AND d.quarter = 1
GROUP BY r.city
```

## Key Properties
- **Denormalized dimensions**: All attributes in one table—no need to JOIN dimension tables together
- **Surrogate keys**: Integer-based keys (like date_id = YYYYMMDD) for faster range scans than DATE comparisons
- **Degenerate dimensions**: Low-cardinality attributes (status, platform, payment method) kept in fact table rather than separate dimensions
- **Foreign key constraints**: Enforce referential integrity between fact and dimension tables
- **Composite primary keys**: Aggregate tables use composite keys (year, month, city, cuisine_type) for uniqueness

## Connections
- Built from: [[sql-database|SQL Database]] — star schema is implemented on top of relational databases
- Builds into: [[data-warehouse|Data Warehouse]] — star schema is the standard schema design for OLAP warehouses
- Builds into: [[wiki/comprehensive-report/dimension-table|Dimension Table]] — dimension tables are a core component of star schema
- Builds into: [[wiki/comprehensive-report/fact-table|Fact Table]] — fact tables are the center of star schema
- Related: [[etl-pipeline|ETL Pipeline]] — ETL populates star schema tables from source data

## Edge Cases & Gotchas
- **SCD Type 1 only**: Overwrites on change—historical orders show new city if customer moves
- **Full refresh**: For small datasets, full REPLACE (DROP + INSERT) is simpler than incremental loads
- **Integer vs DATE**: Using INTEGER date_id (YYYYMMDD) performs faster than DATE type for range scans in PostgreSQL