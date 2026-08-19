---
title: "SQL Queries on Clustered and Non-Clustered Indexes"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# SQL Queries on Clustered and Non-Clustered Indexes
Indexes in SQL play a pivotal role in enhancing database performance by enabling efficient data retrieval without scanning the entire table. The two primary types of indexes Clustered [[index|Index]] and Non-Clustered [[index|Index]] serve distinct purposes in optimizing query performance.

## Indexes in SQL

Indexing in SQL is similar to the [[index]] page in a book, they allow the database to quickly locate data without scanning the entire table. Without indexing, SQL Server performs a full table scan, which can be time-consuming for large datasets. By creating indexes, SQL Server optimizes query execution, reducing retrieval time. In the same way, a table's [[index]] allows us to locate the exact data without scanning the whole table.

### Key Benefits of Indexing

- Faster SELECT queries.
- Efficient data access for UPDATE, DELETE, and JOIN operations.
- Minimizes disk I/O operations.

### Types of Indexes in SQL

- Clustered [[index]]
- Non-clustered [[index]]

## 1. Clustered Index

A clustered [[index]] is the type of indexing that establishes a physical sorting order of rows. The data rows are stored directly in the order of the indexed column(s). Each table can have only one clustered [[index]] because it dictates the data’s physical storage. A clustered [[index]] is like a Dictionary in which the sorting order is alphabetical and there is no separate [[index]] page.

Suppose we have a table Student_info which contains ROLL_NO as a primary key, then the clustered [[index]] which is self-created on that primary key will sort the Student_info table as per ROLL_NO.

Example: Creating a Clustered [[index|Index]]

> CREATE TABLE Student_info(ROLL_NO int(10) primary key,NAME varchar(20),DEPARTMENT varchar(20),);INSERT INTO Student_info values(1410110405, 'H Agarwal', 'CSE');INSERT INTO Student_info values(1410110404, 'S Samadder', 'CSE');INSERT INTO Student_info values(1410110403, 'MD Irfan', 'CSE'); SELECT * FROM Student_info;

CREATE TABLE Student_info(ROLL_NO int(10) primary key,NAME varchar(20),DEPARTMENT varchar(20),);INSERT INTO Student_info values(1410110405, 'H Agarwal', 'CSE');INSERT INTO Student_info values(1410110404, 'S Samadder', 'CSE');INSERT INTO Student_info values(1410110403, 'MD Irfan', 'CSE'); SELECT * FROM Student_info;

Output:

| ROLL_NO | NAME | DEPARTMENT |
| --- | --- | --- |
| 1410110403 | MD Irfan | CSE |
| 1410110404 | S Samadder | CSE |
| 1410110405 | H Agarwal | CSE |

ROLL_NO

NAME

DEPARTMENT

1410110403

MD Irfan

CSE

1410110404

S Samadder

CSE

1410110405

H Agarwal

CSE

Explanation:

- The ROLL_NO column is the primary key, making it the Clustered [[index|Index]] by default.
- Rows are stored in ascending order of ROLL_NO.

### Dropping and Creating a Custom Clustered Index

If we want to create a Clustered [[index]] on another column, first we have to remove the primary key, and then we can remove the previous [[index]]. Note that defining a column as a primary key makes that column the Clustered [[index|Index]] of that table. To create a clustered [[index]] on a different column:

1. Remove the existing primary key (if any).
2. Drop the previous clustered [[index]].

Syntax:

> DROP [[index|INDEX]] table_name.index_name;CREATE CLUSTERED [[index|INDEX]] IX_table_name_column_nameON table_name (column_name ASC);

DROP [[index|INDEX]] table_name.index_name;CREATE CLUSTERED [[index|INDEX]] IX_table_name_column_nameON table_name (column_name ASC);

Example:

> CREATE CLUSTERED [[index|INDEX]] IX_Student_info_NAMEON Student_info (NAME ASC);

CREATE CLUSTERED [[index|INDEX]] IX_Student_info_NAMEON Student_info (NAME ASC);

## 2. Non-Clustered Index

Non-Clustered [[index]] is an [[index]] structure separate from the data stored in a table that reorders one or more selected columns. The non-clustered [[index]] is created to improve the performance of frequently used queries not covered by a clustered [[index]]. It's like a textbook, the [[index]] page is created separately at the beginning of that book.

Example: Creating a Non-Clustered [[index|Index]] - We start by creating the Student_info table and inserting some sample data.

