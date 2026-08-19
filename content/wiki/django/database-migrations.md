---
concept: Database Migrations
aliases: [Migrations, Schema Migrations, django.db.migrations]
tags: [dev, django]
sources_count: 1
last_source: Django.md
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

Database Migrations are Django's version-control system for database schema, represented as Python files containing `Operations` (CreateModel, AddField, AlterField, RunSQL, RunPython) that transform the database from one state to another, tracked in the `django_migrations` table to ensure idempotent application across environments.

## Explanation

Migrations solve the problem of evolving database schema alongside code without manual SQL scripts or data loss. When models change, `makemigrations` generates a new migration file by comparing current models to the historical state reconstructed from previous migrations. `migrate` applies unapplied migrations in dependency order, recording each in `django_migrations`. This enables team collaboration, CI/CD integration, and safe rollbacks (when operations are reversible).

## How It Works

1. **Models changed** — Developer modifies `models.py` (add field, change type, new model)
2. **Autodetector runs** — `makemigrations` compares current models to project state from last migration
3. **Operations generated** — Creates `Migration` class with `operations = [AddField(...), ...]`
4. **Dependencies resolved** — Migration declares `dependencies = [('app', '0001_initial'), ...]`
5. **Migration applied** — `migrate` runs operations in topological order, updates `django_migrations`
6. **State reconstructed** — Future `makemigrations` replays all migrations to compute current state

## Visual Explanation

```dot
digraph database_migrations {
  rankdir=LR;
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=10];

  ModelsPy [label="models.py\nclass Book:\n    title = CharField()\n    # NEW: author = FK" fillcolor="#ffe5cc"];
  Makemigrations [label="makemigrations\nAutodetector"];
  MigrationFile [label="0002_book_author.py\noperations = [\n  AddField(...)\n]"];
  Migrate [label="migrate\nExecutor"];
  DBTable [label="django_migrations\n(app, name, applied)"];
  Database [label="PostgreSQL\nALTER TABLE book\nADD COLUMN author_id..." fillcolor="#d4edda"];

  ModelsPy -> Makemigrations [label="1. Change detected"];
  Makemigrations -> MigrationFile [label="2. Generate ops"];
  MigrationFile -> Migrate [label="3. Plan & apply"];
  Migrate -> DBTable [label="4. Record applied"];
  Migrate -> Database [label="5. Execute SQL"];
}
```

## Semantic Network

```dot
graph semantic_database_migrations {
  layout=neato;
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled];
  edge [fontname="Helvetica" fontsize=9];

  THIS [label="Database\nMigrations" fillcolor="#ffd700" fontsize=13 style="filled,bold"];

  PRE1 [label="Models /\nORM" fillcolor="#cce5ff"];
  PRE2 [label="Historical\nModel State" fillcolor="#cce5ff"];
  PRE3 [label="Dependency\nGraph" fillcolor="#cce5ff"];

  OUT1 [label="Schema\nOperations" fillcolor="#d4edda"];
  OUT2 [label="Data\nMigrations" fillcolor="#d4edda"];
  OUT3 [label="Squash\nMigrations" fillcolor="#d4edda"];
  OUT4 [label="Fake\nMigrations" fillcolor="#d4edda"];

  CON1 [label="Alembic\n(SQLAlchemy)" fillcolor="#ffe5cc"];
  CON2 [label="Flyway\n(SQL-based)" fillcolor="#ffe5cc"];

  REL1 [label="Transaction\nWrapper" fillcolor="#f0f0f0"];
  REL2 [label="RunPython\n(Custom Logic)" fillcolor="#f0f0f0"];

  THIS -- PRE1 [label="built from" style=dashed];
  THIS -- PRE2 [label="built from" style=dashed];
  THIS -- PRE3 [label="built from" style=dashed];
  THIS -- OUT1 [label="builds into"];
  THIS -- OUT2 [label="builds into"];
  THIS -- OUT3 [label="builds into"];
  THIS -- OUT4 [label="builds into"];
  THIS -- CON1 [label="contrasts with" style=dotted];
  THIS -- CON2 [label="contrasts with" style=dotted];
  THIS -- REL1 [label="related"];
  THIS -- REL2 [label="related"];
}
```

## Key Properties

- **Declarative operations**: `CreateModel`, `AddField`, `AlterField`, `RemoveField`, `RunSQL`, `RunPython`
- **Dependency graph**: Linear per-app, cross-app via `dependencies`; topological sort ensures order
- **Reversibility**: Most operations auto-reversible; `RunPython` needs `reverse_code`; `RunSQL` needs reverse SQL
- **Squashing**: `squashmigrations` combines many migrations into one for faster initial setup
- **Historical models**: `apps.get_model('app', 'Model')` in `RunPython` uses frozen model state

## Connections

- Built from: [[models-orm|Models/ORM]] — Source of schema changes
- Built from: [[historical-model-state|Historical Model State]] — Baseline for autodetection
- Builds into: [[schema-operations|Schema Operations]] — Individual migration steps
- Builds into: [[data-migrations|Data Migrations]] — `RunPython` for data transformation
- Builds into: [[squash-migrations|Squash Migrations]] — Optimize migration history
- Contrasts with: [[alembic|Alembic]] — SQLAlchemy's migration tool, similar but separate ecosystem
- Contrasts with: [[flyway|Flyway]] — SQL-file based, not ORM-coupled
- Related: [[database-transactions|Transaction Wrapper]] — Each migration in transaction (except PostgreSQL DDL)
- Related: [[runpython|RunPython]] — Custom data migration logic

## Edge Cases & Gotchas

- **Non-reversible migrations**: `RunPython` without `reverse_code` blocks rollback; `migrate --fake` risky
- **Concurrent migrations**: Two developers create `0003_...` — resolve with `makemigrations --merge`
- **Large table ALTER**: Adding column with default locks table; use `AddField` → `RunSQL` (no default) → `AlterField`
- **Historical model drift**: `RunPython` using current model instead of `apps.get_model()` breaks future migrations
- **Swap app models**: `swappable = 'AUTH_USER_MODEL'` requires special handling in migrations

## Sources

- [[django-summary|Django Learning Roadmap]]