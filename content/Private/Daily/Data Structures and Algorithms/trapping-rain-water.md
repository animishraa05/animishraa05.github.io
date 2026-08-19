---
title: "Trapping Rain Water"
link: "https://leetcode.com/problems/trapping-rain-water/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This is a classic "hard" array problem. The core observation is this:
**The amount of water trapped above any given bar `i` is determined by the maximum height of a bar to its left and the maximum height of a bar to its right.**
Specifically: `water_at_i = min(max_left, max_right) - height[i]`. (If this value is negative, it traps 0 water).

There are several ways to do this:
1. **Dynamic Programming (Prefix/Suffix Arrays):** Precompute `max_left` for all elements in one pass, and `max_right` for all elements in another pass. Then do a final pass to calculate water. (Time: $O(N)$, Space: $O(N)$).
2. **Two Pointers (Most Optimal):** We can optimize the space to $O(1)$. Notice that we only care about the *minimum* of `max_left` and `max_right`. If we have a left pointer and a right pointer, and `max_left < max_right`, then the bottleneck for the left pointer is definitely `max_left`. We don't even need to know the exact `max_right` for that specific element, because we know it's at least as big as the current `max_right`, which is already bigger than `max_left`. 

## Code

### Brute Force / DP Approach
**Pseudocode (DP):**
```text
left_max = array of size N
right_max = array of size N

left_max[0] = height[0]
for i from 1 to N-1: left_max[i] = max(left_max[i-1], height[i])

right_max[N-1] = height[N-1]
for i from N-2 down to 0: right_max[i] = max(right_max[i+1], height[i])

water = 0
for i from 0 to N-1:
    water += min(left_max[i], right_max[i]) - height[i]
return water
```

### Optimal Approach (Two Pointers)
**Pseudocode:**
```text
l = 0, r = N - 1
left_max = height[l], right_max = height[r]
water = 0

while l < r:
    if left_max < right_max:
        l += 1
        left_max = max(left_max, height[l])
        water += left_max - height[l]
    else:
        r -= 1
        right_max = max(right_max, height[r])
        water += right_max - height[r]
        
return water
```

**C++ Code:**
```cpp
#include <vector>
#include <algorithm>

class Solution {
public:
    int trap(std::vector<int>& height) {
        if (height.empty()) return 0;
        
        int l = 0, r = height.size() - 1;
        int left_max = height[l], right_max = height[r];
        int water = 0;
        
        while (l < r) {
            if (left_max < right_max) {
                l++;
                left_max = std::max(left_max, height[l]);
                water += left_max - height[l];
            } else {
                r--;
                right_max = std::max(right_max, height[r]);
                water += right_max - height[r];
            }
        }
        
        return water;
    }
};
```

## Complexity
- **Time Complexity:** $O(N)$. We process each element of the array exactly once as the two pointers move towards each other.
- **Space Complexity:** $O(1)$. Only a few variables are used (`l`, `r`, `left_max`, `right_max`, `water`), eliminating the need for the DP prefix arrays.

## Edge Cases
1. **Empty Array or Array < 3 Elements:** Handled gracefully. If `len < 3`, it's physically impossible to trap water. The loops either don't run or pointers cross instantly.
2. **Flat Terrain (`[5, 5, 5, 5]`):** `left_max` and `right_max` constantly update to 5, `water += 5 - 5` -> 0 water. 
3. **Mountain Shape (`[1, 2, 5, 2, 1]`):** `left_max` and `right_max` grow towards the center. No water is trapped because the peak blocks everything.

## Notes
- **Thought Process & Recognition:** Problems involving containers, water, or bounding heights on both sides strongly suggest **Two Pointers**. Compare this to *Container With Most Water*; the logic of moving the smaller boundary pointer is identical. The intuition is: "The side with the smaller wall is the limiting factor, so process that side first."
- **Why it works so well:** You might worry "what if there's an even taller wall further right?". It doesn't matter! If `left_max` is currently 3, and `right_max` is 5, then for the left pointer, the limiting factor is 3. Even if there's a wall of height 100 in the middle, the water at the current left pointer can never exceed 3. That's the stroke of genius in the two-pointer solution.
