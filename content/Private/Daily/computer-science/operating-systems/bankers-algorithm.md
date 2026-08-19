---
title: "Banker's Algorithm"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Banker's Algorithm
Banker's Algorithm is a resource allocation and deadlock avoidance algorithm used in operating systems. It ensures that there exists at least one sequence of processes such that each process can obtain the needed resources, complete its execution,

- It helps prevent situations where programs get stuck and can not finish their tasks.
- It keeps track of resources each program needs and what's available

## Components of the Banker's Algorithm

The following Data structures are used to implement the Banker’s Algorithm:

![Banker-algo](images_banker-algo.webp)

Let 'n' be the number of processes in the system and 'm' be the number of resource types.

1. Available

- It is a 1-D array of size 'm' indicating the number of available resources of each type.
- Available[ j ] = k means there are 'k' instances of resource type Rj

2. Max

- It is a 2-d array of size 'n*m' that defines the maximum demand of each process in a system.
- Max[ i, j ] = k means process Pi may request at most 'k' instances of resource type Rj.

3. Allocation

- It is a 2-d array of size 'n*m' that defines the number of resources of each type currently allocated to each process.
- Allocation[ i, j ] = k means process Pi is currently allocated 'k' instances of resource type Rj

4. Need

- It is a 2-d array of size 'n*m' that indicates the remaining resource need of each process.
- Need [ i, j ] = k means process Pi currently needs 'k' instances of resource type Rj
- Need [ i, j ] = Max [ i, j ] – Allocation [ i, j ]

Allocation specifies the resources currently allocated to process Pi and Need specifies the additional resources that process Pi may still request to complete its task.

### Key Concepts in Banker's Algorithm

- Safe State: There exists at least one sequence of processes such that each process can obtain the needed resources, complete its execution, release its resources, and thus allow other processes to eventually complete without entering a deadlock.
- Unsafe State: Even though the system can still allocate resources to some processes, there is no guarantee that all processes can finish without potentially causing a deadlock.

### Example of Unsafe State

Consider a system with three processes (P1, P2, P3) and 6 instances of a resource. Let's say:

`P1`

`P2`

`P3`

1. The available instances of the resource are: 12. The current allocation of resources to processes is:

- P1: 2
- P2: 3
- P3: 1

`P1`

`P2`

`P3`

3. The maximum demand (maximum resources each process may eventually request) is:

- P1: 4
- P2: 5
- P3: 3

`P1`

`P2`

`P3`

In this situation:

> Need = Maximum Demand - Allocation

Need = Maximum Demand - Allocation

| Process | Maximum Demand | Allocation | Need |
| --- | --- | --- | --- |
| P1 | 4 | 2 | 2 |
| P2 | 5 | 3 | 2 |
| P3 | 3 | 1 | 2 |

Process

Maximum Demand

Allocation

Need

- P1 may need 2 more resources to complete.
- P2 may need 2 more resource to complete.
- P3 may need 2 more resources to complete.

`P1`

`P2`

`P3`

However, there is only 1 resource available. Even though none of the processes are currently deadlocked, the system is in an unsafe state because there is no sequence of resource allocation that guarantees all processes can complete.

Banker's algorithm consists of a Safety algorithm and a Resource request algorithm.

# Types of Banker’s Algorithm

The Banker’s Algorithm is made up of two parts:

1. Safety Algorithm
2. Resource Request Algorithm

![Type-of-banker-algo](images_type-of-banker-algo.webp)

## 1. Safety Algorithm

The safety algorithm checks whether the system is in a safe state-meaning all processes can complete without causing deadlock.

Steps:

1. Initialize:

- Work = Available (resources currently available)
- Finish[i] = false for all processes (none have finished yet)

2. Look for a process Pi such that:

- Finish[i] = false
- Need[i] ≤ Work (resources required can be satisfied)

3. If such a process is found:

- Pretend to allocate resources to it: Work = Work + Allocation[i]
- Mark the process finished: Finish[i] = true
- Repeat step 2 for remaining processes

4. If all processes are marked finished (Finish[i] = true for all), the system is safe.

> Essentially, the algorithm simulates process completion to verify that all processes can finish safely.

Essentially, the algorithm simulates process completion to verify that all processes can finish safely.

## 2. Resource Request Algorithm

This algorithm decides if a process’s resource request can be granted safely.

