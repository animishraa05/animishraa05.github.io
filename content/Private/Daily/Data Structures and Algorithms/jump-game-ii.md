---
title: "Jump Game II"
link: "https://leetcode.com/problems/jump-game-ii/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We are given an array of integers where each element represents the maximum jump length at that position. We want to find the **minimum number of jumps** to reach the last index.

The most intuitive optimal approach is a **Greedy (BFS-like)** approach. We can think of it in terms of "windows" or "levels" of reachability. 
- The first level is just index 0.
- The second level contains all indices reachable from index 0.
- The third level contains all indices reachable from the elements in the second level.

Instead of actually building a BFS queue (which would take $O(N)$ space), we can just maintain pointers to represent the current window boundaries: `l` (left boundary of the current level) and `r` (right boundary of the current level). 
We also track the `farthest` index we can reach from the current window. Once our iteration reaches `r`, it means we've examined all possible jumps in the current level. We then increment our jump count, and our new window becomes `[r + 1, farthest]`.

## Code

### Brute Force (Dynamic Programming / Recursion)
At every index, we try every possible jump length and recursively find the minimum jumps from there to the end.
**Pseudocode:**
```text
function min_jumps(i):
    if i >= n - 1: return 0
    res = infinity
    for step from 1 to nums[i]:
        res = min(res, 1 + min_jumps(i + step))
    return res
```
With memoization (Top-Down DP), this is $O(N^2)$ time. This is decent but will get TLE for large inputs. 

### Optimal Approach (Greedy / Implicit BFS)
**Pseudocode:**
```text
jumps = 0
l = 0, r = 0
while r < n - 1:
    farthest = 0
    for i from l to r:
        farthest = max(farthest, i + nums[i])
    l = r + 1
    r = farthest
    jumps += 1
return jumps
```

**C++ Code:**
```cpp
#include <vector>
#include <algorithm>

class Solution {
public:
    int jump(std::vector<int>& nums) {
        int jumps = 0;
        int l = 0;
        int r = 0;
        
        while (r < nums.size() - 1) {
            int farthest = 0;
            for (int i = l; i <= r; ++i) {
                farthest = std::max(farthest, i + nums[i]);
            }
            l = r + 1;
            r = farthest;
            jumps++;
        }
        
        return jumps;
    }
};
```

## Complexity
- **Time Complexity:** $O(N)$. Even though there is a nested loop, the `l` and `r` pointers simply slide across the array. Every index `i` is visited exactly once by the inner loop.
- **Space Complexity:** $O(1)$. We only maintain a few integer pointers (`jumps`, `l`, `r`, `farthest`).

## Edge Cases
1. **Single Element Array (`[0]`):** The loop condition `r < len(nums) - 1` becomes `0 < 0`, which is false. Returns `0` jumps immediately. This is correct since we are already at the last index.
2. **First Element is 0 (`[0, 2, 3]`):** The problem description guarantees that we can always reach the last index. Thus, a test case where we are stuck at 0 on the first jump won't be given unless it's a size 1 array.
3. **Massive Jump Early (`[10, 1, 1, 1]`):** At index 0, `farthest = 10`. The next window becomes `l=1, r=10`. The loop terminates. Jump count is 1.

## Notes
- **Thought Process & Recognition:** When you see "find the minimum number of steps to reach the end" and you have arrays dictating movement, think **BFS**. Shortest path in an unweighted graph is always BFS. The greedy array sliding window is just a space-optimized BFS. 
- In contrast, the original *Jump Game* just asks if it's *possible* to reach the end. That one just requires maintaining `max_reachable` and updating it. Jump Game II requires counting, hence the level-by-level window approach.
