---
title: "Relational Model in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Relational Model in DBMS
The Relational Model organizes data using tables (relations) consisting of rows and columns.

- The relational model represents how data is stored and managed in Relational Databases where data is organized into tables, each known as a relation.
- Each row of a table represents an entity or record and each column represents a particular attribute of that entity.
- The relational model transforms conceptual designs from ER diagrams into implementable structures. These structures are used in relational database systems like Oracle SQL and MySQL.

Example: Consider a relation STUDENT with attributes ROLL_NO, NAME, ADDRESS, PHONE and AGE shown in the table.

![relational_model](images_relational_model.webp)

## Key Terms in the Relational Model

1. Attribute: Attributes are the properties that define an entity. For example, ROLL_NO, NAME, ADDRESS etc.
2. Relation Schema: A relation schema defines the structure of the relation and represents the name of the relation with its attributes. For example, STUDENT (ROLL_NO, NAME, ADDRESS, PHONE and AGE) is the relation schema for STUDENT. If a schema has more than 1 relation it is called Relational Schema.
3. Tuple: A Tuple represents a row in a relation. Each tuple contains a set of attribute values that describe a particular entity. For example, (1, RAM, DELHI, 9455123451, 18) is a tuple in the STUDENT table.
4. Relation Instance: The set of tuples of a relation at a particular instance of time is called a relation instance. It can change whenever there is an insertion, deletion or update in the database.
5. Degree: The number of attributes in the relation is known as the degree of the relation. For example, The STUDENT relation has a degree of 5, as it has 5 attributes.
6. Cardinality: The number of tuples in a relation is known as cardinality. For example, The STUDENT relation defined above has cardinality 4.
7. NULL Values: The value which is not known or unavailable is called a NULL value. It is represented by NULL. For example, PHONE of STUDENT having ROLL_NO 4 is NULL.

## Types of Keys in the Relational Model

1. Primary Key: A Primary Key uniquely identifies each tuple in a relation. It must contain unique values and cannot have NULL values.
2. Candidate Key: A Candidate Key is a set of attributes that can uniquely identify a tuple in a relation.
3. Super Key: A Super Key is a set of attributes that can uniquely identify a tuple.
4. Foreign Key: A Foreign Key is an attribute in one relation that refers to the primary key of another relation.
5. Composite Key: A Composite Key is formed by combining two or more attributes to uniquely identify a tuple.

> Read more about - [[keys-in-relational-model|Keys in Relational Model]]

Read more about - [[keys-in-relational-model|Keys in Relational Model]]

## Relational Model Notation

- Relation schema R of degree n is denoted by by R(A1, A2, ...,An).
- Uppercase letters Q, R, S denote relation names.
- Lowercase letters q, r, s denote relation states.
- Letters t, u, v denote tuples.
- In general, the name of a relation schema such as STUDENT also indicates the current set of tuples in that relation.
- An attribute A can be qualified with the relation name R to which it belongs by using the dot notation R.A for example, STUDENT.Name or STUDENT.Age.
- An n-tuple t in a relation r(R) is represented as t = <v1, v2,..., vn> where vi is the value corresponding to the attribute Ai. The value vi for attribute Ai in tuple t can be accessed using t[Ai] or t.Ai.

## Characteristics of the Relational Model

- Data Representation: Data is organized in tables (relations), with rows (tuples) representing records and columns (attributes) representing data fields.
- Atomic Values: Each attribute in a table contains atomic values, meaning no multi-valued or nested data is allowed in a single cell.
- Unique Keys: Every table has a primary key to uniquely identify each record, ensuring no duplicate rows.
- Attribute Domain: Each attribute has a defined domain, specifying the valid data types and constraints for the values it can hold.
- Data Independence: The model ensures logical and physical data independence, allowing changes in the database schema without affecting [[10_The_Application_Layer|the application layer]].
- Relational Operations: Supports operations like selection, projection, join, union and intersection, enabling powerful data retrieval manipulation.
- Data Consistency: Ensures data consistency through constraints, reducing redundancy and anomalies.
- Set-Based Representation: Tables in the relational model are treated as sets and operations follow mathematical [[set-theory|set theory]] principles.

## Constraints in Relational Model

While designing the Relational Model, we define some conditions which must hold for data present in the database are called Constraints. These constraints are checked before performing any operation (insertion, deletion and updation) in the database. If there is a violation of any of the constraints, the operation will fail.

### 1. Domain Constraints

Domain Constraints ensure that the value of each attribute A in a tuple must be an atomic value derived from its specified domain, dom(A). Domains are defined by the data types associated with the attributes. Common data types include:

