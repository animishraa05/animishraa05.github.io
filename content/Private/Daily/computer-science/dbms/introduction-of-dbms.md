---
title: "Introduction of DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Introduction of DBMS
DBMS (Database Management System) is a software system that manages, stores, and retrieves data efficiently in a structured format. DBMS acts as a bridge between a central database and multiple clients, including apps and users.

- A DBMS connects the central database with multiple clients (applications and users).
- It allows users to create, update, and query databases efficiently.
- Ensures data integrity, consistency, and security across multiple users and applications.
- Reduces data redundancy and inconsistency through centralized control.
- Supports concurrent data access, transaction management, and automatic backups.
- Uses APIs to handle data requests, ensuring secure and efficient access.

![DBMS](images_dbms.webp)

## Problems with Traditional File-Based Systems

Before the [[Basics|introduction]] of modern DBMS, data was managed using basic file systems on hard drives. While this approach allowed users to store, retrieve and update files as needed, it came with numerous challenges

- Data Redundancy: Duplicate entries across files
- Inconsistency: Conflicting or outdated information
- Difficult Access: Manual file search required
- Poor Security: No control over data access
- Single-User Access: No support for collaboration
- No Backup/Recovery: Data loss was often permanent

A university file-based system storing data in separate files (e.g., Academics, Results, Hostels) often faced these problems.

## Components of DBMS Applications

Any DBMS based applications is made up of six key components that work together to handle data effectively.

![third_window](images_third_window.webp)

### 1. Hardware

- Physical devices like servers, disks, input-output devices (keyboard, monitor, printer).
- Stores and processes data; interfaces between real-world inputs and digital systems.
- Examples: Personal computer hard disk, RAM, network devices used for DBMS operations.

### 2. Software

- Actual DBMS software like MySQL, Oracle, PostgreSQL.
- Includes the database engine, OS, network software, and application tools.
- Translates database access languages into operations.

### 3. Data

- Raw facts stored in structured or unstructured formats.
- Operational Data: Actual user data (e.g., name, age).
- Metadata: Data about data (e.g., storage time, size, data type).
- Core reason DBMS exists—to manage and store data efficiently.

### 4. Procedures

- Instructions and rules for using DBMS effectively.
- Covers setup, login/logout, data validation, backup, access control, and report generation.
- Helps ensure consistent and secure use of the system.

### 5. Database Access Language

- Used to interact with the database (create, read, update, delete data).
- Examples: SQL, MyAccess, Oracle PL/SQL.
- DDL (Data Definition Language) – CREATE, ALTER, DROP
- DML (Data Manipulation Language) – INSERT, UPDATE, DELETE

`CREATE`

`ALTER`

`DROP`

`INSERT`

`UPDATE`

`DELETE`

### 6. People

- Users interacting with DBMS at different levels:
- Database Administrators (DBA) – Manage security, performance, user access.
- Developers – Build applications using the database.
- End Users – Use applications to access the database (e.g., students, employees).

## Types of DBMS

There are several types of Database Management Systems (DBMS), each tailored to different data structures, scalability requirements and application needs. The most common types are as follows:

### 1. Relational Database Management System (RDBMS)

- It organizes data into tables (relations) composed of rows and columns.
- Uses primary keys to uniquely identify rows and foreign keys to establish relationships between tables.
- Queries are written in SQL (Structured Query Language), which allows for efficient data manipulation and retrieval.

Examples: MySQL oracle, Microsoft SQL Server and Postgre SQL.

### 2. NoSQL DBMS

- They are designed to handle large-scale data and provide high performance for scenarios where relational models might be restrictive.
- They store data in various non-relational formats, such as key-value pairs, documents, graphs or columns.
- These flexible data models enable rapid scaling and are well-suited for unstructured or semi-structured data.

Examples: MongoDB, Cassandra, DynamoDB and Redis.

### 3. Object-Oriented DBMS (OODBMS)

