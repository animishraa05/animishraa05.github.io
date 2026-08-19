---
title: "Database Management Systems | Set 3"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Database Management Systems | Set 3
```

T1: read (P) ;
    read (Q) ;
    if P = 0 then Q : = Q + 1 ;
    write (Q) ;
T2: read (Q) ;
    read (P) ;
    if Q = 0 then P : = P + 1 ;
    write (P) ;

```

![DBMSGATE20124](images_dbmsgate20124.png)

```

Table A
Id   Name    Age
----------------
12   Arun    60
15   Shreya  24
99   Rohit   11


Table B
Id   Name   Age
----------------
15   Shreya  24
25   Hari    40
98   Rohit   20
99   Rohit   11


Table C
Id   Phone  Area
-----------------
10   2200   02  
99   2100   01

```

```

Result of AUB will be following table

Id   Name    Age
----------------
12   Arun    60
15   Shreya  24
99   Rohit   11
25   Hari    40
98   Rohit   20

The result of given relational algebra expression will be

Id   Name    Age  Id   Phone Area
---------------------------------
12   Arun    60   10   2200   02 
15   Shreya  24   10   2200   02   
99   Rohit   11   10   2200   02 
25   Hari    40   10   2200   02 
98   Rohit   20   10   2200   02 
99   Rohit   11   99   2100   01
98   Rohit   20   99   2100   01

```

```

SELECT A.id 
FROM   A 
WHERE  A.age > ALL (SELECT B.age 
                    FROM   B 
                    WHERE  B. name = "arun") 

```