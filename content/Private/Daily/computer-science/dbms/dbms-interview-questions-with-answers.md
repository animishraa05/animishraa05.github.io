---
title: "DBMS Interview Questions with Answers"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# DBMS Interview Questions with Answers
A Database Management System (DBMS) is the backbone of modern data storage and management. Understanding DBMS concepts is critical for anyone looking to work with databases. Whether you're preparing for your first job in database management or advancing in your career, being well-prepared for a DBMS interview can make all the difference.

![420046939](images_420046939.webp)

### 1. What is a Database Management System (DBMS)?

A Database Management System (DBMS) is software that is used to manage and organize databases. It provides an interface to interact with the data stored in a database. The DBMS is responsible for tasks such as storing, retrieving, and updating data, ensuring data integrity, security, and managing concurrency. Examples include MySQL, PostgreSQL, Oracle, and SQL Server.

### 2. What are the advantages of using a DBMS?

The advantages of using a DBMS are:

- Data Integrity: Ensures that the data is accurate and consistent.
- Data Security: Provides controlled access to sensitive data by setting permissions for different users.
- Efficient Data Retrieval: Optimizes queries and indexing, allowing faster data retrieval.
- Reduced Redundancy: Avoids duplicate data by enforcing normalization.
- Backup and Recovery: Offers automatic backup and recovery mechanisms.
- Concurrent Access: Allows multiple users to access the database at the same time without conflicts.

### 3. What is the difference between DBMS and RDBMS?

| Aspect | DBMS | RDBMS |
| --- | --- | --- |
| Data Storage | Stores data as files or in non-relational form | Stores data in tables (rows and columns) |
| Relationships | Does not support relationships between data | Supports relationships using foreign keys |
| Data Integrity | Does not enforce integrity constraints | Enforces integrity using primary and foreign keys |
| Examples | Microsoft Access, XML Database | MySQL, Oracle, SQL Server |

Aspect

DBMS

RDBMS

Data Storage

Stores data as files or in non-relational form

Stores data in tables (rows and columns)

Relationships

Does not support relationships between data

Supports relationships using foreign keys

Data Integrity

Does not enforce integrity constraints

Enforces integrity using primary and foreign keys

Examples

Microsoft Access, XML Database

MySQL, Oracle, SQL Server

### 4. What are the different types of DBMS?

The four types of DBMS are:

- Hierarchical DBMS: Data is organized in a tree-like structure with parent-child relationships. Example: IBM’s IMS.
- Network DBMS: Data is represented as a graph with many-to-many relationships. Example: Integrated Data Store (IDS).
- Relational DBMS (RDBMS): Data is organized in tables (relations) and managed through SQL. Example: MySQL, PostgreSQL.
- Object-Oriented DBMS: Data is stored as objects, like in object-oriented programming. Example: ObjectDB.

### 5. What is a relation in DBMS?

A relation in DBMS is a table that consists of rows and columns. Each row represents a record, and each column represents an attribute or property of the entity being described. Relations are defined by a schema, which specifies the attributes (columns) of the table.

### 6. What is a table in DBMS?

A table in DBMS is a collection of data organized in rows and columns. It is the primary structure for storing data in a relational database. Each row represents an entity (record), and each column represents an attribute of that entity.

### 7. What are rows and columns in a DBMS?

- Rows (Tuples): A row represents a single record or entity. Each row contains values for each attribute (column).
- Columns (Attributes): A column represents a property or characteristic of the entity. Each column has a data type, such as integer, string, etc

### 8. What are the primary components of a DBMS?

The primary components of a DBMS are:

- Database Engine: Responsible for storing, retrieving, and managing data.
- Database Schema: The structure that defines the organization of the database.
- Query Processor: Interprets and executes SQL queries.
- Transaction Manager: Ensures the ACID properties of transactions.
- Storage Manager: Manages the physical storage of data.

### 9. What is a primary key? Explain with an example.

A Primary Key is a unique identifier for each record in a table. It ensures that no two records have the same value for the primary key field. It cannot contain NULL values. Example: In a STUDENT table, ROLL_NO could be the primary key because each student has a unique roll number.

`ROLL_NO`

| ROLL_NO | NAME | ADDRESS |
| --- | --- | --- |
| 1 | Ram | Delhi |
| 2 | Suresh | Delhi |

### 10. What is a foreign key? Explain with an example.

