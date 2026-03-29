---
title: "Introduction to Database Normalization"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Introduction to Database Normalization
Normalization is an important process in database design that helps improve the database's efficiency, consistency, and accuracy. It makes it easier to manage and maintain the data and ensures that the database is adaptable to changing business needs.

- Database normalisation is the process of organizing the attributes of the database to reduce or eliminate data redundancy (having the same data but at different places).
- Data redundancy unnecessarily increases the size of the database as the same data is repeated in many places. Inconsistency problems also arise during insert, delete, and update operations.
- In the relational model, there exist standard methods to quantify how efficient a database is. These methods are called normal forms, and there are algorithms to convert a given database into normal forms.
- Normalization generally involves splitting a table into multiple ones, which must be linked each time a query is made requiring data from the split tables.

Before Normalization: The table is prone to redundancy and anomalies (insertion, update, and deletion).After Normalization: The data is divided into logical tables to ensure consistency, avoid redundancy and remove anomalies making the database efficient and reliable.

### Problems in the Employee_Department Relation

1. Insertion Anomaly: If a new department is created but no employee is assigned to it yet, we cannot store its location because we need an employee record to insert.
2. Update Anomaly: If the location of the HR department changes, we must update it in multiple rows (for both Nick Wise and Lily Case). If one row is missed, the data becomes inconsistent.
3. Deletion Anomaly: If all employees in the IT department leave, we lose the department information, including its location.
4. Data Redundancy: The department location is repeated for every employee in the same department.

## Need of Normalization

The primary objective for normalizing the relations is to eliminate the below anomalies. Failure to reduce anomalies results in data redundancy, which may threaten data integrity and cause additional issues as the database increases. Normalization consists of a set of procedures that assist you in developing an effective database structure.

- Insertion Anomalies: Insertion anomalies occur when it is not possible to insert data into a database because the required fields are missing or because the data is incomplete. For example, if a database requires that every record has a primary key, but no value is provided for a particular record, it cannot be inserted into the database.

- Deletion anomalies: Deletion anomalies occur when deleting a record from a database and can result in the unintentional loss of data. For example, if a database contains information about customers and orders, deleting a customer record may also delete all the orders associated with that customer.

- Updation anomalies: Updation anomalies occur when modifying data in a database and can result in inconsistencies or errors. For example, if a database contains information about employees and their salaries, updating an employee’s salary in one record but not in all related records could lead to incorrect calculations and reporting.

## Features of Database Normalization

- Elimination of Data Redundancy: One of the main features of normalization is to eliminate the data redundancy that can occur in a database. Data redundancy refers to the repetition of data in different parts of the database. Normalization helps in reducing or eliminating this redundancy, which can improve the efficiency and consistency of the database.

- Ensuring Data Consistency: Normalization helps in ensuring that the data in the database is consistent and accurate. By eliminating redundancy, normalization helps in preventing inconsistencies and contradictions that can arise due to different versions of the same data.

- Simplification of Data Management: Normalization simplifies the process of managing data in a database. By breaking down a complex data structure into simpler tables, normalization makes it easier to manage the data, update it, and retrieve it.

- Improved Database Design: Normalization helps in improving the overall design of the database. By organizing the data in a structured and systematic way, normalization makes it easier to design and maintain the database. It also makes the database more flexible and adaptable to changing business needs.

- Avoiding Update Anomalies: Normalization helps in avoiding update anomalies, which can occur when updating a single record in a table affects multiple records in other tables. Normalization ensures that each table contains only one type of data and that the relationships between the tables are clearly defined, which helps in avoiding such anomalies.

- Standardization: Normalization helps in standardizing the data in the database. By organizing the data into tables and defining relationships between them, normalization helps in ensuring that the data is stored in a consistent and uniform manner.

## Normal Forms in DBMS

| Normal Forms | Description of Normal Forms |
| --- | --- |
| First Normal Form (1NF) | A relation is in first normal form if every attribute in that relation is single-valued attribute. |
| Second Normal Form (2NF) | A relation that is in First Normal Form and every non-primary-key attribute is fully functionally dependent on the primary key, then the relation is in Second Normal Form (2NF). |
| Third Normal Form (3NF) | A relation is in the third normal form, if there is no transitive dependency for non-prime attributes as well as it is in the second normal form. A relation is in 3NF if at least one of the following conditions holds in every non-trivial function dependency X –> Y.X is a super key.Y is a prime attribute (each element of Y is part of some candidate key). |
| Boyce-Codd Normal Form (BCNF) | For BCNF the relation should satisfy the below conditionsThe relation should be in the 3rd Normal Form.X should be a super-key for every functional dependency (FD) X−>Y in a given relation. |
| Fourth Normal Form (4NF) | A relation R is in 4NF if and only if the following conditions are satisfied: It should be in the Boyce-Codd Normal Form (BCNF).The table should not have any Multi-valued Dependency. |
| Fifth Normal Form (5NF) | A relation R is in 5NF if and only if it satisfies the following conditions:R should be already in 4NF. It cannot be further non loss decomposed (join dependency) |

Normal Forms

Description of Normal Forms

First Normal Form (1NF)

A relation is in first normal form if every attribute in that relation is single-valued attribute.

Second Normal Form (2NF)

A relation that is in First Normal Form and every non-primary-key attribute is fully functionally dependent on the primary key, then the relation is in Second Normal Form (2NF).

Third Normal Form (3NF)

A relation is in the third normal form, if there is no transitive dependency for non-prime attributes as well as it is in the second normal form. A relation is in 3NF if at least one of the following conditions holds in every non-trivial function dependency X –> Y.

- X is a super key.
- Y is a prime attribute (each element of Y is part of some candidate key).

Boyce-Codd Normal Form (BCNF)

For BCNF the relation should satisfy the below conditions

- The relation should be in the 3rd Normal Form.
- X should be a super-key for every functional dependency (FD) X−>Y in a given relation.

Fourth Normal Form (4NF)

A relation R is in 4NF if and only if the following conditions are satisfied:

- It should be in the Boyce-Codd Normal Form (BCNF).
- The table should not have any Multi-valued Dependency.

Fifth Normal Form (5NF)

A relation R is in 5NF if and only if it satisfies the following conditions:

- R should be already in 4NF.
- It cannot be further non loss decomposed (join dependency)