- Numeric types: Includes integers (short, regular and long) for whole numbers and real numbers (float, double-precision) for decimal values, allowing precise calculations.
- Character types: Consists of fixed-length (CHAR) and variable-length (VARCHAR, TEXT) strings for storing text data of various sizes.
- Boolean values: Stores true or false values, often used for flags or conditional checks in databases.
- Specialized types: Includes types for date (DATE), time (TIME), timestamp (TIMESTAMP) and money (MONEY), used for precise handling of time-related and financial data.

### 2. Key Integrity

Every relation in the database should have at least one set of attributes that defines a tuple uniquely. Those set of attributes is called keys. e.g.; ROLL_NO in STUDENT is key. No two students can have the same roll number. So a key has two properties:

- It should be unique for all tuples.
- It can’t have NULL values.

### 3. Referential Integrity Constraints

When one attribute of a relation can only take values from another attribute of the same relation or any other relation, it is called referential integrity. Let us suppose we have 2 relations Table: STUDENT

| ROLL_NO | NAME | ADDRESS | PHONE | AGE | BRANCH_CODE |
| --- | --- | --- | --- | --- | --- |
| 1 | RAM | DELHI | 9455123451 | 18 | CS |
| 2 | RAMESH | GURGAON | 9652431543 | 18 | CS |
| 3 | SUJIT | ROHTAK | 9156253131 | 20 | ECE |
| 4 | SURESH | DELHI |  | 18 | IT |

Table: BRANCH

| BRANCH_CODE | BRANCH_NAME |
| --- | --- |
| CS | COMPUTER SCIENCE |
| IT | INFORMATION TECHNOLOGY |
| ECE | ELECTRONICS AND COMMUNICATION ENGINEERING |
| CV | CIVIL ENGINEERING |

Explanation: BRANCH_CODE of STUDENT can only take the values which are present in BRANCH_CODE of BRANCH which is called referential integrity constraint. The relation which is referencing another relation is called REFERENCING RELATION (STUDENT in this case) and the relation to which other relations refer is called REFERENCED RELATION (BRANCH in this case).

## Anomalies in the Relational Model

An anomaly is an irregularity or something which deviates from the expected or normal state. When designing databases, we identify three types of anomalies: Insert, Update, and Delete.

- Insertion Anomaly in Referencing Relation: We can’t insert a row in REFERENCING RELATION if referencing attribute’s value is not present in the referenced attribute value. e.g.; Insertion of a student with BRANCH_CODE ‘ME’ in STUDENT relation will result in an error because ‘ME’ is not present in BRANCH_CODE of BRANCH.
- Deletion/ Updation Anomaly in Referenced Relation: We can’t delete or update a row from REFERENCED RELATION if the value of REFERENCED ATTRIBUTE is used in the value of REFERENCING ATTRIBUTE. For example, If we try to delete a tuple from BRANCH having BRANCH_CODE ‘CS’, it will result in an error because ‘CS’ is referenced by BRANCH_CODE of STUDENT, but if we try to delete the row from BRANCH with BRANCH_CODE CV, it will be deleted as the value is not been used by referencing relation.

> Read more about - Anomalies in the Relational Model

Read more about - Anomalies in the Relational Model

## Codd Rules in Relational Model

E.F. Codd, the creator of the relational model, proposed 12 rules (known as Codd’s 12 Rules) that define what constitutes a relational database system. These rules emphasize the importance of data independence, consistency and structure.

### Key Codd’s Rules

- Rule 1: The information rule : All information in a relational database is represented logically in tables (relations).
- Rule 2: The guaranteed access rule : Every data element is accessible by using a combination of table name, primary key and attribute name.
- Rule 5: The powerful language rule : A relational DBMS should have a comprehensive language capable of expressing all relational queries.

## Advantages of the Relational Model

- Simple model: Relational Model is simple and easy to use in comparison to other languages.
- Flexible: Relational Model is more flexible than any other relational model present.
- Secure: Relational Model is more secure than any other relational model.
- Data Accuracy: Data is more accurate in the relational data model.
- Data Integrity: The integrity of the data is maintained in the relational model.
- Operations can be Applied Easily: It is better to perform operations in the relational model.

## Disadvantages of the Relational Model

- Performance: The relational model can experience performance issues with very large databases.
- Complexity for Complex Data: The model struggles with hierarchical or complex data relationships, which might be better handled with other models like the Graph or Document model.
- Normalization Overhead: Extensive use of normalization can result in complex queries and slower performance.

> Read related article- Strategies for schema design

Read related article- Strategies for schema design