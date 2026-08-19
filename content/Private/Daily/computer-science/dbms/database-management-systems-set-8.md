---
title: "Database Management Systems | Set 8"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Database Management Systems | Set 8
```

A   C
-----
2   4
3   4
4   3
5   2
7   2
9   5
6   4

```

```

  select title
  from book as B
  where (select count(*)
     from book as T
     where T.price > B.price) < 5

```