---
title: "Climbing Stairs"
link: "https://leetcode.com/problems/climbing-stairs/"
topic: "Math"
type: problem
created: 2026-07-19
---

## Approach
The problem asks for the number of distinct ways to climb to the top of an $n$-step staircase, taking either 1 or 2 steps at a time.

**Why Dynamic Programming / Fibonacci?**
To reach step $n$, you must have either:
1. Come from step $n-1$ (by taking a 1-step).
2. Come from step $n-2$ (by taking a 2-step).

Therefore, the total number of ways to reach step $n$ is simply the sum of the number of ways to reach step $n-1$ and the number of ways to reach step $n-2$. This is the exact recurrence relation of the Fibonacci sequence: $F(n) = F(n-1) + F(n-2)$. 

We can solve this using bottom-up dynamic programming, optimizing the space since we only ever need to remember the last two states.

**Specific questions to practice:**
- Min Cost Climbing Stairs
- Fibonacci Number
- N-th Tribonacci Number

## Code

### Brute-Force Approach (Top-Down Recursion)
*Pseudocode logic:*
1. Define recursive function `climb(n)`.
2. Base cases: If `n == 1`, return 1. If `n == 2`, return 2.
3. Return `climb(n-1) + climb(n-2)`.
*Complexity:* $O(2^n)$ time, because it computes the same subproblems repeatedly (overlapping subproblems). Space is $O(n)$ for the recursion stack.

### Optimal Approach (Bottom-Up DP / Space Optimized)
Instead of a full DP array `dp` of size `n + 1`, we just track `oneStepBefore` and `twoStepsBefore`.

*Pseudocode logic:*
1. If `n <= 2`, return `n`.
2. Initialize `twoStepsBefore = 1` (ways to reach step 1).
3. Initialize `oneStepBefore = 2` (ways to reach step 2).
4. Loop `i` from 3 to `n`:
   - `currentWays = oneStepBefore + twoStepsBefore`
   - Update `twoStepsBefore = oneStepBefore`
   - Update `oneStepBefore = currentWays`
5. Return `oneStepBefore`.

```cpp
class Solution {
public:
    int climbStairs(int n) {
        // Base cases
        if (n == 1) {
            return 1;
        }
        if (n == 2) {
            return 2;
        }
            
        // Variables to store the previous two results
        int twoStepsBefore = 1; // ways to reach step 1
        int oneStepBefore = 2;  // ways to reach step 2
        
        // Calculate from step 3 up to n
        for (int i = 3; i <= n; ++i) {
            int current = oneStepBefore + twoStepsBefore;
            
            // Shift variables for the next iteration
            twoStepsBefore = oneStepBefore;
            oneStepBefore = current;
        }
            
        return oneStepBefore;
    }
};
```

## Complexity
- **Time Complexity:** $O(n)$
  - We loop from 3 up to $n$, performing constant time operations in each iteration.
- **Space Complexity:** $O(1)$
  - We are only storing two integer variables, regardless of the size of $n$.

## Edge Cases
- **$n = 1$:** Handled perfectly by the base case check.
- **$n = 2$:** Handled perfectly by the base case check.
- **Large $n$:** No issues with standard 32-bit signed integers in C++ up to $n=45$, which is exactly the bounds given by Leetcode constraints.

## Notes
- **Recognition:** "How many distinct ways..." + "You can take choice A or choice B..." almost universally points to Dynamic Programming. If the current choice only depends on the immediate past choices, it can be space-optimized.
- **Mental Model:** Think of building a ladder. To know how many ways to step onto the 5th rung, you literally just look down at the 4th rung and the 3rd rung. You sum the ways you got to those two rungs. You don't care about the 1st or 2nd rungs anymore. Thus, you only need to "remember" two things at any time.
