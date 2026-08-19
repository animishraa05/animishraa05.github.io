---
title: "Jump Game"
link: "https://leetcode.com/problems/jump-game/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
You are given an integer array `nums` where each element represents your maximum jump length from that position. You start at index 0. The goal is to determine if you can reach the last index.

**Why Greedy?**
This problem can be solved with Dynamic Programming, tracking reachable states. However, it is fundamentally a question of "reachability." We don't need to know *how* to get to the end, just *if* we can. 

At any given point, the best strategy is simply to keep track of the **maximum reachable index** we've seen so far. As we iterate through the array, if our current index is within our "reachable zone", we can update our max reachable index. If we encounter an index that is *greater* than our max reachable index, it means we are stuck in a hole (behind a zero) and cannot proceed, so we return false.

An alternative intuitive greedy approach is working backwards: trying to shift the "goalpost" from the end of the array to the beginning. 

**Specific questions to practice:**
- Jump Game II
- Jump Game III
- Gas Station

## Code

### Brute-Force / Top-Down DP
Use backtracking with memoization. From index 0, try all possible jumps from `1` to `nums[0]`. Recursively check if any lead to the end.
*Complexity:* $O(n^2)$ time. Space $O(n)$ for memoization array. Will TLE on LeetCode.

### Optimal Approach 1: Greedy (Forwards)
Track the maximum reach.
*Pseudocode logic:*
1. Initialize `maxReach = 0`.
2. Loop `i` through `nums`:
   - If `i > maxReach`: return `false` (we can't even reach this current step).
   - `maxReach = max(maxReach, i + nums[i])`.
   - If `maxReach >= nums.size() - 1`: return `true` (early exit optimization).
3. Return `true`.

### Optimal Approach 2: Greedy (Backwards - "Goalpost shifting")
This is often considered even more intuitive.
*Pseudocode logic:*
1. Set `goal = nums.size() - 1`.
2. Loop `i` backwards from `nums.size() - 2` down to 0:
   - If from index `i` we can reach the `goal` (i.e., `i + nums[i] >= goal`):
     - The new goal is now `i`. We just need to reach `i` now.
3. At the end, if `goal == 0`, return `true`.

```cpp
// Optimal Approach 1: Forward Greedy
class Solution {
public:
    bool canJump(std::vector<int>& nums) {
        int maxReach = 0;
        
        for (int i = 0; i < nums.size(); ++i) {
            // If the current index is beyond our maximum reach, we're stuck
            if (i > maxReach) {
                return false;
            }
                
            // Update the maximum reachable index
            maxReach = std::max(maxReach, i + nums[i]);
            
            // Optimization: If we can already reach the end, stop early
            if (maxReach >= nums.size() - 1) {
                return true;
            }
        }
                
        return true;
    }
};

// Optimal Approach 2: Backward Greedy (For reference)
/*
class Solution {
public:
    bool canJump(std::vector<int>& nums) {
        int goal = nums.size() - 1;
        for (int i = nums.size() - 2; i >= 0; --i) {
            if (i + nums[i] >= goal) {
                goal = i;
            }
        }
        return goal == 0;
    }
};
*/
```

## Complexity
- **Time Complexity:** $O(n)$
  - We traverse the array exactly once.
- **Space Complexity:** $O(1)$
  - We only use a single integer variable (`maxReach` or `goal`).

## Edge Cases
- **Single element array:** `[0]`. Loop starts. `maxReach = 0`, `i = 0`. `maxReach >= 0` returns true. Correct, you are already at the end.
- **Trapped by zero:** `[3, 2, 1, 0, 4]`. 
  - `i=0, reach=3`
  - `i=1, reach=3`
  - `i=2, reach=3`
  - `i=3, reach=3`
  - `i=4, reach=3`. Here `i=4 > maxReach (3)`, returns false. Correct.

## Notes
- **Recognition:** "Can you reach the end" + "Array of steps/jumps". Instead of calculating every path (DP), just track the bounding box of your reach (Greedy).
- **Mental Model:** 
  - *Forward:* Imagine you have a tank of gas. Each cell offers to refill your tank to `nums[i]`, but you only take it if it gives you *more* gas than you currently have. If your gas runs out (`i > maxReach`), you stop.
  - *Backward:* Imagine trying to get home (index $n-1$). You walk backward and find a bus stop at index $n-2$ that drops you off at home. Great! Now your new objective is just to get to that bus stop. You keep moving your destination closer to your starting point.
