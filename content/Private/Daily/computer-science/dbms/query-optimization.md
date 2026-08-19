---
title: "Query Optimization"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Query Optimization
A single query can be executed in many ways. Query optimization helps choose the most efficient plan by comparing different execution methods to find the one with the lowest cost.Importance: The goal of query optimization is to reduce the system resources required to fulfill a query, and ultimately provide the user with the correct result set faster.

- First, it provides the user with faster results, which makes the application seem faster to the user.
- Secondly, it allows the system to service more queries in the same amount of time, because each request takes less time than unoptimized queries.
- Thirdly, query optimization ultimately reduces the amount of wear on the hardware (e.g. disk drives), and allows the server to run more efficiently (e.g. lower power consumption, less memory usage).

## Optimizing Query

To optimize a query, we use equivalence rules to rewrite it into simpler, equivalent relational algebra expressions. Below are some of the ways to optimize queries:

1. Conjunctive selection operations can be written as a sequence of individual selections. This is called a sigma-cascade.

\sigma_{\theta_{1}\Lambda\theta_{2} }(E)=\sigma_{\theta_{1}}(\sigma_{\theta_{2}}(E))

Explanation: Applying condition \theta_{1}intersection \theta_{2}is expensive. Instead, filter out tuples satisfying condition \theta_{2}(inner selection) and then apply condition \theta_{1}(outer selection) to the then resulting fewer tuples. This leaves us with less tuples to process the second time. This can be extended for two or more intersecting selections. Since we are breaking a single condition into a series of selections or cascades, it is called a "cascade".

2. Selection is commutative.

\sigma_{\theta_{1}}(\sigma_{\theta_{2}}(E))=\sigma_{\theta_{2}}(\sigma_{\theta_{1}}(E))

Explanation: \sigmacondition is commutative in nature. This means, it does not matter whether we apply \sigma_{1}first or \sigma_{2}first. In practice, it is better and more optimal to apply that selection first which yields a fewer number of tuples. This saves time on our outer selection.

3. All following projections can be omitted, only the first projection is required. This is called a pi-cascade. \pi_{L_{1}}(\pi_{L_{2}}(...(\pi_{L_{n}}(E))...)) = \pi_{L_{1}}(E) Explanation: A cascade or a series of projections is meaningless. This is because in the end, we are only selecting those columns which are specified in the last, or the outermost projection. Hence, it is better to collapse all the projections into just one i.e. the outermost projection.

4. Selections on Cartesian Products can be re-written as Theta Joins.

- Equivalence 1\sigma_{\theta}(E_{1} \times E_{2}) = E_{1} \bowtie_{\theta} E_{2}Explanation: The cross product operation is known to be very expensive. This is because it matches each tuple of E1 (total m tuples) with each tuple of E2 (total n tuples). This yields m*n entries. If we apply a selection operation after that, we would have to scan through m*n entries to find the suitable tuples which satisfy the condition \theta. Instead of doing all of this, it is more optimal to use the Theta Join, a join specifically designed to select only those entries in the cross product which satisfy the Theta condition, without evaluating the entire cross product first.
- Equivalence 2 \sigma_{\theta_{1}}(E_{1} \bowtie_{\theta_{2}} E_{2}) = E_{1} \bowtie_{\theta_{1} \Lambda \theta_{2}} E_{2} Explanation: Theta Join radically decreases the number of resulting tuples, so if we apply an intersection of both the join conditions i.e. \theta_{1}and \theta_{2}into the Theta Join itself, we get fewer scans to do. On the other hand, a \sigma_{1}condition outside unnecessarily increases the tuples to scan.

5. Theta Joins are commutative. E_{1} \bowtie_{\theta} E_{2} = E_{2} \bowtie_{\theta} E_{1} Explanation: Theta Joins are commutative, and the query processing time depends to some extent which table is used as the outer loop and which one is used as the inner loop during the join process (based on the indexing structures and blocks).

6. Join operations are associative.

- Natural Join: (E_{1} \bowtie E_{2}) \bowtie E_{3} = E_{1} \bowtie (E_{2} \bowtie E_{3}) Explanation: Joins are all commutative as well as associative, so one must join those two tables first which yield less number of entries, and then apply the other join.
- Theta Join (E_{1} \bowtie_{\theta_{1}} E_{2}) \bowtie_{\theta_{2} \Lambda \theta_{3}} E_{3} = E_{1} \bowtie_{\theta_{1} \Lambda \theta_{3}} (E_{2} \bowtie_{\theta_{2}} E_{3}) Explanation: Theta Joins are associative in the above manner, where \theta_{2}involves attributes from only E2 and E3.

7. Selection operation can be distributed.

- Equivalence 1\sigma_{\theta_{1}\Lambda\theta_{2}}(E_{1}\bowtie_{\theta}E_{2})=(\sigma_{\theta_{1}}(E_{1}))\bowtie_{\theta}(\sigma_{\theta_{2}}(E_{2})) Explanation: Applying a selection after doing the Theta Join causes all the tuples returned by the Theta Join to be monitored after the join. If this selection contains attributes from only E1, it is better to apply this selection to E1 (hence resulting in a fewer number of tuples) and then join it with E2.
- Equivalence 2 \sigma_{\theta_{0}}(E_{1}\bowtie_{\theta}E_{2})=(\sigma_{\theta_{0}}(E_{1}))\bowtie_{\theta}E_{2} Explanation: This can be extended to two selection conditions, \theta_{1}and \theta_{2}, where Theta1 contains the attributes of only E1 and \theta_{2}contains attributes of only E2. Hence, we can individually apply the selection criteria before joining, to drastically reduce the number of tuples joined.

