---
title: "Strategies for Schema design in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Strategies for Schema design in DBMS
Schema design is the process of creating a logical and organized structure for a database, which involves defining tables, columns, relationships, constraints, and other elements that will govern how data is stored and accessed. Effective schema design is important for creating a robust, scalable, and efficient database system.

![schema_3](images/schema_3.jpg)

## Strategies for Schema Design

### 1. Top-Down Strategy

In this strategy, we basically start with a schema that contains a high level of abstraction and then apply successive top-down refinement.

Example: we may specify only a few level entity types and then we specify their attributes and split them into lower-level entity types and relationships. The process of specialization to refine an entity type into a subclass is also an example of this strategy.

### 2. Bottom-Up Strategy

Basically start with basic abstraction and then go on adding to this abstraction.

Example: we may start with attributes and group these into entity types and relationships. We can also add a new relationship among entity types as the design goes ahead. The basic example is the process of generalizing entity types into the higher-level generalized superclass.

### 3. Inside-Out Strategy

This is a special case of a bottom-up strategy when attention is basically focused on a central set of concepts that are most evident. Modeling then basically spreads outward by considering new concepts in the vicinity of existing ones. We could specify a few clearly evident entity types in the schema and continue by adding other entity types and relationships that are related to each other.

### 4. Mixed Strategy

Instead of using any particular strategy throughout the design, the requirements are partitioned according to a top-down strategy and part of the schema is designed for each partition according to a bottom-up strategy after that various schema are combined.

## Way to Create Database

- Identify the purpose and scope of the database: Before designing a database schema, it is important to define the purpose and scope of the database. This will help you determine what kind of data the database needs to store, how it will be used and what types of queries will be performed on the data.
- Normalize the database: Normalization is the process of organizing data into tables and applying rules to ensure data is stored in a consistent and efficient manner. By reducing data redundancy and ensuring data integrity, normalization helps to eliminate anomalies and improve the overall quality of the database.
- Use data types appropriately: Choosing the right data type for each column is important for efficient data storage and retrieval. For example, using numeric data types for numeric data can improve calculation performance, while using date/time data types can help with date/time calculations and sorting.
- Establish relationships between tables: Establishing relationships between tables can help to eliminate data redundancy and improve data consistency. For example, a foreign key can be used to link a record in one table to a record in another table, ensuring that data is consistent across both tables.
- Use constraints to ensure data integrity: Constraints can be used to enforce rules on the data in a database, ensuring that data is accurate and consistent. For example, a primary key constraint can ensure that each record in a table has a unique identifier, while a check constraint can ensure that data meets certain conditions before it is inserted into a table.
- Optimize for performance: Schema design can have a significant impact on database performance. Optimizing indexes, partitioning data and using appropriate data types can all improve query performance and reduce database overhead.

Overall, effective schema design requires a thorough understanding of the data being stored and how it will be used, as well as an understanding of best practices for database design and optimization. By following these strategies, you can create a robust and efficient database schema that meets your needs and supports your business goals.

## Features of Different Strategies for Schema Design

### 1. Normalization

- Divides large tables into smaller, related tables to minimize data redundancy and ensure data consistency
- Reduces the need for multiple updates to maintain consistency
- Eliminates data anomalies, such as update, insertion and deletion anomalies
- Results in a more complex schema with more tables and relationships
- May negatively impact query performance due to the increased number of joins required

### 2. Denormalization

- Adds redundant data to improve query performance by reducing the number of joins required
- Simplifies data access by storing all data in one place
- Can result in data inconsistency if not properly managed
- Increases storage requirements due to the duplicated data
- Simplifies queries by reducing the number of joins required, which can result in faster query execution

### 3. Vertical Partitioning

- Splits a table into smaller tables based on columns to improve query performance
- Reduces I/O operations by only reading relevant columns from disk
- Simplifies data access by storing data in tables with fewer columns
- Can result in a more complex schema with more tables and relationships
- Can negatively impact query performance if a query requires columns from multiple tables

### 4. Horizontal Partitioning

- Splits a table into smaller tables based on rows to improve query performance and scalability
- Simplifies data management by breaking down large tables into smaller, more manageable pieces
- Increases query performance by reducing the amount of data that needs to be scanned
- Can result in a more complex schema with more tables and relationships
- Can negatively impact query performance if a query requires data from multiple partitions

## Constraints in DBMS

- Primary Key Constraint: Ensures that each record in a table is unique. Example: A "StudentID" column in a "Students" table where each student has a unique ID.
- Foreign Key Constraint: Ensures that a value in one table must match a value in another table. Example: An "OrderID" in an "OrderDetails" table must match an "OrderID" in an "Orders" table.
- Unique Constraint: Ensures that all values in a column are different. Example: An "Email" column in a "Users" table where each email address must be unique.
- Not Null Constraint: Ensures that a column cannot have a null (empty) value. Example: A "LastName" column in an "Employees" table where every employee must have a last name.
- Check Constraint: Ensures that all values in a column satisfy a specific condition. Example: An "Age" column in a "Persons" table where the age must be greater than 18.
- Default Constraint:, Provides a default value for a column if no value is specified. Example: A "Status" column in an "Orders" table where the default status is "Pending".

> Read related article - [[schema-integration-in-dbms|Schema Integration in DBMS]]

Read related article - [[schema-integration-in-dbms|Schema Integration in DBMS]]