- It integrates object-oriented programming concepts into the database environment, allowing data to be stored as objects.
- Supports complex data types and relationships, making it ideal for applications requiring advanced data modeling and real-world simulations.

Examples: ObjectDB, db4o.

### 4. Hierarchical Database

- Organizes data in a tree-like structure, where each record (node) has a single parent and have multiple children.
- This model is similar to a file system with folders and subfolders.
- It is efficient for storing data with a clear hierarchy, such as organizational charts or file directories.
- Navigation is fast and predictable due to the fixed structure.
- It lacks flexibility and difficult to restructure or handle complex many-to-many relationships.

Example: IBM Information Management System (IMS).

### 5. Network Database

- It uses a graph-like model to allow more complex relationships between entities.
- Unlike the hierarchical model, it permits each child to have multiple parents, enabling many-to-many relationships.
- Data is represented using records and sets, where sets define the relationships.
- It is more flexible than the hierarchical model and better suited for applications with complex data linkages.

Example: Integrated Data Store (IDS), TurboIMAGE.

### 6. Cloud-Based Database

- They are hosted on [[26_Cloud_Computing|cloud computing]] platforms like AWS, Azure or Google Cloud.
- They offer on-demand scalability, high availability, automatic backups and remote accessibility.
- These databases can be relational (SQL) or non-relational (NoSQL) and are maintained by cloud service providers, reducing administrative overhead.
- They support modern application requirements, including distributed access and real-time analytics.

Example: Amazon RDS (for SQL), MongoDB Atlas (for NoSQL), Google BigQuery.

## Database Languages

Database languages are specialized sets of commands and instructions used to define, manipulate and control data within a database. Each language type plays a distinct role in database management, ensuring efficient storage, retrieval and security of data. The primary database languages include:

![type_of_dbms_language](images_type_of_dbms_language.webp)

### 1. Data Definition Language (DDL)

DDL is the short name for Data Definition Language, which deals with database schemas and descriptions, of how the data should reside in the database.

- CREATE: to create a database and its objects like (table, [[index]], views, store procedure, function and triggers)
- ALTER: alters the structure of the existing database
- DROP: delete objects from the database
- TRUNCATE: remove all records from a table, including all spaces allocated for the records are removed
- COMMENT: add comments to the data dictionary
- RENAME: rename an object

### 2. Data Manipulation Language (DML)

DML focuses on manipulating the data stored in the database, enabling users to retrieve, add, update and delete data.

- INSERT: insert data into a table
- UPDATE: updates existing data within a table
- DELETE: Delete all records from a database table
- MERGE: UPSERT operation (insert or update)
- CALL: call a PL/SQL or Java subprogram
- EXPLAIN PLAN: interpretation of the data access path
- LOCK TABLE: concurrency Control

### 3. Data Control Language (DCL)

DCL commands manage access permissions, ensuring data security by controlling who can perform certain actions on the database.

- GRANT: Provides specific privileges to a user (e.g., SELECT, INSERT).
- REVOKE: Removes previously granted permissions from a user.

### 4. Transaction Control Language (TCL)

TCL commands oversee transactional data to maintain consistency, reliability and atomicity.

- ROLLBACK: Undoes changes made during a transaction.
- COMMIT: Saves all changes made during a transaction.
- SAVEPOINT: Sets a point within a transaction to which one can later roll back.

### 5. Data Query Language (DQL)

DQL is a subset of SQL used to retrieve data from a database without modifying it. Its main command is SELECT, which allows users to fetch specific information based on their requirements.

## Applications of DBMS

![Database-Applications](images_database-applications.webp)

- Banking: Manages accounts and transactions.
- E-commerce: Tracks products, orders, and customers.
- Healthcare: Stores patient records and diagnoses.
- Education: Handles student grades and schedules.
- Social Media: Manages user profiles and interactions.
- Data Science: Supports analytics and predictions.