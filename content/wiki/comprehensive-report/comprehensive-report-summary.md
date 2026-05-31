---
source: FoodFlow Analytics Comprehensive Report
source_path: sources/COMPREHENSIVE_REPORT.md
content_hash: ""
ingested: 2026-04-14
concepts_count: 11
tags: [database, data-engineering]
---

# FoodFlow Analytics — Source Summary

## What This Source Is
A comprehensive end-to-end data warehouse and analytics project for an Indian food delivery platform (similar to Swiggy/Zomato). It demonstrates the full data stack: synthetic data generation, star schema data warehouse, ETL pipeline, Apache Airflow orchestration, analytical SQL queries, Prophet ML forecasting, and interactive dashboards (Streamlit + Metabase).

## Concepts Extracted
This source introduced 11 atomic concepts:

1. **[[wiki/comprehensive-report/star-schema|Star Schema]]** — Denormalized dimensional model with fact tables at center, dimension tables surrounding
2. **[[wiki/comprehensive-report/dimension-table|Dimension Table]]** — Descriptive attributes about business entities (customer, restaurant, date)
3. **[[wiki/comprehensive-report/fact-table|Fact Table]]** — Measurable business events with foreign keys to dimensions
4. **[[etl-pipeline|ETL Pipeline]]** — Extract, Transform, Load process that populates warehouse
5. **[[data-warehouse|Data Warehouse]]** — Separate analytical database for OLAP queries
6. **[[apache-airflow|Apache Airflow]]** — Workflow orchestration for scheduling and monitoring pipelines
7. **[[prophet-forecasting|Prophet Forecasting]]** — Facebook Prophet time-series model for demand forecasting
8. **[[rfm-segmentation|RFM Segmentation]]** — Recency, Frequency, Monetary customer segmentation
9. **[[docker-compose|Docker Compose]]** — Container orchestration for multi-service infrastructure
10. **[[customer-lifetime-value|Customer Lifetime Value]]** — Total expected revenue from a customer

## Key Takeaways
- **Star schema design**: Fact tables at center, denormalized dimensions, surrogate keys (date_id as INTEGER YYYYMMDD)
- **Scale**: 7 datasets, ~290,000 rows, 80,000 orders, 2-year date range
- **ETL pipeline**: Full REPLACE strategy with deduplication, string normalization, feature engineering
- **Airflow DAG**: 5 tasks (data quality check → ETL → aggregates → ML forecast → notify)
- **SQL analytics**: 11 production queries using CTEs, window functions (LAG, NTILE), RFM scoring
- **ML forecasting**: Prophet with multiplicative seasonality, weekend regressor, MAPE/MAE/RMSE evaluation
- **Indian market context**: en_IN Faker locale, 10 Indian cities, UPI/cash payment methods, festival holidays

## Novelty for Wiki
This source adds **data engineering** domain concepts to the wiki. Previously the wiki covered EJB, networking, theory of computation, image generation, and Vim—now it expands into analytics and ML operations.

## Open Questions
- How would incremental ETL differ from full REPLACE for this schema?
- What additional features would improve Prophet forecasting accuracy?
- How would real-time streaming change the architecture?

## Connections

- [[wiki/comprehensive-report/star-schema|Star Schema]] — dimensional model design
- [[etl-pipeline|ETL Pipeline]] — data loading process
- [[data-warehouse|Data Warehouse]] — analytical storage
- [[apache-airflow|Apache Airflow]] — workflow orchestration
- [[prophet-forecasting|Prophet Forecasting]] — ML forecasting
- [[rfm-segmentation|RFM Segmentation]] — customer analytics
- [[docker-compose|Docker Compose]] — infrastructure orchestration
- [[wiki/comprehensive-report/fact-table|Fact Table]] — measurable events
- [[wiki/comprehensive-report/dimension-table|Dimension Table]] — descriptive attributes
- [[customer-lifetime-value|Customer Lifetime Value]] — revenue metric
