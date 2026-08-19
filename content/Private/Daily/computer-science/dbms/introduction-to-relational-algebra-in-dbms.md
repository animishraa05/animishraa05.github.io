---
title: "Introduction to Relational Algebra in DBMS"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Introduction to Relational Algebra in DBMS
Relational Algebra is a formal language used to query and manipulate relational databases, consisting of a set of operations like selection, projection, union, and join. It provides a mathematical framework for querying databases, ensuring efficient data retrieval and manipulation.

- Relational algebra serves as the mathematical foundation for query SQL.
- SQL queries are based on relational algebra operations, enabling users to retrieve data effectively.

> Note: Relational algebra simplifies the process of querying databases and makes it easier to understand and optimize query execution for better performance. It is essential for learning SQL

Note: Relational algebra simplifies the process of querying databases and makes it easier to understand and optimize query execution for better performance. It is essential for learning SQL

## Key Concepts in Relational Algebra

Before explaining relational algebra operations, let's define some fundamental concepts:

- Relations: In relational algebra, a relation is a table that consists of rows and columns, representing data in a structured format. Each relation has a unique name and is made up of tuples.
- Tuples: A tuple is a single row in a relation, which contains a set of values for each attribute. It represents a single data entry or record in a relational table.
- Attributes: Attributes are the columns in a relation, each representing a specific characteristic or property of the data. For example, in a "Students" relation, attributes could be "Name", "Age", and "Grade".
- Domains: A domain is the set of possible values that an attribute can have. It defines the type of data that can be stored in each column of a relation, such as integers, strings, or dates.

## Basic Operators in Relational Algebra

Relational algebra consists of various basic operators that help us to fetch and manipulate data from relational tables in the database to perform certain operations on relational data. Basic operators are fundamental operations that include selection (σ), projection (π), union (U), set difference (−), Cartesian product (×), and rename (ρ).

![types_of_operators_in_relational_algebra](images_types_of_operators_in_relational_algebra.webp)

### 1. Selection(σ)

The Selection Operation is basically used to filter out rows from a given table based on certain given condition. It basically allows us to retrieve only those rows that match the condition as per condition passed during SQL Query.

Example: If we have a relation R with attributes A, B, and C, and we want to select tuples where C > 3, we write:

| A | B | C |
| --- | --- | --- |
| 1 | 2 | 4 |
| 2 | 2 | 3 |
| 3 | 2 | 3 |
| 4 | 3 | 4 |

> σ(c>3)(R) will select the tuples which have c more than 3.

σ(c>3)(R) will select the tuples which have c more than 3.

Output:

| A | B | C |
| --- | --- | --- |
| 1 | 2 | 4 |
| 4 | 3 | 4 |

> Explanation: The selection operation only filters rows but does not display or change their order. The projection operator is used for displaying specific columns.

Explanation: The selection operation only filters rows but does not display or change their order. The projection operator is used for displaying specific columns.

### 2. Projection(π)

While Selection operation works on rows, similarly projection operation of relational algebra works on columns. It basically allows us to pick specific columns from a given relational table based on the given condition and ignoring all the other remaining columns.

Example: Suppose we want columns B and C from Relation R.

> π(B,C)(R) will show following columns.

π(B,C)(R) will show following columns.

Output:

| B | C |
| --- | --- |
| 2 | 4 |
| 2 | 3 |
| 3 | 4 |

> Explanation: By Default, projection operation removes duplicate values.

Explanation: By Default, projection operation removes duplicate values.

### 3. Union(U)

The Union Operator is basically used to combine the results of two queries into a single result. The only condition is that both queries must return same number of columns with same data types. Union operation in relational algebra is the same as union operation in [[set-theory|set theory]].

Example: Consider the following table of Students having different optional subjects in their course.

FRENCH

| Student_Name | Roll_Number |
| --- | --- |
| Ram | 01 |
| Mohan | 02 |
| Vivek | 13 |
| Geeta | 17 |

GERMAN

| Student_Name | Roll_Number |
| --- | --- |
| Vivek | 13 |
| Geeta | 17 |
| Shyam | 21 |
| Rohan | 25 |

If FRENCH and GERMAN relations represent student names in two subjects, we can combine their student names as follows:

> π(Student_Name)(FRENCH) U π(Student_Name)(GERMAN)