A "Foreign Key" is an attribute in a table that links to the primary key in another table. It creates a relationship between two tables, ensuring referential integrity. Example: In a STUDENT table, the BRANCH_CODE could be a foreign key referencing the primary key BRANCH_CODE in the BRANCH table.

STUDENT Table:

| ROLL_NO | NAME | BRANCH_CODE |
| --- | --- | --- |
| 1 | Ram | CS |
| 2 | Suresh | IT |

BRANCH Table:

`BRANCH`

| BRANCH_CODE | BRANCH_NAME |
| --- | --- |
| CS | Computer Science |
| IT | Information Technology |

Here, BRANCH_CODE in STUDENT is a foreign key referencing BRANCH_CODE in BRANCH.

`BRANCH_CODE`

`STUDENT`

`BRANCH_CODE`

`BRANCH`

### 11. What is denormalization? How does it differ from normalization?

Denormalization is the process of combining tables to improve query performance, often by introducing redundancy. While normalization minimizes redundancy, denormalization sacrifices some of it to improve speed for read-heavy operations.

Difference:

- Normalization: Focuses on minimizing redundancy and improving data integrity.
- Denormalization: Adds redundancy for performance optimization in some cases.

### 12. What is a candidate key in DBMS?

A Candidate Key is a set of one or more attributes that can uniquely identify a tuple in a relation. A relation can have multiple candidate keys, and one of them is chosen as the primary key.

### 13. What is the use of the SQL SELECT statement?

The SELECT statement is used to query data from one or more tables. It allows you to retrieve specific columns or all columns, optionally applying filters (WHERE), sorting (ORDER BY), and joining multiple tables.

Example:

> SELECT NAME, AGE FROM STUDENT WHERE AGE > 18;

SELECT NAME, AGE FROM STUDENT WHERE AGE > 18;

### 14. What is a view in DBMS? How does it differ from a table?

A View is a virtual table created by querying one or more base tables. It does not store data physically but dynamically retrieves it when queried. Unlike a table, a view does not store its own data but presents data from other tables.

### 15. What are the different types of relationships in DBMS?

The three main types of relationships in DBMS are:

- One-to-One (1:1): A record in one table is associated with a single record in another table.
- One-to-Many (1:M): A record in one table is associated with multiple records in another table.
- Many-to-Many (M:M): Multiple records in one table are associated with multiple records in another table.

### 16. Explain the concept of a schema in DBMS.

A schema in DBMS is the structure that defines the organization of data in a database. It includes tables, views, relationships, and other elements. A schema defines the tables and their columns, along with the constraints, keys, and relationships.

### 17. What are constraints in DBMS?

Constraints in DBMS are rules that limit the type of data that can be inserted into a table to ensure data integrity and consistency. Common types of constraints include: NOT NULL, PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT.

### 18. What are the different types of constraints in DBMS? Give examples.

Constraints in DBMS are rules applied to the data in a database to ensure its accuracy and integrity. The most common types of constraints are:

- NOT NULL: Ensures that a column cannot have NULL values. Example: Name VARCHAR(50) NOT NULL;
- PRIMARY KEY: Uniquely identifies each record in a table. It ensures that no duplicate rows exist and that no NULL values are allowed. Example: ID INT PRIMARY KEY;
- FOREIGN KEY: Ensures referential integrity between two tables by linking a column in one table to the primary key in another table. Example: BranchCode INT FOREIGN KEY REFERENCES Branch(BranchCode);
- UNIQUE: Ensures that all values in a column are distinct. Unlike the primary key, it allows NULL values. Example: Email VARCHAR(100) UNIQUE;
- CHECK: Ensures that values in a column satisfy a specific condition. Example: Age INT CHECK (Age >= 18);
- DEFAULT: Assigns a default value to a column if no value is provided during insertion. Example: Status VARCHAR(10) DEFAULT 'Active';

### 19. What is the difference between DELETE and TRUNCATE in SQL?

- DELETE: Deletes specific rows from a table based on a condition. It logs each row deletion and can be rolled back.
- TRUNCATE: Removes all rows from a table without logging individual row deletions. It cannot be rolled back and is faster than DELETE.

### 20. What is an index in DBMS and how is it used?

An [[index]] is a data structure that improves the speed of data retrieval operations on a database table. It works like a table of contents in a book, allowing the database to quickly find the location of a record based on a column value.

### 21. What is the role of the Database Administrator (DBA)?

A Database Administrator (DBA) is responsible for managing and overseeing the entire database environment. Their key responsibilities include:

- Database Design: Structuring the database for optimal storage and performance.
- Backup and Recovery: Ensuring regular backups and providing recovery solutions in case of failures.
- Performance Tuning: Monitoring and optimizing the database's performance.
- Security Management: Managing user access, privileges, and enforcing security policies.
- Data Integrity: Ensuring data consistency and integrity through constraints and checks.
- Upgrades and Patches: Keeping the database software up-to-date with patches and upgrades.
- Troubleshooting: Identifying and resolving database-related issues.

### 22. What is an entity-relationship diagram (ERD)?

An Entity-Relationship Diagram (ERD) is a visual representation of the entities within a system and the relationships between those entities. It is used in database design to model the structure of data and how different pieces of data relate to each other.

- Entities: Objects or things within the system (e.g., Student, Course).
- Attributes: Properties or details about an entity (e.g., Student Name, Course Duration).
- Relationships: How entities interact with each other (e.g., Student enrolls in Course).

`Student`

`Course`

`Student Name`

`Course Duration`

`Student`

`Course`

Example of ERD:

- A Student entity might have attributes like ID, Name, and Age.
- A Course entity might have attributes like CourseID, CourseName.
- A relationship Enrolls connects Student and Course with attributes like EnrollmentDate.

`Student`

`ID`

`Name`

`Age`

`Course`

`CourseID`

`CourseName`

`Enrolls`

`Student`

`Course`

`EnrollmentDate`

### 23. What is a join in SQL? Name and explain different types of joins.

A JOIN in SQL is an operation that combines columns from two or more tables based on a related column between them. Joins are used to query data from multiple tables in a relational database.

Here are the different types of joins in SQL:

1. INNER JOIN: Returns only the rows where there is a match in both tables.

Example:

> SELECT * FROM StudentINNER JOIN Course ON Student.ID = Course.StudentID;

SELECT * FROM StudentINNER JOIN Course ON Student.ID = Course.StudentID;

2. LEFT JOIN (or LEFT OUTER JOIN): Returns all rows from the left table and the matching rows from the right table. If there is no match, NULL values will be returned for columns from the right table.

Example:

> SELECT * FROM StudentLEFT JOIN Course ON Student.ID = Course.StudentID;

SELECT * FROM StudentLEFT JOIN Course ON Student.ID = Course.StudentID;

3. RIGHT JOIN (or RIGHT OUTER JOIN): Returns all rows from the right table and the matching rows from the left table. If there is no match, NULL values will be returned for columns from the left table.

Example:

> SELECT * FROM StudentRIGHT JOIN Course ON Student.ID = Course.StudentID;

SELECT * FROM StudentRIGHT JOIN Course ON Student.ID = Course.StudentID;

4. FULL JOIN (or FULL OUTER JOIN): Returns all rows when there is a match in either the left or the right table. If there is no match, NULL values will be returned for the columns of the table without a match.

Example:

> SELECT * FROM StudentFULL JOIN Course ON Student.ID = Course.StudentID;

SELECT * FROM StudentFULL JOIN Course ON Student.ID = Course.StudentID;

5. CROSS JOIN: Returns the Cartesian product of two tables, i.e., every combination of rows from both tables.

Example:

> SELECT * FROM StudentCROSS JOIN Course;

SELECT * FROM StudentCROSS JOIN Course;

6. SELF JOIN: A SELF JOIN is a join where a table is joined with itself. It is used when we need to compare rows within the same table. To differentiate the two instances of the same table, aliases are used.

Example:

> SELECT E1.Employee_ID, E1.Employee_Name, E2.Employee_Name AS Manager_NameFROM Employee E1LEFT JOIN Employee E2 ON E1.Manager_ID = E2.Employee_ID;

SELECT E1.Employee_ID, E1.Employee_Name, E2.Employee_Name AS Manager_NameFROM Employee E1LEFT JOIN Employee E2 ON E1.Manager_ID = E2.Employee_ID;

### 24. What is a subquery in SQL? Provide an example.

A subquery in SQL is a query embedded within another query. It is used to retrieve data that will be used in the outer query. Subqueries can be used in SELECT, INSERT, UPDATE, or DELETE statements.

There are two types of subqueries:

- Single-row subquery: Returns a single value.
- Multiple-row subquery: Returns multiple values.

Example of a subquery: To find the names of students who have a higher age than the average age:

> SELECT Name FROM StudentWHERE Age > (SELECT AVG(Age) FROM Student);

SELECT Name FROM StudentWHERE Age > (SELECT AVG(Age) FROM Student);

