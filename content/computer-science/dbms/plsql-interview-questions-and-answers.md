---
title: "PL/SQL Interview Questions and Answers"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# PL/SQL Interview Questions and Answers
PL/SQL (Procedural Language for SQL) is one of the most widely used database programming languages in the world, known for its robust performance, flexibility, and tight [[integration]] with Oracle databases. It is a preferred choice for many top companies such as Oracle, IBM, Accenture, Infosys, TCS, Cognizant, and many more due to its powerful features and efficiency in managing database operations.

Here, we will provide 50+ PL/SQL interview questions and answers tailored for both freshers and experienced professionals with 3, 4, 7, or 10 years of experience. We cover everything, including core PL/SQL concepts, procedures and functions, triggers, exception handling, cursors, packages, performance tuning, and more. These questions will help you crack PL/SQL interviews.

## PL/SQL Basic Interview Questions

### 1. What are the features of PL/SQL?

- PL/SQL is a procedural language, which provides the functionality of decision making, iteration, and numerous further features of procedural programming languages.
- Using a single command, PL/SQL executes several queries in one block.
- PL/SQL can handle the exception generated in the PL/SQL block. That block is called an exception handling block.
- One can create a PL/SQL unit such as procedures, packages, triggers, functions, and types, which are stored in the database for reuse by applications.
- Applications that are written in PL/SQL are portable to computer hardware or operating systems where Oracle is functional.

### 2. What do you understand by PL/SQL Table?

A PL/SQL table is an ordered collection of elements of the same type, where the position of each element is determined by its [[index]]. A user-defined type must be declared first before declaring the PL/SQL table as a variable. Example:

> DECLARE TYPE Vehicle_SSN_tabtype IS TABLE OF INTEGER [[index|INDEX]] BY BINARY_INTEGER; Vehicle_SSN_table Vehicle_SSN_tabtype;END;

DECLARE

TYPE Vehicle_SSN_tabtype IS TABLE OF INTEGER [[index|INDEX]] BY BINARY_INTEGER;

Vehicle_SSN_table Vehicle_SSN_tabtype;

END;

### 3. Explain the basic structure followed in PL/SQL.

By including elements from procedural languages, PL/SQL expands SQL and creates a structural language that is more potent than SQL. A block is PL/SQL's fundamental building block. Every PL/SQL program is built around these blocks, and a block consists of three parts:

- Declaration: Used to declare variables and constants.
- Execution: Contains executable commands (SQL statements).
- Exception handling: Deals with errors during the execution phase

### 4. What is a PL/SQL cursor?

PL/SQL cursor controls the context area. A cursor holds one or more than one row returned by an SQL statement. There are set of rows which is held by the cursor is known as an active set.

Two types of cursors exist in PL/SQL.

- Implicit Cursor
- Explicit cursor

### 5. What is the use of WHERE CURRENT OF in cursors?

LAST FETCHED ROW identify by using WHERE CURRENT OF in cursor. We can use the WHERE CURRENT OF statement for updating or deleting records without using the SELECT FOR UPDATE statement. The record that was last retrieved by the cursor can be updated or deleted using the WHERE CURRENT OF statement.

Syntax:

> UPDATE table_name SET set_clause WHERE CURRENT OF cursor_name;

UPDATE table_name

SET set_clause

WHERE CURRENT OF cursor_name;

> DELETE FROM table_nameWHERE CURRENT OF cursor_name;

DELETE FROM table_name

WHERE CURRENT OF cursor_name;

### 6. How can a name be assigned to an unnamed PL/SQL Exception Block?

- PL/SQL Exception Block name can be assigned by using Pragma known as EXCEPTION_INIT.
- Our own error message and error number can be defined by using the Pragma EXCEPTION_INIT function.

Syntax:

> DECLAREexception_name EXCEPTION;PRAGMA EXCEPTION_INIT(exception_name, error_code);BEGIN// CodeEXCEPTIONWHEN exception _name THEN //exception handling stepsEND;

DECLARE

exception_name EXCEPTION;

PRAGMA EXCEPTION_INIT(exception_name, error_code);

BEGIN

// Code

EXCEPTION

WHEN exception _name THEN //exception handling steps

END;

### 7. What is a PL/SQL Trigger? Give some examples of when "Triggers" might be useful.