π(Student_Name)(FRENCH) U π(Student_Name)(GERMAN)

Output:

| Student_Name |
| --- |
| Ram |
| Mohan |
| Vivek |
| Geeta |
| Shyam |
| Rohan |

> Explanation: The only constraint in the union of two relations is that both relations must have the same set of Attributes.

Explanation: The only constraint in the union of two relations is that both relations must have the same set of Attributes.

### 4. Set Difference(-)

Set difference basically provides the rows that are present in one table, but not in another tables. Set Difference in relational algebra is the same set difference operation as in [[set-theory|set theory]].

Example: To find students enrolled only in FRENCH but not in GERMAN, we write:

> π(Student_Name)(FRENCH) - π(Student_Name)(GERMAN)

π(Student_Name)(FRENCH) - π(Student_Name)(GERMAN)

| Student_Name |
| --- |
| Ram |
| Mohan |

> Explanation: The only constraint in the Set Difference between two relations is that both relations must have the same set of Attributes.

Explanation: The only constraint in the Set Difference between two relations is that both relations must have the same set of Attributes.

### 5. Rename(ρ)

Rename operator basically allows you to give a temporary name to a specific relational table or to its columns. It is very useful when we want to avoid ambiguity, especially in complex Queries. Rename is a unary operation used for renaming attributes of a relation.

Example: We can rename an attribute B in relation R to D

| A | B | C |
| --- | --- | --- |
| 1 | 2 | 4 |
| 2 | 2 | 3 |
| 3 | 2 | 3 |
| 4 | 3 | 4 |

> ρ(D/B)R will rename the attribute 'B' of the relation by "D".

ρ(D/B)R will rename the attribute 'B' of the relation by "D".

Output Table:

| A | D | C |
| --- | --- | --- |
| 1 | 2 | 4 |
| 2 | 2 | 3 |
| 3 | 2 | 3 |
| 4 | 3 | 4 |

### 6. Cartesian Product(X)

The Cartesian product combines every row of one table with every row of another table, producing all the possible combination. It's mostly used as a precursor to more complex operation like joins. Let’s say A and B, so the cross product between A X B will result in all the attributes of A followed by each attribute of B. Each record of A will pair with every record of B.

Relation A:

| Name | Age | Sex |
| --- | --- | --- |
| Ram | 14 | M |
| Sona | 15 | F |
| Kim | 20 | M |

Relation B:

| ID | Course |
| --- | --- |
| 1 | DS |
| 2 | DBMS |

Output: If relation A has 3 rows and relation B has 2 rows, the Cartesian product A × B will result in 6 rows.

| Name | Age | Sex | ID | Course |
| --- | --- | --- | --- | --- |
| Ram | 14 | M | 1 | DS |
| Ram | 14 | M | 2 | DBMS |
| Sona | 15 | F | 1 | DS |
| Sona | 15 | F | 2 | DBMS |
| Kim | 20 | M | 1 | DS |
| Kim | 20 | M | 2 | DBMS |

Explanation: If A has 'n' tuples and B has 'm' tuples then A X B will have 'n*m' tuples.

> Read more about Basic Operators

Read more about Basic Operators

## Derived Operators in Relational Algebra

Derived operators are built using basic operators and include operations like join, intersection, and division. These operators help perform more complex queries by combining basic operations to meet specific data retrieval needs.

### 1. Join Operators

Join operations in relational algebra combine data from two or more relations based on a related attribute, allowing for more complex queries and data retrieval. Different types of joins include:

### 1.1 Inner Join

An inner join combines rows from two relations based on a matching condition and only returns rows where there is a match in both relations. If a record in one relation doesn't have a corresponding match in the other, it is excluded from the result. This is the most common type of join.

a. Conditional Join:

- A conditional join is an inner join where the matching condition can involve any comparison operator like equals (=), greater than (>), etc.
- Example: Joining Employees and Departments on DepartmentID where Salary > 50000 will return employees in departments with a salary greater than 50,000

`=`

`>`

`Employees`

`Departments`

`DepartmentID`

`Salary > 50000`

b. Equi Join:

- An equi join is a type of conditional join where the condition is specifically equality (=) between columns from both relations.
- Example: Joining Customers and Orders on CustomerID where both relations have this column, returning only matching records.