### 25. What are aggregate functions in SQL? Name a few examples.

Aggregate functions in SQL are functions that operate on a set of values (or a group of rows) and return a single result. They are often used in conjunction with the GROUP BY clause. Here are a few commonly used aggregate functions in SQL:

1. COUNT(): Returns the number of rows or non-NULL values in a column

Example:

> SELECT COUNT(*) FROM Student;

SELECT COUNT(*) FROM Student;

2. SUM(): Returns the sum of values in a numeric column.

Example:

> SELECT SUM(Amount) FROM Orders;

SELECT SUM(Amount) FROM Orders;

3. AVG(): Returns the average value of a numeric column.

Example:

> SELECT AVG(Salary) FROM Employees;

SELECT AVG(Salary) FROM Employees;

4. MAX(): Returns the maximum value in a column

Example:

> SELECT MAX(Age) FROM Student;

SELECT MAX(Age) FROM Student;

5. MIN(): Returns the minimum value in a column.

Example:

> SELECT MIN(Salary) FROM Employees;

SELECT MIN(Salary) FROM Employees;

## Intermediate DBMS Interview Questions

DBMS Intermediate Interview Questions dive deeper into more complex DBMS concepts and practical applications. These questions assess your ability to handle real-world database problems involving transactions, concurrency control, and schema design. Topics such as joins, indexing, normalization, and transaction management are often discussed at this level.

### 26. What is a transaction in DBMS?

A transaction in DBMS is a sequence of one or more SQL operations executed as a single unit of work. A transaction ensures data integrity, consistency, and isolation, and it guarantees that the database reaches a valid state, regardless of errors or system failures.

![Transaction-in-dbms](images_transaction-in-dbms.png)

### 27. What is the ACID property in DBMS?

ACID stands for Atomicity, Consistency, Isolation, and Durability, which are the key properties that guarantee reliable transaction processing:

- Atomicity: All operations in a transaction are treated as a single unit. If one operation fails, the entire transaction fails and the database state remains unchanged.
- Consistency: Ensures the database starts and ends in a consistent state, with all rules and constraints enforced.
- Isolation: Transactions are executed independently, and the intermediate states of a transaction are invisible to other transactions.
- Durability: Once a transaction is committed, its changes are permanent, even if a system failure occurs.

![acid_properties](images_acid_properties.webp)

### 28. Explain the concept of a stored procedure in DBMS.

A stored procedure is a precompiled collection of one or more SQL statements stored in the database. Stored procedures allow users to execute a series of operations as a single unit, improving performance and reusability. They can accept input parameters, perform operations, and return results.

Example:

> CREATE PROCEDURE GetStudentDetails(IN student_id INT)BEGIN SELECT * FROM Student WHERE ID = student_id;END;

CREATE PROCEDURE GetStudentDetails(IN student_id INT)BEGIN SELECT * FROM Student WHERE ID = student_id;END;

### 29. What are triggers in DBMS? Provide an example.

A trigger is a special kind of stored procedure that automatically executes (or "fires") in response to certain events on a table, such as insertions, updates, or deletions. Triggers are used to enforce business rules, maintain consistency, or log changes.

Example:

> CREATE TRIGGER after_student_insertAFTER INSERT ON StudentFOR EACH ROWBEGIN INSERT INTO AuditLog (Action, StudentID, ActionTime) VALUES ('INSERT', NEW.ID, NOW());END;

CREATE TRIGGER after_student_insertAFTER INSERT ON StudentFOR EACH ROWBEGIN INSERT INTO AuditLog (Action, StudentID, ActionTime) VALUES ('INSERT', NEW.ID, NOW());END;

### 30. What is the difference between a trigger and a stored procedure?

Trigger:

- A trigger is an automatic action executed by the DBMS when a specific event occurs on a table, such as an INSERT, UPDATE, or DELETE.
- It cannot be invoked manually and is tied to a specific event.

Stored Procedure:

- A stored procedure is a precompiled set of SQL statements that can be executed explicitly by a user or application.
- It is invoked manually, and it can accept input parameters and return output.

### 31. What is the difference between UNION and UNION ALL in SQL?

- UNION: Combines the result of two queries and removes duplicate rows.
- UNION ALL: Combines the result of two queries but does not remove duplicates, thus it is faster than UNION.

`UNION`

Example:

> SELECT Name FROM StudentsUNIONSELECT Name FROM Teachers; -- Removes duplicatesSELECT Name FROM StudentsUNION ALLSELECT Name FROM Teachers; -- Does not remove duplicates

