---
title: "Keys in Relational Model"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Keys in Relational Model
Keys are fundamental elements of the relational database model that ensure uniqueness, data integrity, and efficient data access.

- They uniquely identify each row in a table.
- They prevent data duplication and maintain consistency.
- They create relationships between different tables.

![different_kinds_of_keys](images_different_kinds_of_keys.webp)

## Importance of Keys in DBMS

Keys are important in a Database Management System (DBMS) for several reasons:

- Uniqueness: Keys ensure that each record in a table is unique and can be identified distinctly.
- Data Integrity: Keys prevent data duplication and maintain the consistency of the data.
- Efficient Data Retrieval: Keys help in creating relationships between tables, allowing faster queries and better data organization.

Without keys, managing large databases would become difficult, and data retrieval would be slow and error-prone.

## Types of Database Keys

### 1. Super Key

The set of one or more attributes (columns) that can uniquely identify a tuple (record) is known as Super Key. It may include extra attributes that aren't important for uniqueness but still uniquely identify the row. For Example, STUD_NO, (STUD_NO, STUD_NAME), etc.

- A super key is a group of single or multiple keys that uniquely identifies rows in a table. It supports NULL values in rows.
- A super key can contain extra attributes that aren’t necessary for uniqueness.
- For example, if the "STUD_NO" column can uniquely identify a student, adding "SNAME" to it will still form a valid super key, though it's unnecessary.

Example: Consider the STUDENT table

![Screenshot-2026-01-13-155330](images_screenshot-2026-01-13-155330.png)

A super key could be a combination of STUD_NO and PHONE, as this combination uniquely identifies a student.

![Relation between Primary Key, Candidate Key and Super Key](images_relation-between-primary-key-candidate-key-and-sup.jpg)

### 2. Candidate Key

The minimal set of attributes that can uniquely identify a tuple is known as a candidate key. For Example, STUD_NO in STUDENT relation.

- A candidate key is a minimal super key, meaning it can uniquely identify a record but contains no extra attributes.
- It is a super key with no repeated data is called a candidate key.
- The minimal set of attributes that can uniquely identify a record.
- A candidate key must contain unique values, ensuring that no two rows have the same value in the candidate key’s columns.
- Every table must have at least a single candidate key.
- A table can have multiple candidate keys but only one primary key.

Example: For the STUDENT table below, STUD_NO can be a candidate key, as it uniquely identifies each record.

![Screenshot-2026-01-13-155330](images_screenshot-2026-01-13-155330.png)

Table: STUDENT_COURSE

![Screenshot-2026-01-13-155747](images_screenshot-2026-01-13-155747.png)

A composite candidate key example: {STUD_NO, COURSE_NO} can be a candidate key for a STUDENT_COURSE table.

### 3. Primary Key

A primary key is chosen from the set of candidate keys to uniquely identify each record in a table. For example, in the STUDENT table, both STUD_NO and STUD_PHONE can be candidate keys, but STUD_NO is selected as the primary key.

- It uniquely identifies every tuple (row) and does not allow duplicate values.
- It cannot be NULL, as each record must have a valid identifier.
- It may be single-column or composite (made of multiple columns).
- Databases often organize data using the primary key to allow faster access and searching.

Example: The STUDENT table has the structure Student(STUD_NO, SNAME, ADDRESS, PHONE), where STUD_NO is the primary key.

![Screenshot-2026-01-13-155330](images_screenshot-2026-01-13-155330.png)

### 4. Alternate Key

An alternate key is any candidate key in a table that is not chosen as the primary key. In other words, all the keys that are not selected as the primary key are considered alternate keys.

- An alternate key is also referred to as a secondary key because it can uniquely identify records in a table, just like the primary key.
- An alternate key can consist of one or more columns (fields) that can uniquely identify a record, but it is not the primary key

Example: In the STUDENT table, both STUD_NO and PHONE are candidate keys. If STUD_NO is chosen as the primary key, then PHONE would be considered an alternate key.

![Primary Key, Candidate Key and Alternate Key](images_primary-key-candidate-key-and-alternate-key.png)

### 5. Foreign Key

A foreign key is an attribute in one table that refers to the primary key in another table. The table that contains the foreign key is called the referencing table and the table that is referenced is called the referenced table.

![Foreign-keys](images_foreign-keys.png)

- A foreign key in one table points to the primary key in another table, establishing a relationship between them.
- It helps connect two or more tables, enabling you to create relationships between them. This is important for maintaining data integrity and preventing data redundancy.
- They act as a cross-reference between the tables.

Example: Consider the STUDENT_COURSE table

![Screenshot-2026-01-13-155747](images_screenshot-2026-01-13-155747.png)

- STUD_NO in the STUDENT_COURSE table is a foreign key that refers to the STUD_NO primary key of the STUDENT table.
- Unlike a primary key, a foreign key can contain duplicate values and may be NULL. For example, STUD_NO appears multiple times in STUDENT_COURSE because a student can enroll in more than one course.
- However, STUD_NO in the STUDENT table is a primary key, so it must always be unique and non-NULL.

### 6. Composite Key

Sometimes, a single column is not enough to uniquely identify all records in a table, so a combination of multiple attributes is used. An optimal set of such attributes is chosen to ensure that every row is uniquely identifiable.

- It acts as a primary key if there is no primary key in a table
- Two or more attributes are used together to make a composite key .
- Different combinations of attributes may give different accuracy in terms of identifying the rows uniquely.

Example: In the STUDENT_COURSE table, {STUD_NO, COURSE_NO} can form a composite key to uniquely identify each record.

![Different Types of Keys](images_different-types-of-keys.png)