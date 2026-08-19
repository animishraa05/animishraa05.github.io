---
concept: Apache Airflow
aliases: [Airflow, workflow orchestration, DAG scheduler]
tags: [systems, orchestration]
created: 2026-04-14
updated: 2026-04-14
---

## The Problem
A data pipeline isn't a one-time script—it's a recurring process that must run daily, handle errors gracefully, retry on failure, and notify stakeholders. Building this orchestration logic from scratch is complex and error-prone.

## Core Idea
Apache Airflow is a workflow orchestration platform that defines pipelines as directed acyclic graphs (DAGs) of tasks. It handles scheduling, execution, retry logic, monitoring, and alerting—everything needed to run reliable data pipelines in production.

## How It Works
1. **DAG definition**: Python file defining tasks and their dependencies
2. **Scheduler**: Triggers DAG runs on schedule (cron expression like `30 21 * * *`)
3. **Executor**: Runs tasks (LocalExecutor for single-machine, Celery/Kubernetes for distributed)
4. **Task types**: PythonOperator (Python code), BashOperator (shell commands), PostgresOperator (SQL)
5. **Retries**: Failed tasks automatically retry with configurable delay
6. **Notifications**: Email/Slack on failure via `email_on_failure`

Example DAG structure (FoodFlow daily ETL):
```
data_quality_check → run_etl_pipeline → refresh_aggregates → ml_order_volume_forecast → notify_success
```

Schedule: `30 21 * * *` = 21:30 UTC = 03:00 IST (next day)—lowest traffic period

## Key Properties
- **Python-defined DAGs**: Code-as-configuration, version-controlled
- **Task dependencies**: Explicit `>>` or `set_upstream()` defines execution order
- **Execution timeout**: Maximum runtime per task/DAG prevents stuck pipelines
- **Catchup=False**: Don't backfill missed runs when DAG was paused
- **Connection abstraction**: Database connections defined in Airflow UI, accessed by tasks

## Connections
- Builds into: [[etl-pipeline|ETL Pipeline]] — Airflow orchestrates ETL execution
- Related: [[docker-compose|Docker Compose]] — Airflow runs in containerized environment
- Related: [[data-warehouse|Data Warehouse]] — Airflow writes to warehouse

## Edge Cases & Gotchas
- **LocalExecutor limitation**: Single-threaded, not suitable for high parallelism
- **Pip install on startup**: Adds 30-60 seconds to container startup time
- **Metadata database**: Needs separate PostgreSQL for Airflow's own state
- **No built-in data quality**: Just file existence checks—need Great Expectations for deep validation

## Sources
- [[../comprehensive-report-summary|FoodFlow Analytics Comprehensive Report]]
