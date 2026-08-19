---
title: "Enhanced ER Model"
topic: "dbms"
tags: [dbms, databases, gate-cse, dbms, databases, gate-cse, dbms, databases, gate-cse]
scraped_date: [[2026-03-29]]
---

# Enhanced ER Model
The Enhanced ER (EER) Model is an extension of the traditional ER model used to represent complex database requirements. As data complexity increases, the basic ER model becomes insufficient.

Features of the EER Model:

- Subtypes and Supertypes: Define general and specialised entities.
- Generalisation and Specialisation: Organise entities by shared or unique attributes.
- Inheritance: Subtypes inherit attributes and relationships from supertypes.
- Aggregation: Represents related entities as a single higher-level entity.

![relationship](images_relationship.webp)

The ER model is the abstract representation of a database structure that defines:

- Entities in a database.
- Attributes that they had.
- Relationships between them.

## Enhanced ER Concepts

In the Enhanced ER (EER) Model, several advanced concepts are used to represent complex data relationships, inheritance, and abstraction in databases.

### 1. Superclass and Subclass

Superclass is a higher-level entity set that has common attributes. Subclass is a lower-level entity set that inherits attributes and relationships from its superclass but also has its own specific attributes or relationships. This supports the concept of inheritance, where a subclass automatically possesses the features of the superclass.

Example: Science is a Super class which has subclasses like Physics, Chemistry, Biology.

### 2. Generalization and Specialization

Generalization and Specialization are common relationships added as enhancements to the classical ER model. A subclass (specialized class) inherits from a superclass (generalized class), similar to object-oriented concepts. This is best understood using IS-A relationships like “Technician IS-A Employee” or “Laptop IS-A Computer.” These are tools for organizing and simplifying data by abstracting or specifying entity relationships.

Example: Here we have three sets of employees: Secretary, Technician and Engineer. The employee is a super-class of the rest three sets of individual sub-class is a subset of Employee set.

![EER-Model-3](images_eer-model-3.webp)

- An entity belonging to a sub-class is related to some super-class entity. For instance emp, no 1001 is a secretary and his typing speed is 68. Emp no 1009 is an engineer (sub-class) and her trade is “Electrical”, so forth.
- Sub-class entity “inherits” all attributes of super-class; for example, employee 1001 will have attributes eno, name, salary and typing speed.

Enhanced ER Model of Above Example:

![EER-Model-1](images_eer-model-1.webp)

Constraints: There are two types of constraints on the “Sub-class” relationship.

1. Total or Partial Sub-classing:

- Total: Every entity in the superclass must be in at least one subclass (e.g., every employee is either salaried or hourly).
- Partial: Some entities may not belong to any subclass (e.g., not all employees are a secretary, engineer or technician).
- Total subclassing means complete coverage while, partial means incomplete coverage.

2. Overlapped or Disjoint Sub-Classing:

- Overlapped: An entity can belong to multiple subclasses.
- Disjoint: An entity can belong to only one subclass.
- In the given examples, both job-type and salary-based subclassing are disjoint, meaning no overlap.

### 3. Category or Union Type

A Category (or Union Type) is a subclass that is derived from two or more superclasses that may not be related. It allows the model to represent an entity that can be a member of more than one entity set.

Example: Set of Library Members is UNION of Faculty, Student and Staff. A union relationship indicates either type; for example, a library member is either Faculty or Staff or Student. Below are two examples that show how UNION can be depicted in ERD - Vehicle Owner is UNION of PERSON and Company andRTO Registered Vehicle is UNION of Car and Truck.

![EER-Model-2](images_eer-model-2.webp)

There might be some confusion in Sub-class and UNION. Consider an example in above figure Vehicle is super-class of CAR and Truck. In the example, Vehicle is a superclass of Car and Truck, which normally implies inheritance of attributes. However, in the RTO-registered case, Car and Truck form a union without inheriting from Vehicle, each has independent attributes.

### 4. Attribute and Relationship Inheritance

In the EER model, subclasses inherit all attributes and relationships of their superclasses. This supports reusability and data consistency, as common attributes don’t need to be redefined. An entity can be a sub-class of multiple entity types such entities are sub-class of multiple entities and have multiple super-classes. In multiple inheritances, attributes of sub-class are the union of attributes of all super-classes.

Example: If Employee has attributes like Name and ID, all subclasses like Manager or Engineer will automatically have these, in addition to their own unique attributes (like Department or Project).

> Read related article - [[generalization-specialization-and-aggregation-in-er-model|Generalization, Specialization and Aggregation in ER Model]]

Read related article - [[generalization-specialization-and-aggregation-in-er-model|Generalization, Specialization and Aggregation in ER Model]]