> CREATE TABLE Student_info(ROLL_NO int(10),NAME varchar(20),DEPARTMENT varchar(20),);INSERT INTO Student_info values(1410110405, 'H Agarwal', 'CSE');INSERT INTO Student_info values(1410110404, 'S Samadder', 'CSE');INSERT INTO Student_info values(1410110403, 'MD Irfan', 'CSE');SELECT * FROM Student_info;

CREATE TABLE Student_info(ROLL_NO int(10),NAME varchar(20),DEPARTMENT varchar(20),);INSERT INTO Student_info values(1410110405, 'H Agarwal', 'CSE');INSERT INTO Student_info values(1410110404, 'S Samadder', 'CSE');INSERT INTO Student_info values(1410110403, 'MD Irfan', 'CSE');SELECT * FROM Student_info;

Output:

| ROLL_NO | NAME | DEPARTMENT |
| --- | --- | --- |
| 1410110405 | H Agarwal | CSE |
| 1410110404 | S Samadder | CSE |
| 1410110403 | MD Irfan | CSE |

ROLL_NO

NAME

DEPARTMENT

1410110405

H Agarwal

CSE

1410110404

S Samadder

CSE

1410110403

MD Irfan

CSE

Syntax:

> create NonClustered [[index]] IX_table_name_column_name on table_name (column_name ASC)

create NonClustered [[index]] IX_table_name_column_name on table_name (column_name ASC)

We will create a Non-Clustered [[index|Index]] on the NAME column to improve query performance when searching by name. Here is the SQL Query for the same

Query:

> create NonClustered [[index]] IX_Student_info_NAME on Student_info (NAME ASC)

create NonClustered [[index]] IX_Student_info_NAME on Student_info (NAME ASC)

Output:

| NAME | ROW_ADDRESS |
| --- | --- |
| H Agarwal | 1 |
| MD Irfan | 3 |
| S Samadder | 2 |

NAME

ROW_ADDRESS

H Agarwal

MD Irfan

S Samadder

## Difference between Clustered and Non-clustered Index

| Aspect | Clustered [[index|Index]] | Non-Clustered [[index|Index]] |
| --- | --- | --- |
| Data Storage Order | Determines the physical order of data in the table. | Does not affect the physical order of data. |
| Number of Indexes | Only one per table. | Multiple indexes can be created on a table. |
| [[index|Index]] Structure | The [[index]] is the table; data rows are stored in the [[index]] order. | The [[index]] is a separate structure with pointers to data rows. |
| Performance | Optimized for range queries and ordered data retrieval. | Useful for quick lookups and searches on non-primary key columns. |
| Primary Key Default | If no clustered [[index]] is specified, the primary key usually becomes the clustered [[index]]. | Can be created on any column, not necessarily a primary key. |
| Flexibility | Less flexible due to the single ordering constraint. | More flexible as multiple non-clustered indexes can be created. |
| Use Case | Ideal for tables where data is frequently retrieved in a sorted order or requires range queries. | Ideal for optimizing search queries on columns that are not the primary key or clustered [[index]]. |

## Optimizing Queries with Clustered and Non-Clustered Indexes

Below are detailed examples of SQL queries and the advantages of using Clustered Indexes and Non-Clustered Indexes, along with practical scenarios to illustrate their impact on query performance.

### 1. SELECT Queries with WHERE Clause

Clustered [[index|Index]]: When executing a SELECT query with a WHERE clause on a table with a Clustered [[index|Index]], the database engine uses the [[index]] to directly locate rows matching the condition, minimizing disk I/O.

Example:

> -- Create a table with a clustered [[index]] on ROLL_NOCREATE TABLE Student_info ( ROLL_NO INT PRIMARY KEY, NAME VARCHAR(20), DEPARTMENT VARCHAR(20));INSERT INTO Student_info VALUES(1410110405, 'H Agarwal', 'CSE'),(1410110404, 'S Samadder', 'CSE'),(1410110403, 'MD Irfan', 'CSE');-- Query using the clustered indexSELECT * FROM Student_infoWHERE ROLL_NO = 1410110404;

-- Create a table with a clustered [[index]] on ROLL_NOCREATE TABLE Student_info ( ROLL_NO INT PRIMARY KEY, NAME VARCHAR(20), DEPARTMENT VARCHAR(20));INSERT INTO Student_info VALUES(1410110405, 'H Agarwal', 'CSE'),(1410110404, 'S Samadder', 'CSE'),(1410110403, 'MD Irfan', 'CSE');-- Query using the clustered indexSELECT * FROM Student_infoWHERE ROLL_NO = 1410110404;