SELECT Name FROM StudentsUNIONSELECT Name FROM Teachers; -- Removes duplicatesSELECT Name FROM StudentsUNION ALLSELECT Name FROM Teachers; -- Does not remove duplicates

### 32. Explain the concept of indexing in DBMS.

Indexing is a technique used to speed up the retrieval of records from a table by creating a data structure that allows for faster searching. An [[index]] provides a quick lookup of data based on the values of one or more columns.

Types of Indexes:

- Single-column [[index]]: Created on one column.
- Composite [[index]]: Created on multiple columns.
- Unique [[index]]: Ensures that no two rows have the same values in the indexed columns.

### 33. Explain Normalization in DBMS. Why is it important? Also explain the different normal forms (1NF, 2NF, 3NF, and BCNF) with examples.

Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. It divides large tables into smaller related tables and establishes relationships between them. This helps avoid anomalies during insertion, update, and deletion operations and ensures consistency of data.

![normalization_venn_diagram](images_normalization_venn_diagram.webp)

- First Normal Form (1NF): Ensures that the data in the table is atomic, meaning each column contains indivisible values (no multi-valued attributes).

Example:

> Student (ID, Name, Subjects)

Student (ID, Name, Subjects)

2. Second Normal Form (2NF): 2NF is achieved when the table is in 1NF and all non-key attributes are fully dependent on the primary key.

Example: Consider the following table

> StudentCourse (StudentID, CourseID, InstructorName)

StudentCourse (StudentID, CourseID, InstructorName)

Here, InstructorName depends on CourseID, not on StudentID. To make it 2NF, we separate the data:

`InstructorName`

`CourseID`

`StudentID`

> Student (StudentID, Name)Course (CourseID, InstructorName)Enrollment (StudentID, CourseID)

Student (StudentID, Name)Course (CourseID, InstructorName)Enrollment (StudentID, CourseID)

3. Third Normal Form (3NF): A table is in 3NF if it is in 2NF and there is no transitive dependency (non-key attributes depend on other non-key attributes).

Example:

> Employee (EmpID, EmpName, DeptID, DeptName)

Employee (EmpID, EmpName, DeptID, DeptName)

Here, DeptName depends on DeptID. To bring this into 3NF:

> Employee (EmpID, EmpName, DeptID)Department (DeptID, DeptName)

Employee (EmpID, EmpName, DeptID)Department (DeptID, DeptName)

4. Boyce-Codd Normal Form (BCNF): A stricter version of 3NF where every determinant is a candidate key.

Example:

> Student (StudentID, CourseID, InstructorID)

Student (StudentID, CourseID, InstructorID)

And the constraint is such that InstructorID determines CourseID, it would not be in BCNF because InstructorID is not a candidate key. To achieve BCNF:

> Instructor (InstructorID, CourseID)Enrollment (StudentID, CourseID)

Instructor (InstructorID, CourseID)Enrollment (StudentID, CourseID)

### 34. What is the difference between INNER JOIN and OUTER JOIN?

| Aspect | INNER JOIN | OUTER JOIN |
| --- | --- | --- |
| Result Set | Returns only matching rows from both tables. | Returns all rows from one or both tables, with NULL where no match is found. |
| Types | Single type. | Three types: LEFT, RIGHT, FULL. |
| Use Case | When you need only the intersecting data. | When you need to preserve all data, even with mismatches. |
| Performance | Generally faster as it deals with fewer rows. | Can be slower due to handling more rows and NULL values. |
| Reliability | Reliable for matching data across tables. | Reliable when you need to retain all data, but can introduce NULL-related issues. |

### 35. What is data redundancy in a database? How can it be reduced?

Data redundancy refers to the unnecessary repetition of data in a database. It can lead to inconsistencies, increased storage requirements, and maintenance challenges.

Reduction methods:

- Normalization: Splitting large tables into smaller ones to eliminate redundancy.
- Eliminating duplicate data: Using constraints like UNIQUE and PRIMARY KEY to enforce data consistency.

### 36. What is a deadlock in DBMS? How can it be prevented?

A deadlock occurs when two or more transactions are blocked because each transaction is waiting for the other to release resources. This results in a situation where none of the transactions can proceed.

Prevention Techniques:

- Lock ordering: Ensuring that all transactions acquire locks in the same predefined order.
- Timeouts: Automatically rolling back transactions that have been waiting too long for resources.
- Deadlock detection: Periodically checking for deadlocks and aborting one of the transactions to break the cycle.