When a specific event takes place, the Oracle engine immediately starts. The trigger is already stored in the database If a certain condition is met, the trigger is frequently called from a database. Trigger mode can be activated or deactivated, but running explicitly is not possible.

Syntax:

> TRIGGER trigger_name trigger_event [ triggers restrictions ]BEGIN trigger_action;END;

TRIGGER trigger_name

trigger_event

[ triggers restrictions ]

BEGIN

trigger_action;

END;

In the above syntax, If the restrictions are TRUE or the trigger is unavailable, The trigger_event causes the database to fire the actions of the trigger if the trigger_name is enabled.

Below are some examples of where triggers might be useful.

Complex integrity constraints must be maintained.To enforce intricate business regulations.To audit any table information, if necessary.Triggers are used whenever changes are made to a table and we need to signal other actions after the change has been made.Additionally, it can be applied to stop fraudulent transactions.

### 8. When does a DECLARE block have to be present?

In PL/SQL anonymous blocks, such as stand-alone and non-stored procedures, a DECLARE statement is used. The statement in the stand-alone file should come first when they are used.

### 9. How should comments be written in PL/SQL code?

Two types of comments we can write in PL/SQL code.

- Single Line Comments
- Multiple Line Comments

Single Line Comments: We can use the -- symbol to comment on a single line in PL/SQL code.

Multiple Line Comments: We can use the/* lines*/ syntax to comment on multiple lines in PL/SQL code.

> DECLARE-- Hi Geeks, This is a single line comment.BEGIN/* Hi Geeks,This is Multiple line comments.*/END;

DECLARE

-- Hi Geeks, This is a single line comment.

BEGIN

/* Hi Geeks,

This is Multiple line comments.*/

END;

### 10. What is the purpose of the WHEN condition in the trigger?

The WHEN condition is used in row-level triggers to specify the condition under which the trigger is fired. The trigger will only execute if the condition is met

### 11. What are the Differences between SQL and PL/SQL?

| SQL | PL/SQL |
| --- | --- |
| SQL manages a relational database management system. | PL/SQL is a programming language for databases. |
| SQL can perform a single operation at a time. | PL/SQL can execute multiple operations at the same time. |
| SQL is an interpretive language. | it is a procedure language. |
| No variable is used in SQL. | PL/SQL consists of variables, datatype, etc. |
| SQL directly connects with the database server. | PL/SQL does not directly connect with the database server. |
| it is a data data-oriented language. | It is application application-oriented language. |
| It can not contain PL/SQL Language. | It can contain SQL inside it. |
| It is used to perform DDL and DML operations. | PL/SQL performs blocks, functions, procedures and triggers. |

SQL

PL/SQL

### 12. Why are SYSDATE and USER keywords used?

SYSDATE:

The local database server's current time and date are returned by the SYSDATE keyword.

Example:

> SELECT SYSDATE FROM dual;

SELECT SYSDATE FROM dual;

USER :

The user id of the current session will be returned by using the USER keyword.

Example:

> SELECT USER FROM dual;

SELECT USER FROM dual;

### 13. What is the Difference between implicit cursor and explicit cursor?

| Implicit Cursor | Explicit Cursor |
| --- | --- |
| Implicit cursor is automatically created cursor. | An explicit cursor is defined by the user. |
| Implicit cursor can fetch a single row at a time. | The explicit cursor can fetch multiple rows at the same time. |
| It gives less programmatic control to programmers. | The explicit cursor is totally controlled by programmers. |
| It is less efficient to explicit cursor. | An explicit cursor is more efficient. |
| Implicit cursor attributes always use the prefix "SQL" keyword.structure for implicit cursor defined as SQL%attri_name.some mor implicit cursors are SQL%FOUND, SQL%NOTFOUND, SQL%ROWCOUNT. | Explicit cursors structure: curs_name%attri_nameSome more explicit cursors are curs_name%FOUND, curs_name%NOTFOUND, curs_name%ROWCOUNT. |

Implicit cursor attributes always use the prefix "SQL" keyword.

structure for implicit cursor defined as SQL%attri_name.

some mor implicit cursors are SQL%FOUND, SQL%NOTFOUND, SQL%ROWCOUNT.

Explicit cursors structure: curs_name%attri_name

Some more explicit cursors are curs_name%FOUND, curs_name%NOTFOUND, curs_name%ROWCOUNT.