Steps:

1. Check if the request exceeds the process’s maximum need: If Request[i] ≤ Need[i], continue; otherwise, error.

2. Check if resources are available: If Request[i] ≤ Available, continue; otherwise, the process waits.

3. Temporarily allocate the resources:

- Available = Available - Request[i]
- Allocation[i] = Allocation[i] + Request[i]
- Need[i] = Need[i] - Request[i]

4. Run the Safety Algorithm:

- If the new state is safe, grant the request.
- If unsafe, roll back and make the process wait.

> In short, the resource-request algorithm ensures resources are only granted if the system remains safe, preventing deadlock.

In short, the resource-request algorithm ensures resources are only granted if the system remains safe, preventing deadlock.

Example: Considering a system with five processes P0 through P4 and three resources of type A, B, C. Resource type A has 10 instances, B has 5 instances and type C has 7 instances. Suppose at time t0 following snapshot of the system has been taken:

![table1](images_table1.webp)

### Need Matrix

Need [i, j] = Max [i, j] – Allocation [i, j]So, the content of Need Matrix is:

![table2](images_table2.webp)

### Safe State and Safe Sequence Analysis

Applying the Safety algorithm on the given system,

### Impact of P1’s Resource Request

![table3](images_table3.webp)

We must determine whether this new system state is safe. To do so, we again execute Safety algorithm on the above data structures.

Hence the new system state is safe, so we can immediately grant the request for process P1 .

## Implementation of Banker's Algorithm

```
# include <iostream>
# include <vector>
using namespace std;

int main() {
    // P0, P1, P2, P3, P4 are the names of Process

    int n = 5; // Indicates the Number of processes
    int r = 3; // Indicates the Number of resources
    vector<vector<int>> alloc = {{0, 0, 1}, // P0 // This is Allocation Matrix
                                 {3, 0, 0}, // P1
                                 {1, 0, 1}, // P2
                                 {2, 3, 2}, // P3
                                 {0, 0, 3}}; // P4

    vector<vector<int>> max = {{7, 6, 3}, // P0 // MAX Matrix
                                {3, 2, 2}, // P1
                                {8, 0, 2}, // P2
                                {2, 1, 2}, // P3
                                {5, 2, 3}}; // P4

    vector<int> avail = {2, 3, 2}; // These are Available Resources

    vector<int> f(n, 0);
    vector<int> ans(n);
    int ind = 0;
    vector<vector<int>> need(n, vector<int>(r));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < r; j++) {
            need[i][j] = max[i][j] - alloc[i][j];
        }
    }

    int y = 0;
    for (int k = 0; k < n; k++) {
        for (int i = 0; i < n; i++) {
            if (f[i] == 0) {
                int flag = 0;
                for (int j = 0; j < r; j++) {
                    if (need[i][j] > avail[j]) {
                        flag = 1;
                        break;
                    }
                }

                if (flag == 0) {
                    ans[ind++] = i;
                    for (y = 0; y < r; y++) {
                        avail[y] += alloc[i][y];
                    }
                    f[i] = 1;
                }
            }
        }
    }

    cout << "The SAFE Sequence is as follows\n";
    for (int i = 0; i < n - 1; i++) {
        cout << " P" << ans[i] << " ->";
    }
    cout << " P" << ans[n - 1] << endl;

    return 0;
}

```