### 37. What is a database cursor? How is it used?

A cursor in DBMS is a pointer to a result set of a query. It allows for row-by-row processing of query results, which is useful when dealing with large datasets.

Types of cursors:

- Implicit cursors: Automatically created by the DBMS for SELECT, INSERT, UPDATE, DELETE operations.
- Explicit cursors: Manually created by the programmer to process query results.

Example:

> DECLARE cursor_example CURSOR FORSELECT * FROM Employee;

DECLARE cursor_example CURSOR FORSELECT * FROM Employee;

### 38. What are the different types of database locks?

There are several types of locks in DBMS to ensure data consistency when multiple transactions are involved:

- Shared Lock (S Lock): Allows multiple transactions to read a resource but prevents modification.
- Exclusive Lock (X Lock): Prevents any other transaction from reading or modifying the locked resource.
- Intent Lock: Signals that a transaction intends to lock a resource.
- Update Lock (U Lock): Used when a transaction intends to update a resource.

### 39. What is the difference between a clustered and non-clustered index?

- Clustered [[index|Index]]: Organizes the data in the table according to the [[index]]. There can only be one clustered [[index]] per table because the data rows can only be sorted one way.
- Non-clustered [[index|Index]]: Creates a separate structure from the table that holds pointers to the actual data rows. Multiple non-clustered indexes can be created on a table.

### 40. What is the importance of the COMMIT and ROLLBACK operations?

- COMMIT: Saves all changes made during the current transaction to the database permanently.
- ROLLBACK: Reverses all changes made during the current transaction, restoring the database to its previous state.
- Both operations ensure the ACID properties of transactions: Atomicity and Durability.

### 41. What is the difference between a superkey and a candidate key?

- Superkey: A set of one or more attributes that can uniquely identify a row in a table. It may contain unnecessary attributes.
- Candidate Key: A minimal superkey that uniquely identifies a row, with no redundant attributes. A table can have multiple candidate keys, and one is chosen as the Primary Key.

![Different-types-of-keys](images_different-types-of-keys.png)

### 42. Explain the difference between a primary key and a unique key.

Primary Key:

- Uniquely identifies each record in a table.
- Cannot contain NULL values.
- A table can have only one primary key.

Unique Key:

- Ensures that all values in a column (or a set of columns) are unique across all rows.
- Can contain NULL values (unlike a primary key).
- A table can have multiple unique keys.

### 43. What is referential integrity in DBMS?

Referential Integrity ensures that relationships between tables are maintained correctly. It requires that the foreign key in one table must match a primary key or a unique key in another table (or be NULL). This ensures that data consistency is maintained, and there are no orphan records in the database.

Example: In the Orders table, if the CustomerID is a foreign key, it should match a valid CustomerID in the Customers table or be NULL.

### 44. How does DBMS handle concurrency control?

Concurrency control ensures that database transactions are executed in a way that prevents conflicts, such as data inconsistency, when multiple transactions are executed simultaneously. DBMS uses the following techniques:

- Locking: Transactions acquire locks (shared or exclusive) on the data to prevent other transactions from modifying it while one transaction is in progress. Types of Locks: Shared locks (S-lock) and exclusive locks (X-lock).
- Timestamp Ordering: Assigns a unique timestamp to each transaction and uses these timestamps to determine the order in which transactions should be executed.
- Optimistic Concurrency Control: Transactions are executed without locking data, but before committing, the system checks whether there were conflicts with other transactions.
- Two-Phase Locking: Involves two phases-growing (acquiring locks) and shrinking (releasing locks)-to avoid deadlocks and ensure serializability.

### 45. What are the advantages of using foreign keys in DBMS?

- Enforcing Data Integrity: Ensures that the value of a foreign key matches a valid primary key or unique key, maintaining consistency.
- Referential Integrity: Prevents orphaned records in the database by enforcing valid relationships between tables.
- Easy Data Maintenance: Helps with cascading updates and deletions, meaning changes in the referenced table can automatically propagate to the referencing table (if configured with ON UPDATE CASCADE or ON DELETE CASCADE).
- Improved Query Efficiency: With foreign keys, database queries that join related tables are more efficient and meaningful.

### 46. What is a transaction log in DBMS?

A transaction log is a record that keeps track of all transactions executed on a database. It ensures that changes made by transactions are saved, and in case of a system failure, the log can be used to recover the database to its last consistent state. The transaction log contains:

- The details of each transaction (e.g., start, commit, rollback).
- Information about data modifications (insertions, updates, deletions).
- Details about the data before and after the change.

### 47. What is a materialized view in DBMS?

A materialized view is a database object that contains the results of a query. Unlike a regular view, which is a virtual table (it doesn’t store data), a materialized view stores data physically, improving query performance by precomputing and storing results.

Use Case: Materialized views are commonly used for performance optimization in [[data-warehousing|data warehousing]] and reporting systems, where the same data is frequently queried.

Example:

> CREATE MATERIALIZED VIEW SalesSummary ASSELECT Product, SUM(Quantity) FROM Sales GROUP BY Product;

CREATE MATERIALIZED VIEW SalesSummary ASSELECT Product, SUM(Quantity) FROM Sales GROUP BY Product;

### 48. What are the differences between an ER diagram and a relational schema?

Entity-Relationship Diagram (ERD):

- A conceptual blueprint that models entities, relationships, and attributes of the database. It visually represents the structure of the database.
- Used in the database design phase to understand how data entities relate to each other.

Relational Schema:

- A logical schema that defines the structure of a relational database, including tables, columns, relationships, and constraints.
- Represents how data is physically organized in tables with constraints such as primary keys, foreign keys, and data types.

### 49. What is the purpose of the GROUP BY clause in SQL?

The "GROUP BY" clause is used in SQL to group rows that have the same values in specified columns into summary rows, often with aggregate functions like COUNT, SUM, AVG, MIN, or MAX. It is typically used to organize data for reporting or analysis.

Example: This groups the employees by department and counts the number of employees in each department.

> SELECT Department, COUNT(*) FROM EmployeesGROUP BY Department;

SELECT Department, COUNT(*) FROM EmployeesGROUP BY Department;

### 50. What are stored functions in DBMS?

A stored function is a set of SQL statements that can be executed in the database. It accepts input parameters, performs some logic, and returns a value. Stored functions are similar to stored procedures but differ in that they must return a value.

Example:

> CREATE FUNCTION GetEmployeeSalary(EmployeeID INT)RETURNS DECIMAL(10,2)BEGIN DECLARE salary DECIMAL(10,2); SELECT Salary INTO salary FROM Employee WHERE ID = EmployeeID; RETURN salary;END;

CREATE FUNCTION GetEmployeeSalary(EmployeeID INT)RETURNS DECIMAL(10,2)BEGIN DECLARE salary DECIMAL(10,2); SELECT Salary INTO salary FROM Employee WHERE ID = EmployeeID; RETURN salary;END;

## Advanced DBMS Interview Questions

DBMS Advanced Interview Questions focus on in-depth knowledge and problem-solving skills for complex database scenarios. This category evaluates your ability to handle large-scale data, optimize query performance, and understand advanced DBMS topics like distributed databases, indexing strategies, and concurrency control mechanisms. Being proficient in these areas is crucial for roles involving high-performance databases and large-scale systems.

### 51. What are the different phases of the DBMS query processing cycle?

The DBMS query processing cycle consists of several phases that transform the high-level query (SQL) into executable actions:

1. Parsing: The SQL query is parsed to check its syntax and semantics. The DBMS ensures that the query is valid according to the SQL syntax and the database schema.
2. Translation: The query is translated into an internal form, such as a relational algebra expression or an execution plan.
3. Optimization: The DBMS optimizes the query to determine the most efficient execution plan, considering factors like indexes, joins, and available resources.
4. Execution: The optimized query plan is executed by the query processor, which accesses the data from the database and returns the results.

![steps_in_query_processing](images_steps_in_query_processing.webp)

### 52. What are the different types of backups in DBMS?

There are several types of backups in DBMS:

- Full Backup: A full backup copies the entire database, including all data and the database structure. It is the most comprehensive but can take up a lot of storage and time.
- Incremental Backup: An incremental backup only copies the data that has changed since the last backup (either full or incremental). This saves space and time but requires the restoration of the full backup and all incremental backups.
- Differential Backup: A differential backup copies all changes made since the last full backup. It’s faster than a full backup and simpler to restore than incremental backups.
- Transaction Log Backup: A transaction log backup copies the transaction log, which records all transactions performed on the database. This allows for point-in-time recovery.

### 53. What is the use of the "WITH CHECK OPTION" in SQL views?

