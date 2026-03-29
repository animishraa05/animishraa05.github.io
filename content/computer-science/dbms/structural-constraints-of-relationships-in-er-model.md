---
title: "Structural Constraints of Relationships in ER Model"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Structural Constraints of Relationships in ER Model
Structural constraints, within the context of Entity-Relationship (ER) modeling, specify and determine how the entities take part in the relationships and this gives an outline of how the interactions between the entities can be designed in a database. Two primary types of constraints are cardinality (specifying the number of instances in a relationship) and participation (whether all or some entity instances are involved in the relationship). Cardinality is defined as one-to-one, one-to-many, or many-to-many, while participation can be total or partial.

This forms the constraints that need to be used in defining an accurate and efficient database schema since the [[Basics|introduction]] of the interaction rules of entities ensures that the correctness of the data model reflects in the real situation. The knowledge of these constraints is very essential for the design of strong and functional databases.

To understand Structural Constraints, we must take a look at Cardinality Ratios and Participation Constraints. Cardinality Ratios of relationships : The entities are denoted by rectangle and relationships by diamond. There are numbers (represented by M and N) written above the lines which connect relationships and entities. These are called cardinality ratios. These represent the maximum number of entities that can be associated with each other through relationship, R.

![Relation in ER-Model](images/relation-in-er-model.png)

## Types of Cardinality in ER-Model

There can be 4 types of cardinality -

![Cardinality in ER-Model](images/cardinality-in-er-model.png)

1. One-to-one (1:1) - When one entity in each entity set takes part at most once in the relationship, the cardinality is one-to-one.
2. One-to-many (1: N) - If entities in the first entity set take part in the relationship set at most once and entities in the second entity set take part many times (at least twice), the cardinality is said to be one-to-many.
3. Many-to-one (N:1) - If entities in the first entity set take part in the relationship set many times (at least twice), while entities in the second entity set take part at most once, the cardinality is said to be many-to-one.
4. Many-to-many (N: N) - The cardinality is said to be many to many if entities in both the entity sets take part many times (at least twice) in the relationship set.

## Participation Constraints in ER-Model

Participation Constraints tell us that the participation in a relationship can either be total or partial.

### Total Participation

When each entity in an entity set participates in a relation, it is called Total Participation. In ER modeling, total participation exists when the instances of the entity must necessarily participate in at least one relationship instance. For example, in a university system, where every student must be enrolled in at least one course, total participation exists in the relationship between "Student" and "Course". Similarly, if each professor teaches at least one course, then the relationship between "Professor" and "Course" also displays total participation. The notion here is that no entity can exist without being involved in the relationship.

### Partial Participation

When some of the entities in the given entity set do not participate in a relation, it is called Partial Participation. Contrary to full participation, partial participation allows some components of a particular entity to be present without being part of any relation. Some entities may or may not be part of the relationship, and, in case of a single line in the ER diagram, that is indicated. For instance, in the university system, if some professors do not teach any courses, then their participation would be partial in the "Teaches" relationship.

![Participation constraints in ER-Model](images/participation-constraints-in-er-model.png)

### Structural Constraints

Structural Constraints are also called Structural properties of a database management system (DBMS). Cardinality Ratios and Participation Constraints taken together are called Structural Constraints. The name constraints refer to the fact that such limitations must be imposed on the data, for the DBMS system to be consistent with the requirements. The Structural constraints are represented by Min-Max notation. This is a pair of numbers(m, n) that appear on the connecting line between the entities and their relationships. The minimum number of times an entity can appear in a relation is represented by m whereas, the maximum time it is available is denoted by n. If m is 0 it signifies that the entity is participating in the relation partially, whereas, if m is either greater than or equal to 1, it denotes total participation of the entity. Note - Number of times an entity participates in a relationship is same as the number appearance of the entity in the tuples.

![Structural Constraints](images/structural-constraints.png)

Similarly, a book of the library system either borrowed or not by a member, a partial participation in the relationship of "Book" with "Member". Partial participation captures even more fluid scenarios wherein not all of the entities are involved under an obligation to participate in a relationship.