```
//C program for Banker's Algorithm 
# include <stdio.h> 
int main() 
{ 
	// P0, P1, P2, P3, P4 are the names of Process

	int n, r, i, j, k; 
	n = 5; // Indicates the Number of processes 
	r = 3; //Indicates the Number of resources 
	int alloc[5][3] = { { 0, 0, 1 }, // P0 // This is Allocation Matrix 
						{ 3, 0, 0 }, // P1 
						{ 1, 0, 1 }, // P2 
						{ 2, 3, 2 }, // P3 
						{ 0, 0, 3 } }; // P4 

	int max[5][3] = { { 7, 6, 3 }, // P0 // MAX Matrix 
					{ 3, 2, 2 }, // P1 
					{ 8, 0, 2 }, // P2 
					{ 2, 1, 2 }, // P3 
					{ 5, 2, 3 } }; // P4 

	int avail[3] = { 2, 3, 2 }; // These are Available Resources 

	int f[n], ans[n], ind = 0; 
	for (k = 0; k < n; k++) { 
		f[k] = 0; 
	} 
	int need[n][r]; 
	for (i = 0; i < n; i++) { 
		for (j = 0; j < r; j++) 
			need[i][j] = max[i][j] - alloc[i][j]; 
	} 
	int y = 0; 
	for (k = 0; k < 5; k++) { 
		for (i = 0; i < n; i++) { 
			if (f[i] == 0) { 

				int flag = 0; 
				for (j = 0; j < r; j++) { 
					if (need[i][j] > avail[j]){ 
						flag = 1; 
						break; 
					} 
				} 

				if (flag == 0) { 
					ans[ind++] = i; 
					for (y = 0; y < r; y++) 
						avail[y] += alloc[i][y]; 
					f[i] = 1; 
				} 
			} 
		} 
	} 

	printf("Th SAFE Sequence is as follows\n"); 
	for (i = 0; i < n - 1; i++) 
		printf(" P%d ->", ans[i]); 
	printf(" P%d", ans[n - 1]); 

	return (0); 

} 

```

```
public class BankerAlgorithm {
    public static void main(String[] args) {
        // P0, P1, P2, P3, P4 are the names of Process

        int n = 5; // Indicates the Number of processes
        int r = 3; // Indicates the Number of resources
        int[][] alloc = {{0, 0, 1}, // P0 // This is Allocation Matrix
                          {3, 0, 0}, // P1
                          {1, 0, 1}, // P2
                          {2, 3, 2}, // P3
                          {0, 0, 3}}; // P4

        int[][] max = {{7, 6, 3}, // P0 // MAX Matrix
                        {3, 2, 2}, // P1
                        {8, 0, 2}, // P2
                        {2, 1, 2}, // P3
                        {5, 2, 3}}; // P4

        int[] avail = {2, 3, 2}; // These are Available Resources

        int[] f = new int[n];
        int[] ans = new int[n];
        int ind = 0;
        int[][] need = new int[n][r];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < r; j++) {
                need[i][j] = max[i][j] - alloc[i][j];
            }
        }

        int y = 0;
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                if (f[i] == 0) {
                    int flag = 0;
                    for (int j = 0; j < r; j++) {
                        if (need[i][j] > avail[j]) {
                            flag = 1;
                            break;
                        }
                    }

                    if (flag == 0) {
                        ans[ind++] = i;
                        for (y = 0; y < r; y++) {
                            avail[y] += alloc[i][y];
                        }
                        f[i] = 1;
                    }
                }
            }
        }

        System.out.print("The SAFE Sequence is as follows\n");
        for (int i = 0; i < n - 1; i++) {
            System.out.print(" P" + ans[i] + " ->");
        }
        System.out.println(" P" + ans[n - 1]);
    }
}

```

```
def banker_algorithm():
    # P0, P1, P2, P3, P4 are the names of Process

    n = 5  # Indicates the Number of processes
    r = 3  # Indicates the Number of resources
    alloc = [[0, 0, 1],  # P0 // This is Allocation Matrix
              [3, 0, 0],  # P1
              [1, 0, 1],  # P2
              [2, 3, 2],  # P3
              [0, 0, 3]]  # P4

    max = [[7, 6, 3],  # P0 // MAX Matrix
            [3, 2, 2],  # P1
            [8, 0, 2],  # P2
            [2, 1, 2],  # P3
            [5, 2, 3]]  # P4

    avail = [2, 3, 2]  # These are Available Resources

    f = [0] * n
    ans = [0] * n
    ind = 0
    need = [[0] * r for _ in range(n)]

    for i in range(n):
        for j in range(r):
            need[i][j] = max[i][j] - alloc[i][j]

    y = 0
    for k in range(n):
        for i in range(n):
            if f[i] == 0:
                flag = 0
                for j in range(r):
                    if need[i][j] > avail[j]:
                        flag = 1
                        break

                if flag == 0:
                    ans[ind] = i
                    ind += 1
                    for y in range(r):
                        avail[y] += alloc[i][y]
                    f[i] = 1

    print("The SAFE Sequence is as follows")
    for i in range(n - 1):
        print(f' P{ans[i]} ->', end='')
    print(f' P{ans[n - 1]}')

banker_algorithm()

```

Hence, the SAFE Sequence is as follows: P1 -> P3 -> P4 -> P0 -> P2.