The "WITH CHECK OPTION" is used when creating a view in SQL to ensure that any insert or update operation on the view must adhere to the conditions defined in the view’s WHERE clause. If the inserted or updated data violates these conditions, the operation will be rejected.

Example: Here, if a user tries to insert or update a Student record with a status other than 'Active', the operation will fail.

> CREATE VIEW ActiveStudents ASSELECT * FROM Students WHERE Status = 'Active'WITH CHECK OPTION;

CREATE VIEW ActiveStudents ASSELECT * FROM Students WHERE Status = 'Active'WITH CHECK OPTION;

### 54. Explain the concept of a B-tree and B+ tree in DBMS.

B-tree (Balanced Tree):

- A B-tree is a self-balancing [[Private/Daily/computer-science/algorithms/tree-data-structure|tree data structure]] that maintains sorted data and allows searches, insertions, deletions in logarithmic time.
- B-trees are used in databases and file systems to store large amounts of data. All nodes in a B-tree can have multiple children, which increases the efficiency of searching.
- Stores data in both internal and leaf nodes.

![Untitled-Diagram111](images_untitled-diagram111.png)

B+ tree:

- A B+ tree is an extension of the B-tree and is widely used in databases for indexing. It differs in that it has a linked list at the leaf level and stores all records in the leaf nodes.
- The internal nodes of the B+ tree store only keys and pointers to the next level of the tree, while the leaf nodes contain actual data or pointers to the data.
- Stores data only in the leaf nodes and uses the internal nodes for indexing.

![Btree](images_btree.jpg)

### 55. What is a hashing technique in DBMS? How does it work?

A hashing technique in DBMS is used to map data (such as a key) to a fixed-size value or address, using a hash function. It is primarily used for quick data retrieval, particularly in hash indexes or hash tables. Example: A hash function might map a StudentID of 123 to a bucket [[index]] of 3. The student’s record would be stored in the corresponding bucket.

How it works:

1. A hash function takes the key (e.g., a record’s ID) and calculates a hash value.
2. This hash value determines the bucket or slot where the data is stored.
3. When searching for a record, the hash function is applied again to the key to find the corresponding bucket.

### 56. Explain the concept of data partitioning in DBMS.

Data partitioning is the process of dividing large datasets into smaller, more manageable segments (partitions) to improve performance, scalability, and availability. Each partition can be stored and processed separately.

Types of partitioning:

1. Horizontal Partitioning: Divides data by rows. For example, splitting data by time range (e.g., 2020 data in one partition, 2021 in another).
2. Vertical Partitioning: Divides data by columns. For example, putting frequently accessed columns in one partition and less frequently accessed columns in another.
3. Range Partitioning: Data is divided based on a range of values (e.g., age groups, date ranges).
4. Hash Partitioning: Data is distributed across partitions based on a hash value derived from a key column.

### 57. What is the role of the DBMS in handling data integrity and security?

The DBMS plays a critical role in ensuring:

- Data Integrity: Through constraints like Primary Keys, Foreign Keys, and Check Constraints, the DBMS ensures data consistency and accuracy.
- Data Security: DBMS systems provide user authentication, access control, and encryption mechanisms to protect data from unauthorized access and breaches. It also supports role-based access control (RBAC), ensuring that only authorized users can perform certain actions on the data.

### 58. How is DBMS different from a file-based system?

| Aspect | DBMS | File-based System |
| --- | --- | --- |
| Data Organization | Data stored in structured tables with relationships | Data stored in separate flat files |
| Data Redundancy | Low redundancy (uses normalization) | High redundancy |
| Data Integrity | Enforced using constraints | Hard to enforce |
| Security | Strong security and access control | Basic file-level security |
| Concurrency Control | Supports multi-user access safely | No proper concurrency control |
| Data Access | Supports complex queries (SQL) | Limited file operations |
| Backup & Recovery | Automatic and reliable | Manual and less reliable |
| Scalability | Highly scalable | Poor scalability |
| Maintenance | Centralized and easier | Manual and difficult |
| Transactions | Supports ACID properties | No transaction support |

### Related Article

> DBMS interview questions | Set 2Database Design & Modeling Interview Questions - DBMSTransactions, Concurrency & Recovery Interview Questions - DBMSStorage, Indexing & Advanced Topics Interview Questions - DBMS

- DBMS interview questions | Set 2
- Database Design & Modeling Interview Questions - DBMS
- Transactions, Concurrency & Recovery Interview Questions - DBMS
- Storage, Indexing & Advanced Topics Interview Questions - DBMS