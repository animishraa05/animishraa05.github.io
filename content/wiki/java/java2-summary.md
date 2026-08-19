---
source: Java OOP Concepts — GeeksforGeeks
source_path: sources/Java2.md
content_hash: 0ba2bdd28d27abdb6222ebc536ce176c
ingested: 2026-05-13
concepts_count: 22
sources_count: 1
tags: [dev, java]
---

## What This Source Is

A GeeksforGeeks Java OOP concepts article covering the four OOP pillars (encapsulation, inheritance, polymorphism, abstraction) along with classes, objects, association types (aggregation, composition), inheritance variants, and the advantages/disadvantages of OOP compared to procedural programming.

## Concepts Extracted

**Created (15):**

- [[java-class|Java Class]] — class as blueprint/prototype for creating objects
- [[java-object|Java Object]] — object with state, behavior, and identity
- [[java-association|Java Association]] — relationship between independent class objects
- [[java-aggregation|Java Aggregation]] — weak "has-a" relationship with independent lifecycles
- [[java-composition|Java Composition]] — strong "has-a" relationship with dependent lifecycles
- [[java-inheritance-types|Inheritance Types]] — five types of inheritance in Java
- [[java-single-inheritance|Single Inheritance]] — one subclass inherits from one superclass
- [[java-multilevel-inheritance|Multilevel Inheritance]] — chain of derived classes
- [[java-hierarchical-inheritance|Hierarchical Inheritance]] — multiple subclasses from one superclass
- [[java-multiple-inheritance|Multiple Inheritance]] — through interfaces only
- [[java-hybrid-inheritance|Hybrid Inheritance]] — combination through interfaces
- [[java-compile-time-polymorphism|Compile-Time Polymorphism]] — method overloading resolution at compile time
- [[java-runtime-polymorphism|Runtime Polymorphism]] — method overriding resolution at runtime
- [[java-oop-advantages|OOP Advantages]] — code reusability, structure, DRY, faster development
- [[java-oop-disadvantages|OOP Disadvantages]] — learning curve, overhead, debugging, memory

**Updated (4):**

- [[java-abstraction|Java Abstraction]] — added ATM/coffee machine real-world metaphor, abstract class vs interface distinction (100% vs partial abstraction)
- [[java-encapsulation|Java Encapsulation]] — added protective shield metaphor, expanded data security description
- [[java-inheritance|Java Inheritance]] — added types of inheritance, Dog/Cat/Cow Animal hierarchy example
- [[java-polymorphism|Java Polymorphism]] — added speak() example (Bark/Meow/Moo), expanded compile-time vs runtime distinction

**Updated in this ingest (9):**

- [[java-single-inheritance|Single Inheritance]] — added Visual Explanation, Semantic Network, Key Properties, Edge Cases
- [[java-multilevel-inheritance|Multilevel Inheritance]] — added Visual Explanation, Semantic Network, Key Properties
- [[java-hierarchical-inheritance|Hierarchical Inheritance]] — added Visual Explanation, Semantic Network, Key Properties
- [[java-multiple-inheritance|Multiple Inheritance]] — added Visual Explanation, Semantic Network, Key Properties
- [[java-hybrid-inheritance|Hybrid Inheritance]] — added Visual Explanation, Semantic Network, Key Properties
- [[java-interfaces|Java Interfaces]] — added interfaces provide 100% abstraction detail
- [[java-methods|Java Methods]] — added method definition as collection of statements for a task
- [[java-oop-pillars|The Four OOP Pillars]] — added Sources section linking to this source
- [[java-aggregation-vs-composition|Aggregation vs Composition]] — added Sources section
- [[java-overloading-vs-overriding|Overloading vs Overriding]] — added Sources section
- [[java-abstract-class-vs-interface|Abstract Class vs Interface]] — added Sources section

## Syntheses Created (3)

- [[java-aggregation-vs-composition|Aggregation vs Composition]] — weak vs strong association with lifecycle comparison
- [[java-overloading-vs-overriding|Overloading vs Overriding]] — compile-time vs runtime polymorphism resolution
- [[java-abstract-class-vs-interface|Abstract Class vs Interface]] — partial vs full abstraction

## Key Takeaways

- OOP improves code reusability, maintainability, and models real-world entities
- Java supports five inheritance types but restricts multiple and hybrid to interface-only to avoid the diamond problem
- Abstraction can be partial (abstract class: has state, constructors) or full (interface: pure contract, pre-Java 8)
- Association has three levels: basic (independent), aggregation (weak has-a), and composition (strong has-a)
- Polymorphism splits into compile-time (overloading, faster, resolved by compiler) and runtime (overriding, flexible, resolved by JVM)
- Association (Aggregation/Composition) is a new OOP dimension beyond the traditional four pillars, covering inter-object relationships
- Encapsulation wraps fields + methods into a protective shield, controlling access through getters/setters

## Open Questions

- How does the Java 8+ evolution of default/static methods in interfaces affect the abstract class vs interface design decision?
- When should composition be preferred over inheritance in real-world enterprise applications?
