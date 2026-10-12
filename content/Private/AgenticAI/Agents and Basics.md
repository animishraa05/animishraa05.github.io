---
id: Agents and Basics
aliases: []
tags: []
---

#### what are agents
Fully autonomous system that can work independently using various tools and operate on complex tasks.

THere is a difference between agents and workflows 

- *workflows* can be defined as systems where code paths are fixed, in other words, The dev decides which tools and functions to be used and the model just goes along with that the predefined path.
- In agents, the control is in the Hands of AI until the task completes.  It decides which tools and functions to use, plans and executes accordingly.



#### Basic workflow

The agents are supposed to have some augmentations like memory, tools and retrievals. Through these It connects the content, retrieves the search results


these are some basic patterns of agentic systems in production. 
We can implement these augmentations in many ways, one of which is MCP(which allows adding third party tools with simple client implementations).

Some agentic workflows - 
#### Prompt chaining
A method of decomposing the prompt into several llm calls so that the agent does not have a lot of stuff thrown to it and to make sure that the output is according to you, you can use various gates to ensure that the output is correct. Also the output of one task is input to other. 
![[Pasted image 20261008111007.png]]

the main focus is to **Improve accuracy by trading the latency**.
Ideal for situations where tasks can be
decomposed into smaller subtasks.


#### specialised routing
In this workflow, we take an input, and classify it into a specialised workflow
and then run the LLM call on that, using this we can optimise all of the tasks instead of the normal case where optimising one makes other weaker.

Routing works good in complex tasks that can be decomposed into specialised subtasks and classification is handled easily by llm or any specialised classfication algorithm.
![[Pasted image 20261008113424.png]]

routing works in these situations 
- categorizing different types of customer service queries into different queries, prompts and tools.
- routing small questions and queries to smaller models and saving tokens that way, optimising better models for complex tasks.

#### parallelization

In a system we usually go from input to different llm calls and those calls will go through one by one, but if those calls are entirely indepedent of each other, it would be better to do them parallely.

2 Patterns
- sectioning - dividing a task into independent subtasks. 
- Voting - When task is same then we make voting and aggregate all votes

                 PARALLELIZATION

        "Can independent reasoning happen
                 at the same time?"
                         │
              ┌──────────┴──────────┐
              ↓                     ↓
       Different subtasks       Same task
              ↓                     ↓
          SECTIONING              VOTING
              ↓                     ↓
       Focused analysis       Diverse attempts
              └──────────┬──────────┘
                         ↓
                    Aggregation
                         ↓
                    Final result


#### orchestrator worker 

There is a main node which is orchestrator which divides tasks between workers dynamically, and synthesises their results.![[Pasted image 20261008220519.png]]when to use - where you can't predict the subtasks needed.the subtasks arent predefined so its flexible and they are determined by the orchestrator dynamically on basis of input.

#### Evaluate-response model

here an LLM generate response and another provideer generates the feedback in a loop.
![[Pasted image 20261009170002.png]]

IT should be used where we understand that human evaluation can improve the performance of output and the LLM should be able to perform that evaluation.

Autonomous Agent

![[Pasted image 20261009173409.png]]
High Level flow of a coding agent
![[Pasted image 20261009183159.png]]
