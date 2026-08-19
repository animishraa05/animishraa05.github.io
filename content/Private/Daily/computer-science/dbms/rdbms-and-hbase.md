---
title: "RDBMS and HBase"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# RDBMS and HBase
Field of data management needs various database systems to be employed based on the type, volume, and structural complexity of the data. Two widely adopted approaches are:

1. Relational Database Management Systems (RDBMS)
2. Hadoop Database (HBase)

## RDBMS (Relational Database Management System)

Relational Database Management System stores the data in the form of relations or Tables in various rows and columns, by utilizing the SQL (Structured Query Language). Some popular RDBMS systems are MySQL, PostgreSQL, Oracle DB & many more.

- Data should be stored in a structured manner in the case of RDBMS.
- Each table has rows ( records ) & columns ( attributes ), and these tables are related to each other.
- SQL is used to manage the data in the RDBMS, and SQL is most suitable for structured and well-organized data.

![rdbms](images_rdbms.png)

### Advantages

- Structured Data: RDBMS is best suitable for storing the structured Data like employee details, financial records, etc.
- ACID Properties: RDBMS ensures Atomicity, Consistency, Isolation, Durability of the data, this make it reliable for transactions.
- Data Integrity: Due the use of Key Constraints like Candidate key, Primary key, Foreign key it ensures the integrity of Data.
- Simple to Write Query: RDBMS support the usage of SQL language to shoot the query.

### Disadvantages

- Scalability Issue: Scalability of RDBMS across the servers ( Horizontal scaling ) is not possible, as the data grows.
- Rigid Schema: RDBMS have the fixed schema, so it became difficult to make change in structure like adding new column or other attribute .
- Not Efficient for Big Data: While working with large dataset, RDBMS faces certain performance related issues.

## HBase (Hadoop Database)

HBase is a NoSQL type of database means it support the flexible schema, that runs on the Hadoop Distributed File System (HDFS). It is basically designed to handle large scale data, unstructured type of data, semi-structured type of data across the distributed system.

- In case of HBase we don't need to follow the fixed schema and allows us to store data in more flexible manner.
- Basically it only works when the particular system must contains the Hadoop Ecosystem.

![hbase](images_hbase.png)

### Advantages

- Scalability: HBase are highly scalable and can handle very large of data even in petabytes of data across the server, so it is perfect for huge data oriented applications.
- Flexible Schema: Not at all like RDBMS , HBase have flexible schema, which makes it appropriate to store the unstructured data.
- Distributed architecture: HBase is designed to work proficiently in the distributed environment, providing higher availability of data with high fault resistance capability.

### Disadvantages

- Complex Design: Setting up and maintaining HBase is vey complex due to its complex architecture design.
- Lack of ACID Properties: HBase doesn't fully support the ACID Properties , so it is not suitable for transactions property.
- Doesn't Support SQL: HBase doesn't support SQL & in case we are working on structured data then, RDBMS is most superior option to utilize.

## When to use RDBMS vs HBase ?

RDBMS:

- Small to medium datasets: If the data size is manageable and can handled by the single server and structured type of datasets then RDBMS can handle effectively.
- Transaction Support: Application that requires strong consistency , like banking application , e-commerce application , where the data integrity is very crucial then use RDBMS.
- Structured Data: If dataset is properly structured , then we must opt for RDBMS.

HBase:

- Big Data Application: If you're dealing with very large dataset petabytes of data , also it spread across the various server , then HBase is better choice.
- Unstructured / Semi-structured Data: If data set is unstructured / semi-structured or data doesn't fit into rows and columns
- Real-time Analytics: For application that requires real-time querying over the datasets.

## RDBMS vs HBase

| RDBMS | HBase |
| --- | --- |
| SQL ( Structured Query language) | No-SQL (non-relational) |
| Static in nature | Dynamic in nature |
| Slower retrieval of data. | Faster retrieval of data. |
| Follows the ACID (Atomicity, Consistency, Isolation, and Durability) property. | Follows CAP (Consistency, Availability, Partition-tolerance) theorem. |
| It cannot handle sparse data. | Handles sparse data. |
| The amount of data in RDBMS is determined by the server's configuration. | The amount of data depends on the number of machines deployed rather than on a single machine. |
| Referential integrity is supported by RDBMS. | When it comes to referential integrity, no built-in support is available. |
| RDBMS provide native recovery & backup option. | Backup & recovery mechanism is complex and depends on underlying Hadoop infrastructure. |

SQL ( Structured Query language)

No-SQL (non-relational)

RDBMS provide native recovery & backup option.

Backup & recovery mechanism is complex and depends on underlying Hadoop infrastructure.