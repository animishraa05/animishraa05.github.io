---
title: "Commonly asked DBMS Interview Questions | Set 2"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Commonly asked DBMS Interview Questions | Set 2
This article is an extension of Commonly asked DBMS interview questions | Set 1.

### Q1. There is a table where only one row is fully repeated. Write a Query to find the repeated row

| Name | Section |
| --- | --- |
| abc | CS1 |
| bcd | CS2 |
| abc | CS1 |

In the above table, we can find duplicate rows using the following query.

```
SELECT name, section FROM tbl
GROUP BY name, section
HAVING COUNT(*) > 1
```

### Q2. Query to find 2nd highest salary of an employee?

```
SELECT max(salary) FROM EMPLOYEES WHERE salary IN
(SELECT salary FROM EMPLOYEEs MINUS SELECT max(salary)
FROM EMPLOYEES);
```

```
SELECT max(salary) FROM EMPLOYEES WHERE 
salary <> (SELECT max(salary) FROM EMPLOYEES);
```

### Q3. Consider the following Employee table. How many rows are there in the result of the following query?

| ID | Salary | DeptName |
| --- | --- | --- |
| 1 | 10000 | EC |
| 2 | 40000 | EC |
| 3 | 30000 | CS |
| 4 | 40000 | ME |
| 5 | 50000 | ME |
| 6 | 60000 | ME |
| 7 | 70000 | CS |

How many rows are there in the result of the following query?

```
SELECT E.ID
FROM  Employee E
WHERE  EXISTS  (SELECT E2.salary
FROM Employee E2
WHERE E2.DeptName = 'CS'
AND   E.salary > E2.salary)
```

Following 5 rows will be the result of the query as 30000 is the minimum salary of CS Employees and all these rows are greater than 30000. 2 4 5 6 7

### Q4. Write a trigger to update Emp table such that, If an updation is done in Dep table then salary of all employees of that department should be incremented by some amount (updation)

Assuming Table name are Dept and Emp, trigger can be written as follows:

```
CREATE OR REPLACE TRIGGER update_trig
AFTER UPDATE ON Dept
FOR EACH ROW
DECLARE
CURSOR emp_cur IS SELECT * FROM Emp;
BEGIN
FOR i IN emp_cur LOOP
IF i.dept_no = :NEW.dept_no THEN
DBMS_OUTPUT.PUT_LINE(i.emp_no);  --  for printing those
UPDATE Emp                      -- emp number which are
SET sal = i.sal + 100           -- updated
WHERE emp_no = i.emp_no;
END IF;
END LOOP;
END;
```

### Q5. There is a table which contains two columns Student and Marks, you need to find all the students, whose marks are greater than average marks i.e. list of above-average students.

```
SELECT student, marks 
FROM table
WHERE marks > (SELECT AVG(marks) from table);
```

### Q6. Name the Employee who has the third-highest salary using sub queries.

```
SELECT Emp1.Name
FROM Employee Emp1
WHERE 2 = (SELECT COUNT(DISTINCT(Emp2.Salary))
           FROM Employee Emp2
           WHERE Emp2.Salary > Emp1.Salary
  )
```

> Logic: Number of people with a salary higher than this person will be 2.

Logic: Number of people with a salary higher than this person will be 2.

### Q7. Why we cannot use WHERE clause with aggregate functions like HAVING ?

The difference between the having and where clause in SQL is that the where clause canNOT be used with aggregates, but the having clause can.

Note: It is not a predefined rule but by and large you’ll see that in a good number of the SQL queries, we use WHERE prior to GROUP BY and HAVING after GROUP BY. The Where clause acts as a pre filter where as Having as a post filter. The where clause works on row's data, not on aggregated data.

Let us consider below table 'Marks'.

| Student | Course | Score |
| --- | --- | --- |
| a | c1 | 40 |
| a | c2 | 50 |
| b | c3 | 60 |
| d | c1 | 70 |
| e | c2 | 80 |

```
SELECT Student, sum(Score) AS total 
FROM Marks
```

This would select data row by row basis. The having clause works on aggregated data. For example, the output of the below query

```
SELECT Student, sum(score) AS total FROM Marks
```

| Student | Total |
| --- | --- |
| a | 90 |
| b | 60 |
| d | 70 |
| e | 80 |

When we apply to have in above query, we get

```
SELECT Student, sum(score) AS total
FROM Marks having total > 70
```

| Student | Total |
| --- | --- |
| a | 90 |
| e | 80 |

### Q8. Difference between primary key and unique key and why one should use a unique key if it allows only one null ?

Primary key:

- Only one in a row(tuple).
- Never allows null value(only key field).
- Unique key identifier can not be null and must be unique.

Unique Key:

- Can be more than one unique key in one row.
- Unique key can have null values(only single null is allowed).
- It can be a candidate key.
- A Unique Key ensures all values are unique.

### Q9. What's the difference between materialized and dynamic view?

Materialized views:

- Disk-based and are updated periodically based upon the query definition.
- A materialized table is created or updated infrequently and it must be synchronized with its associated base tables.

Dynamic views:

- Virtual only and run the query definition each time they are accessed.
- A dynamic view may be created every time that a specific view is requested by the user.

### Q10. What is embedded and dynamic SQL?

Static or Embedded SQL:

- SQL statements in an application that do not change at runtime and, therefore, can be hard-coded into the application.

Dynamic SQL:

- SQL statements that are constructed at runtime; for example, the application may allow users to enter their own queries.
- Dynamic SQL is a programming technique that enables you to buildSQL statements dynamically at runtime. You can create more general purpose, flexible applications by using dynamic SQL because the full text of a SQL statement may be unknown at compilation.

| Static (embedded) SQL | Dynamic (interactive) SQL |
| --- | --- |
| In static SQL how database will be accessed is predetermined in the embedded SQL statement. | In dynamic SQL, how database will be accessed is determined at run time. |
| It is more swift and efficient. | It is less swift and efficient. |
| SQL statements are compiled at compile time. | SQL statements are compiled at run time. |
| Parsing, validation, optimization, and generation of application plan are done at compile time. | Parsing, validation, optimization, and generation of application plan are done at run time. |
| It is generally used for situations where data is distributed uniformly. | It is generally used for situations where data is distributed non-uniformly. |
| EXECUTE IMMEDIATE, EXECUTE and PREPARE statements are not used. | EXECUTE IMMEDIATE, EXECUTE and PREPARE statements are used. |
| It is less flexible. | It is more flexible. |

### Q11. What is the difference between CHAR and VARCHAR?

- CHAR and VARCHAR differ in storage and retrieval.
- CHAR column length is fixed while VARCHAR length is variable.
- The maximum no. of characters CHAR data type can hold is 255 characters while VARCHAR can hold up to 4000 characters.
- CHAR may be slightly faster than VARCHAR for fixed-length data.
- CHAR uses static memory allocation while VARCHAR uses dynamic memory allocation.

> Practice Quizzes on DBMSLast Minute Notes - DBMSDBMS Articles

- Practice Quizzes on DBMS
- [[last-minute-notes-dbms|Last Minute Notes - DBMS]]
- DBMS Articles