### 14. Tell the importance of %TYPE and %ROWTYPE data types in PL/SQL.

%Type:

This datatype is used for specified tables to define the variable as its column name datatype.

Syntax:

> vAttributName Attribute.Attribute_Name%TYPE;

vAttributName Attribute.Attribute_Name%TYPE;

In the above syntax, the datatype of Attribute_Name is assigned to the variable named vAttributeName.

%ROWTYPE:

Use %ROWTYPE if the programmer doesn't know the datatype of the specified column but still needs to assign it to the variable. It is nothing more than an assignment in an array in which we can specify a variable and define the entire row datatype.

Syntax:

> Rt_var_Student Student%ROWTYPE;

Rt_var_Student Student%ROWTYPE;

%ROWTYPE assigns the data type of the Student table to the Rt_var_Student variable.

### 15. What are the differences between ROLLBACK and ROLLBACK TO statements in PL/SQL?

- The ROLLBACK command is used to undo any modification made since the transaction's start.
- The transaction may only be rolling back using the ROLLBACK TO command up to a SAVEPOINT. The transaction stays active even before the command is provided since the transactions cannot be rolled back before the SAVEPOINT.

### 16. What are the uses of SYS.ALL_DEPENDENCIES?

The dependencies between all the procedures, packages, triggers, and functions that the current user can access are described by SYS.ALL_DEPENDENCIES.

### 17. What the virtual tables exist during the execution of the database trigger?

- OLD and NEW two are virtual tables that exist during the execution of the database trigger.
- OLD and NEW both are accessible by UPDATE statement.
- INSERT statement can access only NEW value.

### 18. What is the Difference between the cursors declared in procedures and in the package specifications?

The cursor declared in a package specification is global and can be accessed by other procedures or procedures in the package. A cursor declared in a procedure is local that can not be accessed by other procedures.

### 19. What is purposes of COMMIT, ROLLBACK and SAVEPOINT statements in PL/SQL?

COMMIT statement: The changes made during a transaction are saved permanently by the COMMIT command.

Syntax:

> DECLAREBEGIN// command;COMMIT;END;

DECLARE

BEGIN

// command;

COMMIT;

END;

ROLLBACK statement: It is used to undo any modification made since the transaction's start.

Syntax:

> DECLAREBEGIN// command;ROLLBACK;END;

DECLARE

BEGIN

// command;

ROLLBACK;

END;

SAVEPOINT statement: A transaction point that can be utilised to roll back to a certain point in the transaction is created using the SAVEPOINT statement.

Syntax:

> DECLAREBEGINSAVEPOINT sp;// command;ROLLBACK TO sp;END;

DECLARE

BEGIN

SAVEPOINT sp;

// command;

ROLLBACK TO sp;

END;

### 20. How can we debug our PL/SQL code?

To debug our PL/SQL code, we can use the DBMS_OUTPUT and DBMS_DEBUG statements. The output is printed to the standard console via DBMS_OUTPUT. The output is printed to the log file by DBMS_DEBUG.

## Intermediate PL/SQL Interview Questions

### 21. What is the main difference between a mutating table and a constraining table?

A table that can be changed using a DML statement or one with triggers defined is said to be a mutating table. The table that is read for a referential integrity constraint is referred to as a constraining table.

### 22. Describe the data types present in PL/SQL.

There are two types of data types present in PL/SQL.

- Scalar data types: NUMBER, DATE, CHAR, VARCHAR2, BOOLEAN and LONG are scalar data types.
- Composite data type: TABLE and RECORD are composite data types.

### 23. List the types of exceptions in PL/SQL.

Two types of exceptions are present in PL/SQL.

- Pre-defined exceptions: These are exceptions that are automatically handled by Oracle (e.g., NO_DATA_FOUND, TOO_MANY_ROWS).
- User-defined exceptions: These are exceptions defined by the user to handle specific errors in the program.

`NO_DATA_FOUND`

`TOO_MANY_ROWS`

### 24. What types of commands PL/SQL does not support?

PL/SQL does not support data definition commands like CREATE, ALTER etc.

### 25. Name some PL/SQL exceptions.

Below are some PL/SQL exceptions.

- INVALID_NUMBER
- TOO_MANY_ROWS
- ACCESS_INTO_NULL
- CASE_NOT_FOUND
- ZERO_ERROR
- NO_DATA_FOUND