`=`

`Customers`

`Orders`

`CustomerID`

c. Natural Join:

- A natural join automatically combines relations based on columns with the same name and type, removing duplicate columns in the result. It’s a more efficient way of joining.
- Example: Joining Students and Enrollments where StudentID is common in both, and the result contains only unique columns.

`Students`

`Enrollments`

`StudentID`

### 1.2 Outer Join

An outer join returns all rows from one relation, and the matching rows from the other relation. If there is no match, the result will still include all rows from the outer relation with NULL values in the columns from the unmatched relation.

`NULL`

a. Left Outer Join:

- A left outer join returns all rows from the left relation and the matching rows from the right relation.
- If there is no match, the result will include NULL values for the right relation’s attributes.
- Example: Joining Employees with Departments using a left outer join ensures all employees are listed, even those who aren't assigned to any department, with NULL values for the department columns.

`NULL`

`Employees`

`Departments`

`NULL`

b. Right Outer Join:

- A right outer join returns all rows from the right relation and the matching rows from the left relation.
- If no match exists, the left relation's columns will contain NULL values.
- Example: Joining Departments with Employees using a right outer join includes all departments, even those with no employees assigned, filling unmatched employee columns with NULL.

`NULL`

`Departments`

`Employees`

`NULL`

c. Full Outer Join:

- A full outer join returns all rows when there is a match in either the left or right relation.
- If a row from one relation does not have a match in the other, NULL values are included for the missing side.
- Example: Joining Customers and Orders using a full outer join will return all customers and orders, even if there’s no corresponding order for a customer or no customer for an order.

`NULL`

`Customers`

`Orders`

### 2. Set Intersection(∩)

Set Intersection basically allows to fetches only those rows of data that are common between two sets of relational tables. Set Intersection in relational algebra is the same set intersection operation in [[set-theory|set theory]].

Example: Consider the following table of Students having different optional subjects in their course.

Relation FRENCH

| Student_Name | Roll_Number |
| --- | --- |
| Ram | 01 |
| Mohan | 02 |
| Vivek | 13 |
| Geeta | 17 |

Relation GERMAN

| Student_Name | Roll_Number |
| --- | --- |
| Vivek | 13 |
| Geeta | 17 |
| Shyam | 21 |
| Rohan | 25 |

From the above table of FRENCH and GERMAN, the Set Intersection is used as follows:

> π(Student_Name)(FRENCH ∩ π(Student_Name)(GERMAN)

π(Student_Name)(FRENCH ∩ π(Student_Name)(GERMAN)

Output:

| Student_Name |
| --- |
| Vivek |
| Geeta |

Explanation: The only constraint in the Set Difference between two relations is that both relations must have the same set of Attributes.

### 3. Division (÷)

The Division Operator is used to find tuples in one relation that are related to all tuples in another relation. It’s typically used for "for all" queries.

Student_Course (Dividend Table):

| Student_ID | Course_ID |
| --- | --- |
| 101 | C1 |
| 101 | C2 |
| 102 | C1 |
| 103 | C1 |
| 103 | C2 |

Student_ID

Course_ID

101

101

102

103

103

Course (Divisor Table):

| Course_ID |
| --- |
| C1 |
| C2 |

Course_ID

Example: Query is to find students who are enrolled in all courses listed in the Course table. In this case, students must be enrolled in both C1 and C2.

> Student_Course(Student_ID, Course_ID)÷ Course(Course_ID)

Student_Course(Student_ID, Course_ID)÷ Course(Course_ID)

Output:

| Student_ID |
| --- |
| 101 |
| 103 |

Student_ID

101

103

> Read more about Extended Operators

Read more about Extended Operators

## Relational Calculus

Relational [[calculus]] is a non-procedural query language used in the context of relational algebra. It focuses on what data to retrieve, rather than how to retrieve it, making it different from relational algebra, which is procedural. In relational [[calculus]], queries are expressed using logical formulas that describe the desired result, without specifying the exact steps to get there.

There are two types of Relational [[calculus|Calculus]]

1. Tuple Relational [[calculus|Calculus]](TRC)
2. Domain Relational [[calculus|Calculus]](DRC)

Following are the Previous Year's Gate Questions

GATE | GATE CS 2012 | Question 50GATE | GATE CS 2012 | Question 41