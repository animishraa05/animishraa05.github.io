---
concept: Django ORM
aliases: [Object-Relational Mapping, QuerySets]
tags: [dev, django]
created: 2026-08-09
updated: 2026-08-09
---

## Formal Definition

The Django Object-Relational Mapper (ORM) is a layer that abstracts database interactions, allowing developers to query and manipulate relational database tables using Python code and object-oriented paradigms instead of writing raw SQL.

## Explanation

SQL syntax can differ between database engines (PostgreSQL, SQLite, MySQL) and writing raw SQL strings in Python is error-prone. The ORM acts as a translator. You write Python methods like `.filter()`, and the ORM translates that into the correct, optimized SQL for your specific database.

## How It Works

1. Queries are constructed using a model's `Manager` (e.g., `objects`).
2. Method calls (`filter`, `exclude`, `annotate`) return a `QuerySet`.
3. QuerySets are lazy: they don't hit the database until they are evaluated (e.g., iterated over, sliced, or cast to a list).
4. Upon evaluation, the ORM generates SQL and executes it against the database backend.

## Visual Explanation

```mermaid
graph TD
  A[Python: Model.objects.filter()] --> B(Django ORM Translator)
  B --> C[SQL: SELECT * FROM table WHERE...]
  C --> D[(Database)]
```

## Mental Model & Analogy

Think of the ORM as a personal translator in a foreign country. You speak your native language (Python) to the translator, and the translator seamlessly speaks the local language (SQL) to the locals (the Database), handling all the grammatical nuances.

## Implementation & Examples

```python
# Instead of: SELECT * FROM students WHERE age > 20;
adult_students = Student.objects.filter(age__gt=20)
```

## Key Properties

- Lazy evaluation for efficiency.
- Database agnostic (switch DBs without changing query code).
- Protects against SQL injection automatically.

## Connections

- **Built from:** [[django-model|Django Model]] — models are the core of the ORM.
- **Builds into:** [[django-migration|Django Migration]] — schemas are managed by the ORM state.
- **Related:** [[django-view|Django View]] — views use the ORM to fetch data.
- **Related:** [[python-programming-language|Python]] — leverages Python's OOP.

## Edge Cases & Gotchas

- "N+1 query problem": Accessing related objects in a loop without using `select_related` or `prefetch_related` causes severe performance issues.
- Very complex analytical queries might still require raw SQL for performance reasons.