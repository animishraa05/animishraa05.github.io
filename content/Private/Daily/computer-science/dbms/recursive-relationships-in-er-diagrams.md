---
title: "Recursive Relationships in ER diagrams"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Recursive Relationships in ER diagrams
A relationship between two entities of the same entity set is called a recursive relationship or repeated relationship. Here the same entity set participates more than once in a relationship type with a different role for each instance.

- To represent a recursive relationship in an ER diagram, we use a self-join, which is a join between a table and itself.
- The self-join involves creating two instances of the same entity and connecting them with a relationship, on considered as child and other as parent.
- Often used to represent hierarchies or networks, where an entity can be connected to other entities of the same type.

![2](Daily/computer-science/dbms/images/2.webp)

> Example: In an organizational chart, an employee can have a relationship with other employees who are also in a managerial position. Similarly, in a social network, a user can have a relationship with other users who are their friends.

Example: In an organizational chart, an employee can have a relationship with other employees who are also in a managerial position. Similarly, in a social network, a user can have a relationship with other users who are their friends.

## Cardinality in Recursive Relationship

We use cardinality constraints to specify the number of instances of the entity that can participate in the relationship. For example, in an organizational chart, an employee can have many subordinates, but each subordinate can only have one manager. This is represented as a one-to-many (1:N) relationship between the employee entity and itself. Let us suppose that we have an employee table, where:

- A manager supervises a subordinate.
- Every employee can have a supervisor except the CEO
- There can be at most one boss for each employee.
- One employee may be the boss of more than one employee.

![1](Daily/computer-science/dbms/images/1.webp)

Here REPORTS_TO is a recursive relationship on the Employee entity type where each Employee plays two roles: Supervisor & Subordinate. Here, "Supervisor" and "Subordinate" are referred to as role names. The degree of the REPORTS_TO relationship is 1 (i.e., a unary relationship)

- The minimum cardinality of the Supervisor role is 0 because the lowest-level employee (e.g., a subordinate) may not manage anyone.
- The maximum cardinality of the Supervisor role is N, as an employee can manage many subordinates.

### For the Subordinate role:

- The minimum cardinality is 0, as the CEO, for example, is not a subordinate to anyone.
- The maximum cardinality is 1, as a subordinate can have only one manager.

> Note: In this case, neither of the participants has total participation since the minimum cardinality for both roles is 0. Therefore, the relationship is represented with a single line (not a double line) in the ER diagram

Note: In this case, neither of the participants has total participation since the minimum cardinality for both roles is 0. Therefore, the relationship is represented with a single line (not a double line) in the ER diagram

## Implementing a Recursive Relationship

To implement a recursive relationship, a foreign key of the employee’s manager number would be held in each employee record. A sample table would look something like this:-

> Emp_entity( Emp_no,Emp_Fname, Emp_Lname, Emp_DOB, Emp_NI_Number, Manager_no);Manager no - (this is the employee no of the employee's manager)

Emp_entity( Emp_no,Emp_Fname, Emp_Lname, Emp_DOB, Emp_NI_Number, Manager_no);Manager no - (this is the employee no of the employee's manager)

### Example:

> CREATE TABLE employee ( id INT PRIMARY KEY, name VARCHAR(50), manager_id INT, FOREIGN KEY (manager_id) REFERENCES employee(id));

CREATE TABLE employee ( id INT PRIMARY KEY, name VARCHAR(50), manager_id INT, FOREIGN KEY (manager_id) REFERENCES employee(id));

Here, the employee table has a foreign key column called manager_id that references the id column of the same employee table. This allows you to create a recursive relationship where an employee can have a manager who is also an employee.

### Sample Employee Table Structure:

| Emp_no | Emp_Fname | Emp_Lname | Emp_DOB | Emp_NI_Number | Manager_no |
| --- | --- | --- | --- | --- | --- |
| 1 | John | Doe | 1980-01-01 | 123456789 | NULL |
| 2 | Jane | Smith | 1990-05-15 | 987654321 | 1 |
| 3 | Bob | Johnson | 1985-03-22 | 112233445 | 1 |

In this table:

- Manager_no refers to the Emp_no of the employee’s manager.
- The CEO (employee 1 in this example) does not have a manager, hence their Manager_no is NULL.