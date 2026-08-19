**A pretty common thing asked usually about the difference between drop, truncate and delete also the difference between**

**update and alter**

- usually alter is A part of DDL language and it directly affects the structure or schema of the database.
- update is a part of DML language and it directly affect the data in the database.

- in alter you can not use where clause, whereas in the update you do.

Alter is usually used for following changes-

- modify the attribute,
  i.e., add a new column, drop a column
- modify the data type,
  - i,e,. change the data type from int to varchar or vice versa
    Also remember that alter is used after the table is created for modification.
- also used to change the [[constraints in sql | constraints]] of the table.

update is usually used for the following changes-

- modify the data in the table,
  i.e., add a new tuple, delete a tuple

For example.

**ALter**

- add, delete,
  ==for the changes in column.  
  Alter table table*name add employee* id (int);
  or
  Alter table Table_name remove employee_id;
  you dont need the datatype in remove==

also you can change the data type using alter

Alter table table_name modify employee_id varchar(9);
desc table_name;

// this will show the datatype changed as varchar

**_==also when using it to rename any attribute name we can use rename nd to keyword==**

alter table table_name empolyee_id rename to emp_id;

Update is used like
update table_name
set employee_id =10 or set salary = salary \* 2;

also where can be used, like where employee_id = 10;

this will double the salary of employee with id 10

Talking about delete, drop and truncate.

both truncate and drop are DDL commands whereas the deelte is a DML command.

Now about delete, used to delete rows from a table, but the difference is we can specify condition in this using where, and others.
can be used like this

delete from table_name where condition;

So deleting of a row of table doesnt destroy or make the schema worse unlike drop which directly removes the table and drops the schema.
like
Drop table table_name;

truncate is usally same as update as it deletes the rows from the table.

But the difference comes in the ways of execution.

_truncate_ does not create any log fileof its deletion and completes the entire process very fast so it cannot be rollbacked and also does not really create any snapshot of it. you can not use it to delete one row as it deletes all the rows
update makes a log file, can be rollbacked if not commited and also used with condition to delete one tuple.

