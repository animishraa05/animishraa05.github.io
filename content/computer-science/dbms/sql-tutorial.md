---
title: "SQL Tutorial"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# SQL Tutorial
Structured Query Language (SQL) is the standard language used to interact with relational databases.

- Mainly used to manage data. Whether you want to create, delete, update or read data, SQL provides commands to perform these operations.
- Widely supported across various database systems like MySQL, Oracle, PostgreSQL, SQL Server and many others.
- Mainly works with Relational Databases (data is stored in the form of tables)

## Writing First SQL Query

Before running SQL queries you need to set up a database server like MySQL, PostgreSQL or SQLite. Here, we are going to use MySQL server. Follow below steps to set up a basic SQL Environment:

1. Install MySQL in your system
2. Start MySQL Server
3. Access MySQL Command Line

After your MySQL environment is set up, you can write your SQL program. Below is the example to display " Hello World" using SQL.

#### 1. Create a database named test_db

```
CREATE DATABASE test_db;
```

#### 2. Use the test_db database

```
USE test_db;
```

#### 3. Create a table named greetings

```
CREATE TABLE greetings (    id INT AUTO_INCREMENT PRIMARY KEY,    message VARCHAR(255));
```

#### 3. Insert the message 'Hello, World!' into the greetings table

```
INSERT INTO greetings (message)VALUES ('Hello, World!');
```

#### 4. Retrieve the message from the greetings table

```
SELECT message FROM greetings;
```

![Hello-World](images/hello-world.webp)

> Note: Try replacing "Hello World!" with your name in the SQL query. It's a fun way to see how databases store and display your own data! Give it a try and watch your name pop up!

Note: Try replacing "Hello World!" with your name in the SQL query. It's a fun way to see how databases store and display your own data! Give it a try and watch your name pop up!

## Why Learn SQL?

SQL's [[integration]] with various technologies makes it essential for managing and querying data in databases. Whether it is in traditional relational databases (RDBMS) or modern technologies such as machine learning, AI and blockchain, SQL plays a key role. It works effortlessly with DBMS to help users interact with data, whether stored in structured RDBMS or other types of databases.

- Data Science & Analytics: Used for querying large datasets, data cleaning and analysis. Analysts use SQL to generate reports and insights that inform business decisions.
- Machine Learning & AI: Helps in preparing and managing the data required for training machine learning models and AI algorithms. It is used for data cleaning, transformation, and extraction.
- Web Development: Used to manage user data, e-commerce transactions, and content management in websites and applications built with frameworks like Django, Node.js, and Ruby on Rails.
- Cloud and Big Data: SQL is integrated into cloud-based databases (e.g., Amazon RDS, Microsoft Azure SQL) and Big Data platforms (e.g., Apache Hive) to enable seamless data querying and management.
- Blockchain and Decentralized Systems: In blockchain systems, SQL can be used to manage off-chain data, providing efficient data storage and retrieval alongside decentralized ledger technology

## SQL Basics

Learn the foundational concepts of SQL, essential for anyone working with relational databases. This section covers the syntax, commands, and key elements to start querying and managing data effectively.

- [[Basics|Introduction]]
- Data Types
- Operators
- Commands

## SQL Database

This section guides you through the process of creating and managing databases. Learn how to create, select, rename, and drop databases with practical examples.

- CREATE Database
- DROP Database
- RENAME Database
- SELECT Database

## SQL Tables

Tables are the core data structures in databases, organizing data into rows and columns. This section covers how to create, modify, and manage tables effectively.

- CREATE TABLE
- DROP TABLE
- RENAME TABLE
- TRUNCATE TABLE
- COPY TABLE
- TEMP TABLE
- ALTER TABLE

## SQL Queries

Master writing SQL queries to interact with and manipulate data stored in your tables. This section covers common query types and operations.

- SELECT Statement
- INSERT INTO
- INSERT Multiple Rows
- UPDATE Statement
- DELETE Statement
- DELETE Duplicate Rows

## SQL Clauses

Unlock powerful ways to filter, organize, and group your query results. Clauses help you refine your data extraction.

- WHERE Clause
- WITH Clause
- HAVING Clause
- ORDER By Clause
- Group By Clause
- LIMIT Clause
- Distinct Clause
- FETCH
- Aliases

## SQL Operators

SQL Operators" refers to the fundamental symbols and keywords within the SQL that enable users to perform various operations. Operators let you build complex query conditions.

- Logical Operators
- LIKE Operator
- IN Operator
- NOT Operator
- NOT EQUAL Operator
- IS NULL Operator
- UNION Operator
- UNION ALL Operator
- EXCEPT Operator
- BETWEEN Operator
- ALL and ANY
- INTERSECT Operator
- EXISTS Operator
- CASE Operator

## SQL Aggregate Functions

Whether you are calculating the total sales revenue for a particular product, finding the average age of customers, or determining the highest value in a dataset, SQL Aggregate Functions make these tasks straightforward and manageable.

- Aggregate Function
- Count() Function
- SUM() Function
- MIN() Function
- MAX() Function
- AVG() Function