### 26. What is a PL/SQL package?

Packages are schema objects that group PL/SQL types, variables, and subprograms that are logically related.

A package will have two parts.

- Package specification
- Package body or definition

Syntax:

> package_name.attribute_name;

package_name.attribute_name;

### 27. Write a PL/SQL program to find a given string is palindrome.

> DECLARE-- Declared variablestring VARCHAR(10):="abababa";letter VARCHAR(20);recerse_string VARCHAR(10);BEGINFOR i IN REVERSE 1.. LENGTH(string) LOOPletter := SUBSTR(string, i, 1);-- concatenate letter to reverse_string variablereverse_string := reverse_string || " ||letter;END LOOP;IFreverse_string = string THEN dbms_output.Put_line(reverse_string||"||' is palindrome');ELSEdbms_output.Put_line(reverse_string||"||' is not palindrome');END IFEND;

DECLARE

-- Declared variable

string VARCHAR(10):="abababa";

letter VARCHAR(20);

recerse_string VARCHAR(10);

BEGIN

FOR i IN REVERSE 1.. LENGTH(string) LOOP

letter := SUBSTR(string, i, 1);

-- concatenate letter to reverse_string variable

reverse_string := reverse_string || " ||letter;

END LOOP;

reverse_string = string THEN dbms_output.Put_line(reverse_string||"||' is palindrome');

ELSE

dbms_output.Put_line(reverse_string||"||' is not palindrome');

END IF

END;

### 28. What command will you use to delete a package?

we use the DROP PACKAGE statement to delete a package.

Syntax:

> DROP PACKAGE [BODY] Attribute_Name.Package_Name;

DROP PACKAGE [BODY] Attribute_Name.Package_Name;

### 29. How will you execute a stored procedure?

EXECUTE or EXEC keyword can be used to execute stored procedures.

Syntax:

> EXECUTE procedure_name;orEXEC procedure_name;

EXECUTE procedure_name;

EXEC procedure_name;

### 30. Explain the IN, OUT and IN OUT parameters.

IN: We can transmit values to the procedure that is being called using the IN parameter. You can use the default settings for the IN parameter. IN parameter behaves as a constant.

OUT: The caller receives a value from the OUT parameter. It is an uninitialized variable.

IN OUT: The IN OUT parameter gives starting values to a procedure and sends the updated values to the caller. IN OUT parameter should be like an initialized variable.

### 31. Differentiate between %ROWTYPE and %TYPE.

%ROWTYPE: It is used to declare a variable that has the structure of the records in a table.

%TYPE: To declare a column in a table that contains the value of that column, use the %TYPE property. The variable's data type and the table's column are the same.

### 32. Discuss SQLERRM and SQLCODE. What is the importance of PL/SQL?

- SQLCODE returns the error number for the most recent error found.
- SQLERRM returns the error message for the most recent error.

SQLCODE and SQLERRM can be used in exception handling in PL/SQL to report the error that happened in the code in the error log database.

### 33. What are PL/SQL records? tell types of records.

A record is a type of data structure that may store several types of data elements. Like a row in a database table, a record is made up of various fields.

There are three types of records in PL/SQL.

- Table-based records
- Cursor-based records
- User-defined records are created by programmers.

### 34 Explain the BTITLE and TTITLE statements.

TTITLE statement is used to define the top title similarly for defining the bottom title we will use BTITLE statement.

### 35. What are the valid DateTime values for seconds in PL/SQL?

The following are valid second values:

- 00 to 59.9(n), where 9(n) is the accuracy in fractional seconds of time.
- For DATE, the 9(n) section does not apply.

### 36 Explain PL/SQL Delimiters.

In PL/SQL, a delimiter is a compound symbol having a unique meaning. Delimiters are used to indicate arithmetic operations like division, addition etc.

### 37. What is the use of a UTL_FILE package in PL/SQL?

UTL_FILE package is used for read/write operating system text files. Both client-side and server-side PL/SQL are supported, and it offers a constrained variant of the operating system's stream file I/O.

> DECLAREFileHandler UTL_FILE.FILE_TYPE;BEGINFileHandler:= UTL_FILE.FOPEN(--file root);END;

DECLARE

FileHandler UTL_FILE.FILE_TYPE;

BEGIN

FileHandler:= UTL_FILE.FOPEN(--file root);

END;

### 38. What is the use of index in PL/SQL?

A table's data blocks can be accessed more quickly and effectively with the help of an [[index]].

### 39. What does the error ORA-03113 mean?

An ORA-3113 means "end of file on communication channel". A client process connected to an Oracle database will typically report an ORA-3113. these are some following scenarios when ORA-3113 can occur:

- When a server machine crashed
- At the operating system level, our server process was killed.
- Few netwFpackagesork problems
- The client is not handling multiple connections

### 40. What is a Join?

The join keyword is used to query data from multiple tables. Join is based on the relationship between the fields of tables. Table keys play an important role in Joins.

### 41. How can we write or create multiple tables in PL/SQL?

Nested tables are collection types in PL/SQL. Nested tables are created either in the PL/SQL block or at the schema level. These are like a 1D array, but their size can be increased or decreased dynamically.

Syntax:

> TYPE type_name IS TABLE OF element_type [NOT NULL];name_of_table type_name;

TYPE type_name IS TABLE OF element_type [NOT NULL];

name_of_table type_name;

## Advanced PL/SQL Interview Questions

### 42. Discuss the concept of Raise_application_error.

From stored subprograms, this procedure can be used to send user-defined error messages. By informing our application of failures, we can stop unhandled exceptions from being returned. the executable section and the exceptional section are two places that appear in it.

Syntax:

> raise_application_error(error_number, message[, {TRUE | FALSE}]);

raise_application_error(error_number, message[, {TRUE | FALSE}]);

### 43. What do you know about pragma_exception_init in PL/SQL?

An exception name and Oracle error number are linked together by the pragma_exception_init command in PL/SQL. This makes it possible to create a unique handler for any internal exception are refer to it by name.

### 44. How can you verify whether an Update Statement is Executed or not, In PL/SQL?

The SQL % NOTFOUND attribute can be used to determine whether or not the UPDATE statement successfully changed any records. If the last SQL statement run had no effect on any rows, this variable returns TRUE.

### 45. What is the use of the || Operator?

The || operator is used to combine the strings. Both DBMS_OUTPUT.put line and select statements functions use the || operator.

### 46. Is a definition command like the CREATE command supported in PL/SQL?

Definition commands like the CREATE command are not supported by PL/SQL.

### 47. Explain a view.

A view is generated by combining one or more tables. it is a virtual table that is based on the outcome of SQL statements; It includes rows and columns like an actual table.

Syntax:

> CREATE VIEW view_name AS SELECT columns FROM tables;

CREATE VIEW view_name AS SELECT columns FROM tables;

### 48. What are the basic parts of triggers?

The following three are basic parts of a trigger.

- Trigger statement
- Trigger restriction
- Trigger action

### 49. What are the Methods to Trace the PL/SQL Code?

We will trace the code to measure its performance during run time. below are some methods to trace the PL/SQL code.

- DBMS_TRACE
- DBMS_APPLICATION_INFO
- DBMS_SESSION
- DBMS_MONITOR

### 50. How do you Create Nested Tables in PL/SQL?

One of the collection types is nested tables in PL/SQL. Nested tables can be created in a PL/SQL block or at the schema level, also similar to a 1D array but their size can be extended dynamically.

> TYPE type _name IS TABLE OF element_type [NOT NULL];table_name typer_name;DECLARETYPE deptname IS TABLEOF VARVHAR2(10);TYPE budget IS TABLE OF INTEGER;names deptname;deptbudget budget;BEGINnames := deptname ('marketing, 'development', 'sales');deptbudget := budget (12567, 4567, 1234);FOR i IN 1 . . names.count LOOPdbms_output.put_line('Department = '| |names(i)| |', Budget = ' | | deptbudget(i));end loop;END;

TYPE type _name IS TABLE OF element_type [NOT NULL];

table_name typer_name;

DECLARE

TYPE deptname IS TABLEOF VARVHAR2(10);

TYPE budget IS TABLE OF INTEGER;

names deptname;

deptbudget budget;

BEGIN

names := deptname ('marketing, 'development', 'sales');

deptbudget := budget (12567, 4567, 1234);

FOR i IN 1 . . names.count LOOP

dbms_output.put_line('Department = '| |names(i)| |', Budget = ' | | deptbudget(i));

end loop;

END;

![PL/SQL Interview Questions and Answers](images/plsql-interview-questions-and-answers.webp)