8. Projection distributes over the Theta Join.

- Equivalence 1 \pi_{L_{1}\cup L_{2}}(E_{1}\bowtie_{\theta}E_{2})=(\pi_{L_{1}}(E_{1}))\bowtie_{\theta}(\pi_{L_{2}}(E_{2})) Explanation: The idea discussed for selection can be used for projection as well. Here, if L1 is a projection that involves columns of only E1, and L2 another projection that involves the columns of only E2, then it is better to individually apply the projections on both the tables before joining. This leaves us with a fewer number of columns on either side, hence contributing to an easier join.
- Equivalence 2 \pi_{L_{1}\cup L_{2}}(E_{1}\bowtie_{\theta}E_{2})=\pi_{L_{1}\cup L_{2}}((\pi_{L_{1}\cup L_{3}}(E_{1}))\bowtie_{\theta}(\pi_{L_{2}\cup L_{3}}(E_{2}))) Explanation: Here, when applying projections L1 and L2 on the join, where L1 contains columns of only E1 and L2 contains columns of only E2, we can introduce another column E3 (which is common between both the tables). Then, we can apply projections L1 and L2 on E1 and E2 respectively, along with the added column L3. L3 enables us to do the join.

9. Union and Intersection are commutative. E_{1}\ \cup E_{2}\ =\ E_{2}\ \cup\ E_{1} E_{1}\ \cap E_{2}\ =\ E_{2}\ \cap\ E_{1} Explanation: Union and intersection are both distributive; we can enclose any tables in parentheses according to requirement and ease of access.

10. Union and Intersection are associative. (E_{1}\ \cup E_{2})\ \cup\ E_{3}=E_{1}\ \cup\ (E_{2}\ \cup\ E_{3}) (E_{1}\ \cap E_{2})\ \cap\ E_{3}=E_{1}\ \cap\ (E_{2}\ \cap\ E_{3}) Explanation: Union and intersection are both distributive; we can enclose any tables in parentheses according to requirement and ease of access.

11. Selection operation distributes over the union, intersection, and difference operations. \sigma_{P}(E_{1}\ -\ E_{2})=\sigma_{P}(E_{1})\ -\ \sigma_{P}(E_{2}) Explanation: In set difference, we know that only those tuples are shown which belong to table E1 and do not belong to table E2. So, applying a selection condition on the entire set difference is equivalent to applying the selection condition on the individual tables and then applying set difference. This will reduce the number of comparisons in the set difference step.

12. Projection operation distributes over the union operation. \pi_{L}(E_{1}\ \cup\ E_{2})=(\pi_{L}(E_{1}))\ \cup\ (\pi_{L}(E_{2})) Explanation: Applying individual projections before computing the union of E1 and E2 is more optimal than the left expression, i.e. applying projection after the union step.

## Minimality

A set of equivalence rules is said to be minimal if no rule can be derived from any combination of the others. A query is said to be optimal when it is minimal.

Examples: Assume the following tables:

> instructor(ID, name, dept_name, salary)teaches(ID, course_id, sec_id, semester, year)course(course_id, title, dept_name, credits)

instructor(ID, name, dept_name, salary)teaches(ID, course_id, sec_id, semester, year)course(course_id, title, dept_name, credits)

Query 1: Find the names of all instructors in the Music department, along with the titles of the courses that they teach \pi_{\text{name, title}} \left( \sigma_{\text{dept\_name} = \text{"Music"}} \left( \text{instructor} \bowtie \left( \text{teaches} \bowtie \pi_{\text{course\_id, title}} (\text{course}) \right) \right) \right)Here, dept_name is a field of only the instructor table. Hence, we can select out the Music instructors before joining the tables, hence reducing query time. Optimized Query: Using rule 7a, and Performing the selection as early as possible reduces the size of the relation to be joined. \pi_{\text{name, title}} \left( \left( \sigma_{\text{dept\_name} = "Music"} (\text{instructor}) \right) \bowtie \left( \text{teaches} \bowtie \pi_{\text{course\_id, title}} (\text{course}) \right) \right)Query 2: Find the names of all instructors in the CSE department who have taught a course in 2009, along with the titles of the courses that they taught \pi_{\text{name, title}} \left( \left( \sigma_{\text{dept\_name} = "Music"} (\text{instructor}) \right) \bowtie \left( \text{teaches} \bowtie \pi_{\text{course\_id, title}} (\text{course}) \right) \right)Optimized Query: We can perform an "early selection", hence the optimized query becomes: \pi_{\text{name, title}} \left( \left( \sigma_{\text{dept\_name} = "Music"} (\text{instructor}) \right) \bowtie \left( \text{teaches} \bowtie \pi_{\text{course\_id, title}} (\text{course}) \right) \right)

### Features :

- Cost Estimation: The optimizer picks the query plan with the lowest estimated cost, based on disk I/O or CPU usage.
- Plan Exploration: It explores different ways to execute the query (plan space), which can be complex for queries with many joins.
- Query Rewriting: The optimizer may transform the query into an equivalent but more efficient form (e.g., reordering joins or applying filters early).
- Use of Statistics: It uses table stats (like row count, value distribution, indexes) to estimate plan costs.
- [[index|Index]] Selection: Chooses the best indexes to speed up data access based on the query.
- Caching: Frequently run queries may be cached to avoid repeated execution and improve speed.