## Data Constraints

Constraints act as rules or conditions imposed on the data, dictating what values are permissible and what actions can be taken. They play a crucial role in maintaining the quality and coherence of the database by preventing errors.

- NOT NULL Constraints
- Primary Key Constraints
- Foreign Key Constraints
- Composite Key
- Unique Constraints
- Alternate Key
- CHECK Constraints
- DEFAULT Constraints

## SQL Joins

SQL joins serve as the weaver's tool, allowing you to seamlessly merge data from multiple tables based on common threads. So explore this section to learn how to use JOIN command.

- JOIN
- Outer Join
- Left Join
- Right Join
- Full Join
- Cross Join
- Self Join
- UPDATE with JOIN
- DELETE JOIN
- Recursive Join

## SQL Functions

SQL functions offer an efficient and versatile approach to data analysis. Enhance your queries with built-in functions that manipulate data types and perform calculations.

- Date Functions
- String Functions
- Numeric Functions
- Statistical Functions
- JSON Functions
- Conversion Functions
- Datatype Functions
- LTRIM Function
- UPPER Function
- RTRIM Function

## SQL Views

Views simplify complex queries and improve security by controlling data access. Views also act like a helpful security guard, keeping the most sensitive information in the back room, while still allowing access to what's needed.

- CREATE VIEW
- UPDATE VIEW
- RENAME VIEW
- DROP VIEW

## SQL Indexes

Improve query performance by creating indexes that speed up data retrieval.

- Indexes
- Create [[index|Index]]
- Drop [[index|Index]]
- Show Indexes
- Unique [[index|Index]]
- Clustered [[index|Index]] vs Non-Clustered [[index|Index]]

## SQL Subquery

Perform queries within queries to solve complex data retrieval problems. They help in filtering data or performing operations on data that would otherwise require multiple queries.

- Subquery
- Correlated Subqueries
- Nested Queries

## Miscellaneous Topics

Explore advanced and useful SQL concepts to deepen your knowledge

- Wildcards Operators
- Comments
- Pivot and Unpivot
- Trigger
- Hosting
- Performance Tuning
- Stored Procedures
- Transactions
- Sub Queries
- Using Sequences
- Auto Increment
- Window functions
- Cursors
- Common Table Expressions
- Database Tuning
- Dynamic
- Regular Expressions

## Exercises, Interview Questions & Cheat Sheet

This section provides practical exercises and commonly asked interview questions to help strengthen your SQL knowledge. It also includes a cheat sheet for quick reference, making SQL concepts easier to grasp.

- Exercises
- Quiz
- Interview Questions
- Query Interview Questions
- Cheat Sheet
- 30 Days of SQL – From Basic to Advanced

## Advanced SQL & Databases

Advanced SQL topics explore techniques like optimization, complex joins, and working with large-scale databases. This section also covers the use of advanced functions and stored procedures to handle advanced database operations.

### Database Design and Modeling

Database design focuses on creating an efficient database structure that is scalable and meets user requirements. Modeling involves defining relationships, entities, and constraints to ensure data integrity and efficient querying.

- [[introduction-of-er-model|Introduction of ER Model]]
- How to Draw Entity Relationship Diagrams (ERDs)
- [[mapping-from-er-model-to-relational-model|Mapping from ER Model to Relational Model]]
- [[Basics|Introduction]] of Database Normalization
- Functional Dependency and Attribute Closure
- Types of Functional dependencies
- Rules of Inference
- [[normal-forms-in-dbms|Normal Forms in DBMS]]
- [[denormalization-in-databases|Denormalization in Databases]]
- Database Design

### Database Security

Database security protects data from unauthorized access, corruption, and breaches. It includes encryption, authentication, and user privilege management to safeguard sensitive information stored in databases.

- Injection
- Types of SQL Injection
- Data Encryption
- [[database-recovery-techniques-in-dbms|Database Recovery Techniques in DBMS]]
- Backup
- How to Restore SQL Server Database From Backup?

### Database Connectivity

Database connectivity enables applications to interact with databases through established protocols and drivers. This section covers how to establish secure connections and manage database interactions in programming languages like PHP, Python, and Java.

- ORM (Object-Relational Mapping)
- ODM (Object-Document Mapping)
- ODBC (Open Database Connectivity)

> Latest Trend [2025]: SQL Server 2025 introduces AI-driven features directly within the SQL engine. It supports native vector data types and AI model management, allowing developers to run AI tasks directly in SQL without external tools.

Latest Trend [2025]: SQL Server 2025 introduces AI-driven features directly within the SQL engine. It supports native vector data types and AI model management, allowing developers to run AI tasks directly in SQL without external tools.

## Important Links

- SQL Career Path: Roles, Skills & Salaries
- Applications of SQL
- SQL | Multiple Choice Questions
- SQL | Interview Questions
- SQL Interview Questions | Set 1
- SQL Interview Questions | Set 2
- SQL | Commonly asked DBMS interview questions | Set 1
- SQL | [[commonly-asked-dbms-interview-questions-set-2|Commonly asked DBMS interview questions | Set 2]]