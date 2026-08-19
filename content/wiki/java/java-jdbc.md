---
concept: Java JDBC
aliases: [Java Database Connectivity, Database Driver, Connection Pooling]
tags: [dev, java]
created: 2026-05-13
updated: 2026-05-13
sources_count: 2
last_source: java3.md
---

## The Problem

Applications need to store and retrieve data from databases, but each database vendor has its own protocol and API. Without a standard abstraction, switching databases or supporting multiple databases would require rewriting all data access code.

## Core Idea

**Java Database Connectivity (JDBC)** is a standard API that allows Java applications to interact with any relational database through a common interface. Database vendors provide **JDBC drivers** that implement the API. The core workflow is: connect → create statement → execute query → process results → close.

## How It Works

The application loads a JDBC driver (e.g., `com.mysql.cj.jdbc.Driver`), gets a `Connection` via `DriverManager.getConnection()`, creates a `Statement` or `PreparedStatement`, executes SQL, and processes the `ResultSet`. `PreparedStatement` prevents SQL injection by pre-compiling queries with parameter placeholders.

## Visual Explanation

```dot
digraph java_jdbc {
  rankdir=TB
  node [shape=box style=filled fillcolor="#f0f4ff" fontname="Helvetica" fontsize=12]
  edge [fontname="Helvetica" fontsize=10]

  App [label="Java Application"]
  JDBC [label="JDBC API\n(java.sql.*)" fillcolor="#ffe5cc"]
  Driver [label="JDBC Driver\n(e.g., MySQL Connector/J)"]
  DB [label="Database\n(MySQL, PostgreSQL, etc.)" fillcolor="#d4edda"]
  Steps [label="JDBC Workflow" shape=plaintext]
  S1 [label="1. Load driver"]
  S2 [label="2. Get Connection"]
  S3 [label="3. Create Statement"]
  S4 [label="4. Execute Query"]
  S5 [label="5. Process ResultSet"]
  S6 [label="6. Close resources"]

  App -> JDBC
  JDBC -> Driver
  Driver -> DB
  Steps -> S1 -> S2 -> S3 -> S4 -> S5 -> S6
}
```

## Semantic Network

```dot
graph semantic_jdbc {
  layout=neato
  node [shape=ellipse fontname="Helvetica" fontsize=11 style=filled]
  edge [fontname="Helvetica" fontsize=9]

  THIS [label="JDBC" fillcolor="#ffd700" fontsize=13 style="filled,bold"]
  IO [label="File I/O" fillcolor="#cce5ff"]
  EXC [label="Exception Handling" fillcolor="#cce5ff"]
  SQL [label="SQL" fillcolor="#d4edda"]
  OOP [label="OOP in Java" fillcolor="#f0f0f0"]

  THIS -- IO [label="related"]
  THIS -- EXC [label="built from"]
  THIS -- SQL [label="builds into"]
  THIS -- OOP [label="related"]
}
```

## Key Properties

- **Driver types**: Type 1 (JDBC-ODBC bridge), Type 2 (native API), Type 3 (network protocol), Type 4 (pure Java, most common)
- **Statement types**: Statement (static SQL), PreparedStatement (pre-compiled, prevents SQL injection), CallableStatement (stored procedures)
- **CRUD operations**: Create (INSERT), Read (SELECT), Update (UPDATE), Delete (DELETE) via executeQuery() / executeUpdate()
- **Connection pooling**: `DataSource` with connection pooling avoids expensive connection creation per request
- **Transaction management**: `Connection.setAutoCommit(false)` enables manual transaction control with commit() and rollback()

## Connections

- **Built from:** [[java-try-catch-finally|Try-Catch-Finally]] — JDBC resources (Connection, Statement, ResultSet) must be closed in finally blocks
- **Built from:** [[java-exception-hierarchy|Java Exception Hierarchy]] — JDBC methods throw SQLException (checked)
- **Builds into:** [[java-socket-programming|Java Socket Programming]] — JDBC drivers communicate with databases over network sockets
- **Related:** [[java-socket-programming|Java Socket Programming]] — JDBC drivers communicate with databases over network sockets

## Edge Cases & Gotchas

- **Resource leaks**: Never forget to close Connection, Statement, and ResultSet — use try-with-resources
- **SQL injection**: Never concatenate user input into SQL — always use PreparedStatement
- **Connection pool exhaustion**: Long-running transactions or missing close() calls exhaust the pool
- **Driver class loading**: In modern JDBC 4+, drivers auto-register via ServiceLoader (no Class.forName() needed)

## Sources

- [[java1-summary|Java Tutorial — Source Summary]] — JDBC
- [[java3-summary|Advanced Java Tutorial — Source Summary]] — CRUD, statements, transactions
