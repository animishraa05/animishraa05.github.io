---
title: "Max Consecutive Ones"
link: "https://leetcode.com/problems/max-consecutive-ones/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This is a straightforward array traversal problem. We need to find the maximum number of consecutive `1`s in a binary array.
We can solve this by iterating through the array while maintaining a counter for the current streak of `1`s.
- If we see a `1`, we increment our current streak counter and update the maximum streak seen so far.
- If we see a `0`, it breaks the streak, so we reset our current streak counter to `0`.

## Code
### Optimal Approach (Brute force is practically identical)
```cpp
// Pseudocode:
// max_count = 0
// current_count = 0
// For num in nums:
//   If num == 1:
//       current_count += 1
//       max_count = max(max_count, current_count)
//   Else:
//       current_count = 0
// Return max_count

#include <vector>
#include <algorithm>

class Solution {
public:
    int findMaxConsecutiveOnes(std::vector<int>& nums) {
        int max_ones = 0;
        int current_ones = 0;
        
        for (int num : nums) {
            if (num == 1) {
                current_ones++;
                if (current_ones > max_ones) {
                    max_ones = current_ones;
                }
            } else {
                current_ones = 0;
            }
        }
                
        return max_ones;
    }
};
```

## Complexity
- **Time Complexity**: `O(N)` where `N` is the number of elements in the array. We visit every element exactly once.
- **Space Complexity**: `O(1)`. Only two integer variables (`max_ones` and `current_ones`) are maintained, which requires constant extra space.

## Edge Cases
1. **Array containing all 1s**: E.g., `[1, 1, 1]`. The `current_ones` variable keeps incrementing and updating `max_ones`, correctly returning 3.
2. **Array containing all 0s**: E.g., `[0, 0, 0]`. The `current_ones` never increments, `max_ones` remains 0, correctly returning 0.
3. **Empty array**: If the input can be empty, returning `0` is correct. The loop won't execute.
4. **Single element array**: `[1]` returns 1. `[0]` returns 0.

## Notes
- **Recognition**: This is a fundamental introductory problem for array traversal and state tracking. It teaches the concept of resetting a state when a condition fails.
- This pattern forms the basis for more complex sliding window problems. For example, "Max Consecutive Ones III" introduces the ability to flip `k` zeroes to ones, turning it into a true sliding window problem.
