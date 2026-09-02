---
concept: Models ORM
aliases: [Django Models, ORM, Object-Relational Mapping, django.db.models]
tags: [dev, django]
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

Django Models define the structure and behavior of application data as Python classes inheriting from `django.db.models.Model`, where each class attribute represents a database field, and the ORM (Object-Relational Mapper) translates Python operations (create, filter, save, delete) into SQL queries against a relational database.

## Explanation

The Models/ORM layer solves the impedance mismatch between Python objects and relational tables. Instead of writing SQL, developers define fields (`CharField`, `IntegerField`, `ForeignKey`, `ManyToManyField`) with constraints (`null`, `blank`, `unique`, `choices`), and Django handles schema creation (migrations), query generation, and object hydration. The ORM supports relationships, aggregation, annotation, and raw SQL escape hatches.

## How It Works

1. **Model defined** — Python class with field instances as class attributes
2. **Migration created** — `makemigrations` inspects model changes, generates schema operations
3. **Migration applied** — `migrate` executes SQL (CREATE TABLE, ALTER TABLE) on database
3. **Query issued** — `Model.objects.filter(...)` returns lazy `QuerySet`
4. **SQL generated** — QuerySet compiles to SELECT with JOINs for relationships
5. **Results hydrated** — Rows converted to model instances (or dicts via `.values()`)
6. **Instance saved** — `instance.save()` generates INSERT or UPDATE

## Visual Explanation

```dot
digraph models_orm {
  rankdir=TB;
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=10];

  ModelClass [label="class Post(models.Model):\n    title = CharField()\n    author = ForeignKey(User)" fillcolor="#ffe5cc"];
  Migration [label="makemigrations\n→ 0001_initial.py"];
  Database [label="PostgreSQL\nCREATE TABLE post (...)" fillcolor="#cce5ff"];
  Manager [label="Post.objects\n→ Manager"];
  QuerySet [label="QuerySet\n.filter(), .exclude()"];
  SQL [label="SELECT * FROM post\nJOIN auth_user ..."];
  Instance [label="Post(title='Hi',\n      author=<User>)" fillcolor="#d4edda"];

  ModelClass -> Migration [label="1. Detect changes"];
  Migration -> Database [label="2. Apply schema"];
  ModelClass -> Manager [label="3. Default manager"];
  Manager -> QuerySet [label="4. Query API"];
  QuerySet -> SQL [label="5. Compile"];
  SQL -> Database [label="6. Execute"];
  Database -> Instance [label="7. Hydrate"];
}
```

## Semantic Network

```dot
graph semantic_models_orm {
  layout=neato;
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled];
  edge [fontname="Helvetica" fontsize=9];

  THIS [label="Models /\nORM" fillcolor="#ffd700" fontsize=13 style="filled,bold"];

  PRE1 [label="Database\nMigrations" fillcolor="#cce5ff"];
  PRE2 [label="Field\nClasses" fillcolor="#cce5ff"];
  PRE3 [label="Relationship\nFields" fillcolor="#cce5ff"];

  OUT1 [label="QuerySet\nAPI" fillcolor="#d4edda"];
  OUT2 [label="Model\nManagers" fillcolor="#d4edda"];
  OUT3 [label="Admin\nPanel" fillcolor="#d4edda"];
  OUT4 [label="ModelForms\nAuto-generation" fillcolor="#d4edda"];
  OUT5 [label="DRF\nSerializers" fillcolor="#d4edda"];

  CON1 [label="SQLAlchemy\n(Data Mapper)" fillcolor="#ffe5cc"];
  CON2 [label="Raw SQL\n(Psycopg2)" fillcolor="#ffe5cc"];

  REL1 [label="Transactions\n(Atomic Blocks)" fillcolor="#f0f0f0"];
  REL2 [label="Signals\n(pre_save, etc.)" fillcolor="#f0f0f0"];

  THIS -- PRE1 [label="built from" style=dashed];
  THIS -- PRE2 [label="built from" style=dashed];
  THIS -- PRE3 [label="built from" style=dashed];
  THIS -- OUT1 [label="builds into"];
  THIS -- OUT2 [label="builds into"];
  THIS -- OUT3 [label="builds into"];
  THIS -- OUT4 [label="builds into"];
  THIS -- OUT5 [label="builds into"];
  THIS -- CON1 [label="contrasts with" style=dotted];
  THIS -- CON2 [label="contrasts with" style=dotted];
  THIS -- REL1 [label="related"];
  THIS -- REL2 [label="related"];
}
```

## Key Properties

- **Field types map to SQL**: `CharField`→VARCHAR, `IntegerField`→INTEGER, `DateTimeField`→TIMESTAMP
- **Relationships**: `ForeignKey` (many-to-one), `ManyToManyField`, `OneToOneField` with `on_delete` behavior
- **Meta options**: `db_table`, `ordering`, `indexes`, `constraints`, `unique_together`, `verbose_name`
- **Managers**: `objects = Manager()` customizes default queryset; `QuerySet.as_manager()` for chainable managers
- **Deferred loading**: `.only()`, `.defer()` control field selection; `select_related`/`prefetch_related` for JOINs

## Connections

- Built from: [[database-migrations|Database Migrations]] — Schema sync mechanism
- Built from: [[model-fields|Model Fields]] — Field type definitions
- Built from: [[relationship-fields|Relationship Fields]] — FK, M2M, O2O
- Builds into: [[orm-querysets|QuerySet API]] — Filter, annotate, aggregate
- Builds into: [[model-managers|Model Managers]] — Custom query entry points
- Builds into: [[admin-panel|Admin Panel]] — Auto-registers models
- Builds into: [[forms-modelforms|ModelForms]] — Form generation from model
- Builds into: [[django-rest-framework-serializers|DRF Serializers]] — `ModelSerializer`
- Contrasts with: [[sqlalchemy|SQLAlchemy]] — Data Mapper pattern, explicit session, more flexible
- Contrasts with: [[raw-sql|Raw SQL]] — Full control, no abstraction overhead
- Related: [[transactions|Database Transactions]] — `atomic()` blocks
- Related: [[model-signals|Model Signals]] — `pre_save`, `post_delete`, `m2m_changed`

## Edge Cases & Gotchas

- **N+1 queries**: Accessing `post.author.name` in loop → use `select_related('author')`
- **M2M through table**: `ManyToManyField` creates hidden table; `through=` for custom intermediate model
- **Default mutable**: `default=[]` shares list across instances; use `default=list` or `default=lambda: []`
- **Migration reversibility**: `RunSQL`/`RunPython` need reverse code; data migrations can break rollback
- **Abstract base classes**: `abstract = True` in Meta prevents table creation; fields inherited