Output:

| ROLL_NO | NAME | DEPARTMENT |
| --- | --- | --- |
| 1410110404 | S Samadder | CSE |

Non-Clustered [[index|Index]]: If a Non-Clustered [[index|Index]] is created on the NAME column, the query optimizer uses the [[index]] to locate matching rows efficiently.

Example:

> -- Create a non-clustered [[index]] on NAMECREATE NONCLUSTERED [[index|INDEX]] IX_Student_info_NAMEON Student_info (NAME ASC);-- Query using the non-clustered indexSELECT * FROM Student_infoWHERE NAME = 'H Agarwal';

-- Create a non-clustered [[index]] on NAMECREATE NONCLUSTERED [[index|INDEX]] IX_Student_info_NAMEON Student_info (NAME ASC);-- Query using the non-clustered indexSELECT * FROM Student_infoWHERE NAME = 'H Agarwal';

Output:

| ROLL_NO | NAME | DEPARTMENT |
| --- | --- | --- |
| 1410110405 | H Agarwal | CSE |

### 2. UPDATE Queries

Clustered [[index|Index]]: When updating a row in a table with a Clustered [[index|Index]], the database can quickly locate the row to modify based on the indexed column.

Example:

> -- Update the DEPARTMENT of a specific ROLL_NOUPDATE Student_infoSET DEPARTMENT = 'ECE'WHERE ROLL_NO = 1410110403;

-- Update the DEPARTMENT of a specific ROLL_NOUPDATE Student_infoSET DEPARTMENT = 'ECE'WHERE ROLL_NO = 1410110403;

Output:

| ROLL_NO | NAME | DEPARTMENT |
| --- | --- | --- |
| 1410110403 | MD Irfan | ECE |

Non-Clustered [[index|Index]]: If the UPDATE query references columns that are not part of the clustered [[index]], SQL Server may need to perform additional disk writes to update the non-clustered [[index]] as well.

Example:

> -- Update NAME for a specific ROLL_NOUPDATE Student_infoSET NAME = 'Harsh Agarwal'WHERE ROLL_NO = 1410110405;

-- Update NAME for a specific ROLL_NOUPDATE Student_infoSET NAME = 'Harsh Agarwal'WHERE ROLL_NO = 1410110405;

Output:

| ROLL_NO | NAME | DEPARTMENT |
| --- | --- | --- |
| 1410110405 | Harsh Agarwal | CSE |
| 1410110404 | S Samadder | CSE |
| 1410110403 | MD Irfan | CSE |

### 3. JOIN Queries

Clustered [[index|Index]]: When performing a JOIN operation between two large tables, SQL Server can use the clustered [[index]] on the join column(s) to efficiently match the rows from both tables. This can significantly reduce the time required to complete the query.

Example:

> -- Create another table for joinCREATE TABLE Course_enrollments ( ROLL_NO INT, COURSE_NAME VARCHAR(20));INSERT INTO Course_enrollments VALUES(1410110405, 'Data Structures'),(1410110404, 'Algorithms'),(1410110403, 'Databases');-- Join querySELECT s.ROLL_NO, s.NAME, e.COURSE_NAMEFROM Student_info sJOIN Course_enrollments eON s.ROLL_NO = e.ROLL_NO;

-- Create another table for joinCREATE TABLE Course_enrollments ( ROLL_NO INT, COURSE_NAME VARCHAR(20));INSERT INTO Course_enrollments VALUES(1410110405, 'Data Structures'),(1410110404, 'Algorithms'),(1410110403, 'Databases');-- Join querySELECT s.ROLL_NO, s.NAME, e.COURSE_NAMEFROM Student_info sJOIN Course_enrollments eON s.ROLL_NO = e.ROLL_NO;

Output:

| ROLL_NO | NAME | COURSE_NAME |
| --- | --- | --- |
| 1410110405 | H Agarwal | Data Structures |
| 1410110404 | S Samadder | Algorithms |
| 1410110403 | MD Irfan | Databases |

Non-Clustered [[index|Index]]: If the JOIN operation references columns that are not part of the clustered [[index]], SQL Server can use a non-clustered [[index]] to find the matching rows. However, this may require additional disk reads and slow down the query.