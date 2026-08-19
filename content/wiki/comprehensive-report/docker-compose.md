---
concept: Docker Compose
aliases: [docker-compose, container orchestration, multi-container]
tags: [systems, devops]
created: 2026-04-14
updated: 2026-04-14
---

## The Problem
A modern data platform requires multiple services—PostgreSQL, Airflow, Metabase, Redis—each with their own configuration, dependencies, and networking. Installing and configuring these manually on a development machine is error-prone and hard to reproduce.

## Core Idea
Docker Compose is a tool for defining and running multi-container applications. A single `docker-compose.yml` file declares all services, their images, ports, volumes, environment variables, and dependencies. Running `docker compose up -d` starts everything with proper health checks and networking.

## How It Works
1. **Service definition**: Each container (PostgreSQL, Airflow, Metabase) is defined with image, ports, volumes
2. **Dependencies**: `depends_on` ensures startup order; `condition: service_healthy` waits for health checks
3. **Volumes**: Named volumes persist data across restarts (`postgres_data`, `airflow_db_data`)
4. **Health checks**: `pg_isready` for PostgreSQL, `curl` for web services
5. **Environment variables**: Passed to containers for configuration
6. **Network**: Default bridge network allows container-to-container communication

Example (FoodFlow services):
- `foodflow_postgres`: PostgreSQL 15 on port 5433
- `foodflow_airflow_db`: Airflow metadata DB
- `foodflow_airflow`: Airflow 2.8.4 web UI on :8080
- `foodflow_metabase_db`: Metabase metadata DB
- `foodflow_metabase`: BI tool on :3000

## Key Properties
- **Single command startup**: `docker compose up -d` starts entire stack
- **Health checks**: Services wait for dependencies to be healthy before starting
- **Persistent volumes**: Data survives `docker compose down`
- **Port mapping**: Host ports (5433, 8080, 3000) map to container ports
- **Bind mounts**: Local directories mounted into containers for code/data access

## Connections
- Related: [[apache-airflow|Apache Airflow]] — runs in Docker Compose environment
- Related: [[data-warehouse|Data Warehouse]] — PostgreSQL runs in Docker Compose
- Related: [[etl-pipeline|ETL Pipeline]] — ETL scripts access DB via Docker networking

## Edge Cases & Gotchas
- **Volume persistence**: `docker compose down` keeps volumes; `docker compose down -v` deletes
- **Startup order**: Even with `depends_on`, fast-starting services may fail if slow starters aren't ready
- **Resource limits**: No CPU/memory limits by default—containers can consume host resources
- **Secrets**: Credentials in docker-compose.yml visible to anyone with file access—use Docker secrets in production

## Sources
- [[../comprehensive-report-summary|FoodFlow Analytics Comprehensive Report]]
