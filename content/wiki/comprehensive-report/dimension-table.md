---
concept: Dimension Table
aliases: [dimension, dimension attribute, descriptive attribute]
tags: [database, data-warehouse]
sources_count: 2
last_source: dw1.md
created: 2026-04-14
updated: 2026-05-04
---

# Dimension Table

## The Problem
Fact tables contain quantitative metrics, but they need context—knowing that `customer_id = CUST0001` isn't useful without knowing the customer's name, city, and preferences. Dimension tables provide this descriptive context.

## Core Idea
A dimension table is a denormalized table containing descriptive attributes about a business entity. It has a primary key (often a surrogate key) that connects to foreign keys in fact tables. Each row represents one instance of a business entity (customer, restaurant, date, product).

## How It Works
1. **Primary key**: Unique identifier for each entity (customer_id, restaurant_id, date_id)
2. **Descriptive attributes**: All related information in one table—no need to JOIN
3. **Surrogate keys**: Integer-based keys like `date_id = 20240115` for performance
4. **Computed attributes**: Feature engineering adds derived fields like `tenure_days`, `customer_segment`, `rating_band`

In a food delivery warehouse:
- `dim_customer`: customer_id, full_name, email, city, age_group, gender, is_premium, registration_date, tenure_days, customer_segment
- `dim_restaurant`: restaurant_id, name, city, cuisine_type, rating, rating_band, avg_prep_time_min, is_veg_only
- `dim_date`: date_id, full_date, day, month, year, quarter, week, day_of_week, day_name, is_weekend, is_holiday, is_peak_season

## Key Properties
- **Denormalized**: All attributes in one table for query simplicity
- **SCD Type 1**: Overwrites on change (simpler, appropriate for static datasets)
- **Surrogate keys**: Integer-based keys for faster lookups than natural keys
- **Computed bands**: `pd.cut()` creates categorical bands (rating_band, price_band, performance_tier)
- **Foreign key in fact**: Fact tables reference dimension primary keys

## Connections
- Built from: [[wiki/comprehensive-report/star-schema|Star Schema]] — dimension tables are a core component
- Builds into: [[wiki/comprehensive-report/fact-table|Fact Table]] — fact tables reference dimensions via foreign keys
- Related: [[etl-pipeline|ETL Pipeline]] — ETL transforms raw data into dimension tables
- Related: [[data-warehouse|Data Warehouse]] — dimensions are part of the warehouse schema

## Edge Cases & Gotchas
- **Hardcoded reference date**: Using fixed reference date (2024-12-31) makes tenure_days stale over time
- **Type 1 limitation**: Customer city change overwrites history—old orders appear in new city
- **Low-cardinality attributes**: Attributes with 3-5 values (status, platform) belong in fact as degenerate dimensions, not separate dimension tables
## Sources

- [[../comprehensive-report-summary|FoodFlow Analytics Comprehensive Report]]
- [[dw1-summary|Data Warehouse — Definitions, Architecture, ETL, OLAP]] — dimension tables with attributes, hierarchies, normalization in snowflake schema
