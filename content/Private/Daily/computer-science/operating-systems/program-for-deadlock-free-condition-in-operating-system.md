---
title: "Program for Deadlock Free Condition in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Program for Deadlock Free Condition in Operating System
Deadlock occurs when two or more processes are stuck, each holding a resource while waiting for another, creating a cyclic dependency. This halts system progress indefinitely. Deadlocks occur when all four conditions are present which are Mutual Exclusion, Hold and Wait, No Preemption and Circular Wait.

To ensure smooth execution in an operating system, deadlocks must be effectively managed. To achieve this, we will explore how to implement a deadlock-free condition in an operating system.

## Mathematical Condition for Deadlock Avoidance

In a system with R identical resources and P processes competing for them, the goal is to determine the minimum number of resources required to ensure a deadlock never occurs.

The condition for avoiding deadlock is:

> R ≥ P(N−1) + 1

R ≥ P(N−1) + 1

Where:

- R is the total available resources.
- P is the number of processes.
- N is the maximum resources a process may need.

This expression ensures [[deadlock-prevention|deadlock prevention]] by guaranteeing at least one process always completes execution.

- If every process holds N-1 resources, the total resources in use are P(N-1).
- With at least one extra resource (+1), at least one process can acquire the final needed resource, execute, and release resources.
- This prevents circular wait, ensuring resources are always freed for the next process.

Thus, deadlock is avoided as processes will never be indefinitely blocked.

Examples:

> Input : P = 3, N = 4Output : R >= 10Input : P = 7, N = 2Output : R >= 8

Input : P = 3, N = 4Output : R >= 10Input : P = 7, N = 2Output : R >= 8

## Implementing Deadlock-Free Conditions in an Operating System

[[deadlock-prevention|Deadlock prevention]] is an important technique used by operating systems to avoid the occurrence of deadlocks. Below are some program for achieving deadlock-free conditions in an Operating System:

### Implementation Using Mathematical Condition

For P processes with a need of N resources each, the formula for the minimum resources required to avoid deadlock is:

> R ≥ P × (N−1) + 1

R ≥ P × (N−1) + 1

Consider three processes: A, B, and C, each with a need of 4 resources.

- Maximum resources required: 3 processes × 4 resources = 12 resources.
- Minimum resources required: 3 × (4 - 1) + 1 = 10 resources.

Program Implementation:

```
// C++ implementation of above program.
# include <bits/stdc++.h>
using namespace std;

// function that calculates
// the minimum no. of resources
int Resources(int process, int need)
{
    int minResources = 0;

    // Condition so that deadlock
    // will not occur
    minResources = process * (need - 1) + 1;

    return minResources;
}

// Driver code
int main()
{
    int process = 3, need = 4;

    cout << "R >= " << Resources(process, need);
    return 0;
}

```

```
// Java implementation of above program

class GFG 
{ 

// function that calculates 
// the minimum no. of resources 
static int Resources(int process, int need)
{ 
    int minResources = 0; 

    // Condition so that deadlock 
    // will not occur 
    minResources = process * (need - 1) + 1; 

    return minResources; 
} 

// Driver Code 
public static void main(String args[]) 
{ 
    int process = 3, need = 4;
    
    System.out.print("R >= "); 
    System.out.print(Resources(process, need)); 
} 
} 

```

```
# Python 3 implementation of 
# above program
 
# function that calculates 
# the minimum no. of resources 
def Resources(process, need):

    minResources = 0

    # Condition so that deadlock 
    # will not occur 
    minResources = process * (need - 1) + 1

    return minResources 

# Driver Code
if __name__ == "__main__" : 

    process, need = 3, 4

    print("R >=", Resources(process, need))

# This Code is Contributed 
# by Naman_Garg

```

