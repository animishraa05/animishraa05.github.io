---
title: "Fibonacci Number"
link: "https://leetcode.com/problems/fibonacci-number/"
topic: "Math"
type: problem
created: 2026-07-19
---

## Approach
The Fibonacci sequence is defined by the recurrence relation `F(n) = F(n-1) + F(n-2)`, with base cases `F(0) = 0` and `F(1) = 1`. 

The brute force approach translates this recurrence directly into a recursive function. However, this recalculates the same subproblems repeatedly, leading to exponential time complexity.
The optimal approaches involve Dynamic Programming. We can use either:
1. **Memoization (Top-Down):** Cache the results of the recursive calls.
2. **Tabulation (Bottom-Up):** Iteratively calculate from bottom to top using an array.
3. **Space Optimized Bottom-Up:** Realize that we only ever need the last two values to calculate the next, allowing us to drop the array entirely and use just two variables, giving $O(1)$ space.

## Code
### Brute Force (Simple Recursion)
```cpp
// Pseudocode:
// If n == 0 return 0
// If n == 1 return 1
// Return fib(n-1) + fib(n-2)

class Solution {
public:
    int fib_brute(int n) {
        if (n <= 1) {
            return n;
        }
        return fib_brute(n - 1) + fib_brute(n - 2);
    }
};
```

### Optimal Approach (Space-Optimized Iterative)
```cpp
// Pseudocode:
// If n <= 1, return n.
// Initialize prev2 = 0, prev1 = 1
// For i from 2 to n:
//   curr = prev1 + prev2
//   prev2 = prev1
//   prev1 = curr
// Return prev1

class Solution {
public:
    int fib(int n) {
        if (n <= 1) {
            return n;
        }
        
        int prev2 = 0, prev1 = 1;
        
        for (int i = 2; i <= n; i++) {
            int curr = prev1 + prev2;
            prev2 = prev1;
            prev1 = curr;
        }
        
        return prev1;
    }
};
```

## Complexity
- **Time Complexity:** 
  - Brute Force: $O(2^N)$ due to the binary recursion tree where overlapping subproblems are redundantly calculated.
  - Optimal: $O(N)$ because we iterate from 2 to $N$ exactly once.
- **Space Complexity:** 
  - Brute Force: $O(N)$ due to the maximum depth of the recursion stack.
  - Optimal: $O(1)$ because we only use three variables (`prev2`, `prev1`, `curr`). (If we used a DP array, space would be $O(N)$).

## Edge Cases
1. `n = 0` or `n = 1`: Explicitly handled by the base condition `if (n <= 1) return n;`. The loop is bypassed correctly.

## Notes
- **Thought Process & Recognition:** Fibonacci is the "Hello World" of Dynamic Programming. The progression of solutions should always be: Recursion -> Note overlapping subproblems -> Memoization -> Tabulation -> Space Optimization.
- **Mental Model:** Picture the computation as climbing a ladder. You don't need to keep a record of all the rungs you've stepped on. To figure out where your next step goes, you only need to know where your two feet are currently placed (`prev1` and `prev2`).
