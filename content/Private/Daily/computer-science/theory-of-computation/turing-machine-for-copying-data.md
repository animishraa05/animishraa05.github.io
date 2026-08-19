---
title: "Turing machine for copying data"
topic: "theory-of-computation"
scraped_date: [[2026-03-29]]
---

# Turing machine for copying data
Prerequisite - Turing Machine Problem - Draw a Turing machine which copy data. Example -

![](images_111-4.png)

Steps:

- Step-1. First convert all 0's, 1's into 0's, 1's and go right then B into C and go left
- Step-2. Then convert all 0's, 1's into 0's, 1's and go left then
- Step-3. If 1 convert it into X and go right convert all 0's, 1's into 0's, 1's and go right then convert C into C and go right then convert all 0's, 1's into 0's, 1's and go right then convert B into 1 and go left then convert all 0's, 1's into 0's, 1's and go left then convert C into C and go left then convert all 0's, 1's into 0's, 1's and go left then convert all X into X and go right and then repeat all the process from step-2 till end
- Step-4. If 0 then convert it into Y and go right then convert all 0's, 1's into 0's, 1's and go right then convert C into C and go right then convert all 0's, 1's into 0's, 1's and go right then convert B into 0 and go left then convert all 0's, 1's into 0's, 1's and go left then convert C into C and go left then convert all 0's, 1's into 0's, 1's and go left then convert all Y into Y and go right and then repeat all the process from step-2 till end
- Step-5. Otherwise if C found convert it into C and go left then convert all X into 1 and Y into 0 and go left then convert B into B and go right and stop the machine.

![](images_a-660x372.png)

Here, q0 shows the initial state and q1, q2, ....., q9, q11are the transition states and q12shows the final state. And 0, 1 is the data inside a machine and X, Y, C are the variables used for copy data and R, L shows right and left.