```
// C# implementation of above program
using System; 

class GFG 
{ 

// function that calculates 
// the minimum no. of resources 
static int Resources(int process, int need)
{ 
    int minResources = 0; 

    // Condition so that deadlock 
    // will not occur 
    minResources = process * (need - 1) + 1; 

    return minResources; 
} 

// Driver Code 
public static void Main() 
{ 
    int process = 3, need = 4;
    
    Console.Write("R >= "); 
    Console.Write(Resources(process, need)); 
} 
} 

// This code is contributed 
// by Sanjit_Prasad 

```

```
function Resources(process, need) {
  let minResources = 0;

  minResources = process * (need - 1) + 1;

  return minResources;
}

let process = 3, need = 4;

console.log(`R >= ${Resources(process, need)}`);

// This code is contributed by ishankhandelwals.

```

```
R >= 10
```

By allocating 3 resources to each process, we are left with 1 resource. This single resource can be given to any process, allowing it to proceed. Once that process finishes, the resource is released, and another process can use it. This ensures that deadlock will never occur.

### Implementation Using Semaphores

This program implements the Dining Philosophers Problem using semaphores to ensure deadlock-free execution. The solution avoids deadlocks by introducing a slight variation in the chopstick-picking order for one philosopher.

```
# include <pthread.h>
# include <semaphore.h>
# include <stdio.h>
# include <stdlib.h>
# include <unistd.h>

sem_t chopstick[5]; // Semaphore for each chopstick

void* philosopher(void* arg)
{
    int id = *(int*)arg;
    int left_chopstick = id; // Philosopher picks up left chopstick first
    int right_chopstick = (id + 1) % 5; // Philosopher picks up right chopstick next

    // Ensure at least one philosopher picks up chopsticks in reverse order
    if (id == 4) {
        // The last philosopher picks up the right chopstick first
        int temp = left_chopstick;
        left_chopstick = right_chopstick;
        right_chopstick = temp;
    }

    while (1) {
        // Wait until both chopsticks are available
        sem_wait(&chopstick[left_chopstick]);
        sem_wait(&chopstick[right_chopstick]);

        // Eat for some time
        printf("Philosopher %d is eating\n", id);
        sleep(2);

        // Release both chopsticks
        sem_post(&chopstick[left_chopstick]);
        sem_post(&chopstick[right_chopstick]);

        // Think for some time
        printf("Philosopher %d is thinking\n", id);
        sleep(2);
    }
}

int main()
{
    pthread_t philosophers[5];

    // Initialize semaphore for each chopstick
    for (int i = 0; i < 5; i++) {
        sem_init(&chopstick[i], 0, 1);
    }

    // Create thread for each philosopher
    for (int i = 0; i < 5; i++) {
        int* id = (int*)malloc(sizeof(int));
        *id = i;
        pthread_create(&philosophers[i], NULL, philosopher, id);
    }

    // Wait for all threads to complete
    for (int i = 0; i < 5; i++) {
        pthread_join(philosophers[i], NULL);
    }

    // Destroy semaphores
    for (int i = 0; i < 5; i++) {
        sem_destroy(&chopstick[i]);
    }

    return 0;
}

```

Output:

> Philosopher 1 is eatingPhilosopher 3 is eatingPhilosopher 1 is thinkingPhilosopher 0 is eatingPhilosopher 3 is thinkingPhilosopher 2 is eatingPhilosopher 0 is thinkingPhilosopher 4 is eatingPhilosopher 2 is thinkingPhilosopher 1 is eatingPhilosopher 4 is thinking...

Philosopher 1 is eatingPhilosopher 3 is eatingPhilosopher 1 is thinkingPhilosopher 0 is eatingPhilosopher 3 is thinkingPhilosopher 2 is eatingPhilosopher 0 is thinkingPhilosopher 4 is eatingPhilosopher 2 is thinkingPhilosopher 1 is eatingPhilosopher 4 is thinking...

Explanation:

- Each philosopher tries to pick up two chopsticks (left and right).
- Philosophers 0 to 3 pick up the left chopstick first, while philosopher 4 picks up the right chopstick first.
- This ensures that at least one philosopher can always proceed, avoiding deadlock.
- Code will run indefinitely.