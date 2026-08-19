---
title: "Theory of computation - Wikipedia"
created: 2026-04-11
description:
tags:
  - "toc"
---
In [theoretical computer science](https://en.wikipedia.org/wiki/Theoretical_computer_science "Theoretical computer science") and [mathematics](https://en.wikipedia.org/wiki/Mathematics "Mathematics"), the **theory of computation** is the branch that deals with what problems can be solved on a model of computation using an [algorithm](https://en.wikipedia.org/wiki/Algorithm "Algorithm"), how [efficiently](https://en.wikipedia.org/wiki/Algorithmic_efficiency "Algorithmic efficiency") they can be solved and to what degree (e.g., [approximate solutions](https://en.wikipedia.org/wiki/Approximation_algorithms "Approximation algorithms") versus precise ones). The field is divided into three major branches: [automata theory](https://en.wikipedia.org/wiki/Automata_theory "Automata theory") and [formal languages](https://en.wikipedia.org/wiki/Formal_language "Formal language"), [computability theory](https://en.wikipedia.org/wiki/Computability_theory "Computability theory"), and [computational complexity theory](https://en.wikipedia.org/wiki/Computational_complexity_theory "Computational complexity theory"), which are linked by the question: *"What are the fundamental capabilities and limitations of computers?".*[^1]

In order to perform a rigorous study of computation, computer scientists work with a mathematical abstraction of computers called a [model of computation](https://en.wikipedia.org/wiki/Model_of_computation "Model of computation"). There are several models in use, but the most commonly examined is the [Turing machine](https://en.wikipedia.org/wiki/Turing_machine "Turing machine").[^2] Computer scientists study the Turing machine because it is simple to formulate, can be analyzed and used to prove results, and because it represents what many consider the most powerful possible "reasonable" model of computation (see [Church–Turing thesis](https://en.wikipedia.org/wiki/Church%E2%80%93Turing_thesis "Church–Turing thesis")).[^3] It might seem that the potentially infinite memory capacity is an unrealizable attribute, but any [decidable](https://en.wikipedia.org/wiki/Decidability_\(logic\) "Decidability (logic)") problem [^4] solved by a Turing machine will always require only a finite amount of memory. So in principle, any problem that can be solved (decided) by a Turing machine can be solved by a computer that has a finite amount of memory.

## History

The theory of computation can be considered the creation of models of all kinds in the field of computer science. Therefore, [mathematics and logic](https://en.wikipedia.org/wiki/Mathematical_logic "Mathematical logic") are used. In the last century, it separated from mathematics and became an independent academic discipline with its own conferences such as [FOCS](https://en.wikipedia.org/wiki/Symposium_on_Foundations_of_Computer_Science "Symposium on Foundations of Computer Science") in 1960 and [STOC](https://en.wikipedia.org/wiki/Symposium_on_Theory_of_Computing "Symposium on Theory of Computing") in 1969, and its own awards such as the [IMU Abacus Medal](https://en.wikipedia.org/wiki/IMU_Abacus_Medal "IMU Abacus Medal") (established in 1981 as the Rolf Nevanlinna Prize), the [Gödel Prize](https://en.wikipedia.org/wiki/G%C3%B6del_Prize "Gödel Prize"), established in 1993, and the [Knuth Prize](https://en.wikipedia.org/wiki/Knuth_Prize "Knuth Prize"), established in 1996.

Some pioneers of the theory of computation were [Ramon Llull](https://en.wikipedia.org/wiki/Ramon_Llull "Ramon Llull"), [Alonzo Church](https://en.wikipedia.org/wiki/Alonzo_Church "Alonzo Church"), [Kurt Gödel](https://en.wikipedia.org/wiki/Kurt_G%C3%B6del "Kurt Gödel"), [Alan Turing](https://en.wikipedia.org/wiki/Alan_Turing "Alan Turing"), [Stephen Kleene](https://en.wikipedia.org/wiki/Stephen_Kleene "Stephen Kleene"), [Rózsa Péter](https://en.wikipedia.org/wiki/R%C3%B3zsa_P%C3%A9ter "Rózsa Péter"), [John von Neumann](https://en.wikipedia.org/wiki/John_von_Neumann "John von Neumann") and [Claude Shannon](https://en.wikipedia.org/wiki/Claude_Shannon "Claude Shannon").

## Branches

### Automata theory

| Grammar | Languages | Automaton | Production rules (constraints) |
| --- | --- | --- | --- |
| Type-0 | [Recursively enumerable](https://en.wikipedia.org/wiki/Recursively_enumerable_language "Recursively enumerable language") | [Turing machine](https://en.wikipedia.org/wiki/Turing_machine "Turing machine") | ${\displaystyle \alpha \rightarrow \beta }$ (no restrictions) |
| Type-1 | [Context-sensitive](https://en.wikipedia.org/wiki/Context-sensitive_grammar "Context-sensitive grammar") | [Linear-bounded non-deterministic Turing machine](https://en.wikipedia.org/wiki/Linear_bounded_automaton "Linear bounded automaton") | ${\displaystyle \alpha A\beta \rightarrow \alpha \gamma \beta }$ |
| Type-2 | [Context-free](https://en.wikipedia.org/wiki/Context-free_grammar "Context-free grammar") | Non-deterministic [pushdown automaton](https://en.wikipedia.org/wiki/Pushdown_automaton "Pushdown automaton") | ${\displaystyle A\rightarrow \gamma }$ |
| Type-3 | [Regular](https://en.wikipedia.org/wiki/Regular_grammar "Regular grammar") | [Finite-state automaton](https://en.wikipedia.org/wiki/Finite-state_automaton "Finite-state automaton") | ${\displaystyle A\rightarrow a}$   and   ${\displaystyle A\rightarrow aB}$ |

Automata theory is the study of abstract machines (or more appropriately, abstract 'mathematical' machines or systems) and the computational problems that can be solved using these machines. These abstract machines are called automata. Automata comes from the Greek word (Αυτόματα) which means that something is doing something by itself. Automata theory is also closely related to [formal language](https://en.wikipedia.org/wiki/Formal_language "Formal language") theory,[^5] as the automata are often classified by the class of formal languages they are able to recognize. An automaton can be a finite representation of a formal language that may be an infinite set. Automata are used as theoretical models for computing machines, and are used for proofs about computability.

#### Formal language theory

![The Chomsky hierarchy](https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Chomsky-hierarchy.svg/250px-Chomsky-hierarchy.svg.png)

Set inclusions described by the Chomsky hierarchy

Formal language theory is a branch of mathematics concerned with describing languages as a set of operations over an [alphabet](https://en.wikipedia.org/wiki/Alphabet_\(formal_languages\) "Alphabet (formal languages)"). It is closely linked with automata theory, as automata are used to generate and recognize formal languages. There are several classes of formal languages, each allowing more complex language specification than the one before it, i.e. [Chomsky hierarchy](https://en.wikipedia.org/wiki/Chomsky_hierarchy "Chomsky hierarchy"),[^6] and each corresponding to a class of automata which recognizes it. Because automata are used as models for computation, formal languages are the preferred mode of specification for any problem that must be computed.

### Computability theory

Computability theory deals primarily with the question of the extent to which a problem is solvable on a computer. The statement that the [halting problem](https://en.wikipedia.org/wiki/Halting_problem "Halting problem") cannot be solved by a Turing machine [^7] is one of the most important results in computability theory, as it is an example of a concrete problem that is both easy to formulate and impossible to solve using a Turing machine. Much of computability theory builds on the halting problem result.

Another important step in computability theory was [Rice's theorem](https://en.wikipedia.org/wiki/Rice%27s_theorem "Rice's theorem"), which states that for all non-trivial properties of partial functions, it is [undecidable](https://en.wikipedia.org/wiki/Decidability_\(logic\) "Decidability (logic)") whether a Turing machine computes a partial function with that property.[^8]

Computability theory is closely related to the branch of [mathematical logic](https://en.wikipedia.org/wiki/Mathematical_logic "Mathematical logic") called [recursion theory](https://en.wikipedia.org/wiki/Recursion_theory "Recursion theory"), which removes the restriction of studying only models of computation which are reducible to the Turing model.[^9] Many mathematicians and computational theorists who study recursion theory will refer to it as computability theory.

### Computational complexity theory

![](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Complexity_subsets_pspace.svg/250px-Complexity_subsets_pspace.svg.png)

A representation of the relation among complexity classes

Computational complexity theory considers not only whether a problem can be solved at all on a computer, but also how efficiently the problem can be solved. Two major aspects are considered: [time complexity](https://en.wikipedia.org/wiki/Time_complexity "Time complexity") and [space complexity](https://en.wikipedia.org/wiki/Space_complexity "Space complexity"), which are respectively how many steps it takes to perform a computation, and how much memory is required to perform that computation.

In order to analyze how much time and space a given [algorithm](https://en.wikipedia.org/wiki/Algorithm "Algorithm") requires, computer scientists express the time or space required to solve the problem as a function of the size of the input problem. For example, finding a particular number in a long list of numbers becomes harder as the list of numbers grows larger. If we say there are *n* numbers in the list, then if the list is not sorted or indexed in any way we may have to look at every number in order to find the number we're seeking. We thus say that in order to solve this problem, the computer needs to perform a number of steps that grow linearly in the size of the problem.

To simplify this problem, computer scientists have adopted [big *O* notation](https://en.wikipedia.org/wiki/Big_O_notation "Big O notation"), which allows functions to be compared in a way that ensures that particular aspects of a machine's construction do not need to be considered, but rather only the [asymptotic behavior](https://en.wikipedia.org/wiki/Asymptotic_analysis "Asymptotic analysis") as problems become large. So in our previous example, we might say that the problem requires ${\displaystyle O(n)}$ steps to solve.

Perhaps the most important open problem in all of [computer science](https://en.wikipedia.org/wiki/Computer_science "Computer science") is the question of whether a certain broad class of problems denoted [NP](https://en.wikipedia.org/wiki/NP_\(complexity\) "NP (complexity)") can be solved efficiently. This is discussed further at [Complexity classes P and NP](https://en.wikipedia.org/wiki/P_%3D_NP_problem "P = NP problem"), and [P versus NP problem](https://en.wikipedia.org/wiki/P_versus_NP_problem "P versus NP problem") is one of the seven [Millennium Prize Problems](https://en.wikipedia.org/wiki/Millennium_Prize_Problems "Millennium Prize Problems") stated by the [Clay Mathematics Institute](https://en.wikipedia.org/wiki/Clay_Mathematics_Institute "Clay Mathematics Institute") in 2000. The Official Problem Description was given by [Turing Award](https://en.wikipedia.org/wiki/Turing_Award "Turing Award") winner [Stephen Cook](https://en.wikipedia.org/wiki/Stephen_Cook "Stephen Cook").

## Models of computation

Aside from a Turing machine, other equivalent (see Church–Turing thesis) models of computation are in use.

[Lambda calculus](https://en.wikipedia.org/wiki/Lambda_calculus "Lambda calculus")

A computation consists of an initial lambda expression (or two if you want to separate the function and its input) plus a finite sequence of lambda terms, each deduced from the preceding term by one application of [Beta reduction](https://en.wikipedia.org/wiki/Beta_reduction "Beta reduction").

[Combinatory logic](https://en.wikipedia.org/wiki/Combinatory_logic "Combinatory logic")

is a concept which has many similarities to ${\displaystyle \lambda }$ -calculus, but also important differences exist (e.g. fixed point combinator **Y** has normal form in combinatory logic but not in ${\displaystyle \lambda }$ -calculus). Combinatory logic was developed with great ambitions: understanding the nature of paradoxes, making foundations of mathematics more economic (conceptually), eliminating the notion of variables (thus clarifying their role in mathematics).

[μ-recursive functions](https://en.wikipedia.org/wiki/%CE%9C-recursive_function "Μ-recursive function")

a computation consists of a mu-recursive function, *i.e.* its defining sequence, any input value(s) and a sequence of recursive functions appearing in the defining sequence with inputs and outputs. Thus, if in the defining sequence of a recursive function ${\displaystyle f(x)}$ the functions ${\displaystyle g(x)}$ and ${\displaystyle h(x,y)}$ appear, then terms of the form 'g(5)=7' or 'h(3,2)=10' might appear. Each entry in this sequence needs to be an application of a basic function or follow from the entries above by using [composition](https://en.wikipedia.org/wiki/Function_composition_\(computer_science\) "Function composition (computer science)"), [primitive recursion](https://en.wikipedia.org/wiki/Primitive_recursion "Primitive recursion") or [μ recursion](https://en.wikipedia.org/wiki/%CE%9C-recursive_function "Μ-recursive function"). For instance if ${\displaystyle f(x)=h(x,g(x))}$, then for 'f(5)=3' to appear, terms like 'g(5)=6' and 'h(5,6)=3' must occur above. The computation terminates only if the final term gives the value of the recursive function applied to the inputs.

[Markov algorithm](https://en.wikipedia.org/wiki/Markov_algorithm "Markov algorithm")

a [string rewriting system](https://en.wikipedia.org/wiki/String_rewriting_system "String rewriting system") that uses [grammar](https://en.wikipedia.org/wiki/Grammar "Grammar") -like rules to operate on [strings](https://en.wikipedia.org/wiki/String_\(computer_science\) "String (computer science)") of symbols.

[Register machine](https://en.wikipedia.org/wiki/Register_machine "Register machine")

is a theoretically interesting idealization of a computer. There are several variants. In most of them, each register can hold a natural number (of unlimited size), and the instructions are simple (and few in number), e.g. only decrementation (combined with conditional jump) and incrementation exist (and halting). The lack of the infinite (or dynamically growing) external store (seen at Turing machines) can be understood by replacing its role with [Gödel numbering](https://en.wikipedia.org/wiki/G%C3%B6del_numbering "Gödel numbering") techniques: the fact that each register holds a natural number allows the possibility of representing a complicated thing (e.g. a sequence, or a matrix etc.) by an appropriately huge natural number — unambiguity of both representation and interpretation can be established by [number theoretical](https://en.wikipedia.org/wiki/Number_theory "Number theory") foundations of these techniques.

In addition to the general computational models, some simpler computational models are useful for special, restricted applications. [Regular expressions](https://en.wikipedia.org/wiki/Regular_expressions "Regular expressions"), for example, specify string patterns in many contexts, from office productivity software to [programming languages](https://en.wikipedia.org/wiki/Programming_language "Programming language"). Another formalism mathematically equivalent to regular expressions, [finite automata](https://en.wikipedia.org/wiki/Finite_automata "Finite automata") are used in circuit design and in some kinds of problem-solving. [Context-free grammars](https://en.wikipedia.org/wiki/Context-free_grammar "Context-free grammar") specify programming language syntax. Non-deterministic [pushdown automata](https://en.wikipedia.org/wiki/Pushdown_automaton "Pushdown automaton") are another formalism equivalent to context-free grammars. [Primitive recursive functions](https://en.wikipedia.org/wiki/Primitive_recursive_function "Primitive recursive function") are a defined subclass of the recursive functions.

Different models of computation have the ability to do different tasks. One way to measure the power of a computational model is to study the class of [formal languages](https://en.wikipedia.org/wiki/Formal_language "Formal language") that the model can generate; in such a way to the [Chomsky hierarchy](https://en.wikipedia.org/wiki/Chomsky_hierarchy "Chomsky hierarchy") of languages is obtained.

## References

[^1]: [Sipser (2013](#CITEREFSipser2013), p. 1):

> "central areas of the theory of computation: automata, computability, and complexity."

[^2]: [Hodges, Andrew](https://en.wikipedia.org/wiki/Andrew_Hodges "Andrew Hodges") (2012). *Alan Turing: The Enigma* (The Centenary ed.). [Princeton University Press](https://en.wikipedia.org/wiki/Princeton_University_Press "Princeton University Press"). [ISBN](https://en.wikipedia.org/wiki/ISBN_\(identifier\) "ISBN (identifier)") [978-0-691-15564-7](https://en.wikipedia.org/wiki/Special:BookSources/978-0-691-15564-7 "Special:BookSources/978-0-691-15564-7").

[^3]: [Rabin, Michael O.](https://en.wikipedia.org/wiki/Michael_O._Rabin "Michael O. Rabin") (June 2012). [*Turing, Church, Gödel, Computability, Complexity and Randomization: A Personal View*](http://videolectures.net/turing100_rabin_turing_church_goedel/).

[^4]: Donald Monk (1976). [*Mathematical Logic*](https://archive.org/details/mathematicallogi00jdon). Springer-Verlag. [ISBN](https://en.wikipedia.org/wiki/ISBN_\(identifier\) "ISBN (identifier)") [9780387901701](https://en.wikipedia.org/wiki/Special:BookSources/9780387901701 "Special:BookSources/9780387901701").

[^5]: [Hopcroft, John E.](https://en.wikipedia.org/wiki/John_Hopcroft "John Hopcroft") and [Jeffrey D. Ullman](https://en.wikipedia.org/wiki/Jeffrey_D._Ullman "Jeffrey D. Ullman") (2006). [*Introduction to Automata Theory, Languages, and Computation. 3rd ed*](https://en.wikipedia.org/wiki/Introduction_to_Automata_Theory,_Languages,_and_Computation "Introduction to Automata Theory, Languages, and Computation"). Reading, MA: Addison-Wesley. [ISBN](https://en.wikipedia.org/wiki/ISBN_\(identifier\) "ISBN (identifier)") [978-0-321-45536-9](https://en.wikipedia.org/wiki/Special:BookSources/978-0-321-45536-9 "Special:BookSources/978-0-321-45536-9").

[^6]: Chomsky, N. (1956). "Three models for the description of language". *IEEE Transactions on Information Theory*. **2** (3): 113–124. [Bibcode](https://en.wikipedia.org/wiki/Bibcode_\(identifier\) "Bibcode (identifier)"):[1956IRTIT...2..113C](https://ui.adsabs.harvard.edu/abs/1956IRTIT...2..113C). [doi](https://en.wikipedia.org/wiki/Doi_\(identifier\) "Doi (identifier)"):[10.1109/TIT.1956.1056813](https://doi.org/10.1109%2FTIT.1956.1056813). [S2CID](https://en.wikipedia.org/wiki/S2CID_\(identifier\) "S2CID (identifier)") [19519474](https://api.semanticscholar.org/CorpusID:19519474).

[^7]: [Alan Turing](https://en.wikipedia.org/wiki/Alan_Turing "Alan Turing") (1937). ["On computable numbers, with an application to the Entscheidungsproblem"](http://www.turingarchive.org/browse.php/B/12). *Proceedings of the London Mathematical Society*. **2** (42). IEEE: 230–265. [Bibcode](https://en.wikipedia.org/wiki/Bibcode_\(identifier\) "Bibcode (identifier)"):[1937PLMS...42..230T](https://ui.adsabs.harvard.edu/abs/1937PLMS...42..230T). [doi](https://en.wikipedia.org/wiki/Doi_\(identifier\) "Doi (identifier)"):[10.1112/plms/s2-42.1.230](https://doi.org/10.1112%2Fplms%2Fs2-42.1.230). [S2CID](https://en.wikipedia.org/wiki/S2CID_\(identifier\) "S2CID (identifier)") [73712](https://api.semanticscholar.org/CorpusID:73712). Retrieved 6 January 2015.

[^8]: Henry Gordon Rice (1953). ["Classes of Recursively Enumerable Sets and Their Decision Problems"](https://doi.org/10.2307%2F1990888). *Transactions of the American Mathematical Society*. **74** (2). American Mathematical Society: 358–366. [doi](https://en.wikipedia.org/wiki/Doi_\(identifier\) "Doi (identifier)"):[10.2307/1990888](https://doi.org/10.2307%2F1990888). [JSTOR](https://en.wikipedia.org/wiki/JSTOR_\(identifier\) "JSTOR (identifier)") [1990888](https://www.jstor.org/stable/1990888).

[^9]: [Martin Davis](https://en.wikipedia.org/wiki/Martin_Davis_\(mathematician\) "Martin Davis (mathematician)") (2004). *The undecidable: Basic papers on undecidable propositions, unsolvable problems and computable functions (Dover Ed)*. Dover Publications. [ISBN](https://en.wikipedia.org/wiki/ISBN_\(identifier\) "ISBN (identifier)") [978-0486432281](https://en.wikipedia.org/wiki/Special:BookSources/978-0486432281 "Special:BookSources/978-0486432281").