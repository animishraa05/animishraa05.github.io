---
title: "Database Management Systems | Set 11"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Database Management Systems | Set 11
![](images_gate2009dbms12.gif)

```

studinfo table
studid   name    sex
------------------------
 1        a      Male
 2        c      Female 
 3        d      Female 

enroll table
studid  courseid
------------------
 1         1
 2         1
 3         1
 2         2 
 3         3
 3         2    


Result of step b
studid     courseid
---------------------
 2             1
 2             2
 2             3
 3             1
 3             2
 3             3  


Result of step c
studid    courseid
-------------------
 2           3

```

![](images_gate2009dbms22.gif)

```

Q1 : Select e.empId
     From employee e
     Where not exists
        (Select * From employee s where s.department = “5” and 
                                        s.salary >=e.salary)
Q2 : Select e.empId
     From employee e
     Where e.salary > Any
    (Select distinct salary From employee s Where s.department = “5”)

```

![](images_gate2009dbms3.gif)

```

Schedule S1
   T1            T2
---------------------
  r1(X)
  r1(Y)
                r2(X)
                r2(Y)
                w2(Y)
  w1(X)
The schedule is neither conflict equivalent to T1T2, nor T2T1.

Schedule S2
   T1            T2
---------------------
  r1(X)
                r2(X)
                r2(Y)
                w2(Y)
  r1(Y)
  w1(X)
The schedule is conflict equivalent to T2T1.

```