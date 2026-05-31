---
concept: ETL Pipeline
aliases: [ETL, extract transform load, data pipeline]
tags: [database, data-engineering]
sources_count: 2
last_source: dw1.md
created: 2026-04-14
updated: 2026-05-04
---

# ETL Pipeline

## The Problem
Raw source data (CSV files, JSON APIs, transactional databases) arrives in various formats with quality issues—duplicates, inconsistent casing, missing values. Business analysts need clean, structured data in a warehouse schema to run analytical queries.

## Core Idea
ETL (Extract, Transform, Load) is a three-phase data pipeline that reads raw data, applies transformations (cleaning, deduplication, feature engineering), and loads it into a data warehouse. It bridges the gap between source systems and analytical consumption.

## How It Works
### Extract Phase
- Read source files (7 CSVs: customers, restaurants, menu_items, delivery_agents, orders, order_items, payments)
- Validate file existence and minimum row counts
- Load into pandas DataFrames
- Log quality metrics (null percentages, duplicate counts)

### Transform Phase
- **Deduplication**: `drop_duplicates(subset="id")` removes exact duplicates
- **String normalization**: `.str.strip().str.title()` for names, `.str.lower()` for emails
- **Date parsing**: `pd.to_datetime()` converts string dates
- **Feature engineering**: Creates computed columns like `tenure_days`, `customer_segment`, `rating_band`
- **Flag creation**: `is_delivered = (status == "Delivered").astype(int)`

### Load Phase
- **Bulk insert**: SQLAlchemy `to_sql()` with `chunksize=5000`, `method="multi"` for batch inserts
- **Load order**: Dimensions first (independent), then facts (depend on dimensions)
- **Post-load indexing**: Create performance indexes after data is loaded

## Key Properties
- ** idempotent**: Same input produces same output—run repeatedly without side effects
- **Full REPLACE strategy**: DROP and recreate tables on each run (simple, suitable for small datasets)
- **Logging**: `_log_quality()` function logs nulls and duplicates without blocking
- **Reference date**: Fixed reference date (2024-12-31) for computing tenure/experience days

## Connections
- Builds into: [[data-warehouse|Data Warehouse]] — ETL populates the warehouse
- Builds into: [[wiki/comprehensive-report/dimension-table|Dimension Table]] — ETL creates dimension tables
- Builds into: [[wiki/comprehensive-report/fact-table|Fact Table]] — ETL creates fact tables
- Related: [[apache-airflow|Apache Airflow]] — orchestration runs ETL on schedule
- Related: [[wiki/comprehensive-report/star-schema|Star Schema]] — ETL transforms data into star schema format

## Edge Cases & Gotchas
- **Partial failure**: If load fails midway, inconsistent data remains—use transactions
- **Reference date staleness**: Hardcoded 2024-12-31 makes tenure values incorrect over time
- **Full refresh limitation**: Doesn't scale to millions of rows—in production use incremental UPSERT
- **No watermark tracking**: Simple REPLACE loses ability to process only new records
## Sources

- [[../comprehensive-report-summary|FoodFlow Analytics Comprehensive Report]]
- [[dw1-summary|Data Warehouse — Definitions, Architecture, ETL, OLAP]] — four-phase ETL process, data scrubbing, loading with checkpoints, refresh techniques
