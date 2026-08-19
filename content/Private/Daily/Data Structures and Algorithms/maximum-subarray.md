---
title: "Maximum Subarray"
link: "https://leetcode.com/problems/maximum-subarray/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem asks us to find a contiguous subarray with the maximum possible sum.

There are a few approaches to this, but the absolute best and most recognizable pattern is **Kadane's Algorithm** (Dynamic Programming).

The underlying logic of Kadane's Algorithm is elegantly simple: as we iterate through the array, we ask ourselves at each step: *"Should I add the current element to the existing running subarray, or should I start a brand new subarray starting from this current element?"* 

We make this decision based on what gives us the bigger sum. If the running sum up to the previous element is negative, adding the current element to it will only drag the current element down. So, it's better to just start fresh from the current element. Conversely, if the previous running sum is positive, it strictly helps the current element to grow.

Therefore, `current_subarray_sum = max(nums[i], current_subarray_sum + nums[i])`. We keep track of the `max_subarray_sum` seen so far overall.

## Code

### Brute Force
The brute force solution involves checking the sum of every possible subarray. We can do this with two nested loops.
**Pseudocode:**
```text
max_sum = -infinity
for i from 0 to n-1:
    current_sum = 0
    for j from i to n-1:
        current_sum += nums[j]
        max_sum = max(max_sum, current_sum)
return max_sum
```
This is computationally expensive and hits TLE (Time Limit Exceeded) for large arrays.

### Optimal Approach (Kadane's Algorithm)
**Pseudocode:**
```text
max_sum = nums[0]
current_sum = nums[0]
for i from 1 to n-1:
    current_sum = max(nums[i], current_sum + nums[i])
    max_sum = max(max_sum, current_sum)
return max_sum
```

**C++ Code:**
```cpp
#include <vector>
#include <algorithm>

class Solution {
public:
    int maxSubArray(std::vector<int>& nums) {
        if (nums.empty()) return 0;
        
        int max_sum = nums[0];
        int current_sum = nums[0];
        
        for (int i = 1; i < nums.size(); ++i) {
            current_sum = std::max(nums[i], current_sum + nums[i]);
            max_sum = std::max(max_sum, current_sum);
        }
        
        return max_sum;
    }
};
```

## Complexity
- **Time Complexity:** $O(N)$. We do a single pass through the array. For every element, we perform constant time operations.
- **Space Complexity:** $O(1)$. We only maintain two variables (`current_sum` and `max_sum`). We don't need to store the DP array because the current state only depends on the immediately preceding state.

## Edge Cases
1. **All Negative Numbers (`[-3, -5, -2, -9]`):** Kadane's algorithm works perfectly here. Since `current_sum` will always be negative, `current_sum = max(nums[i], current_sum + nums[i])` will continually pick `nums[i]` (starting fresh). It essentially picks the largest negative number (which is the maximum possible sum). The output for the above would be `-2`.
2. **Single Element Array (`[5]` or `[-1]`):** The loop is bypassed entirely, and it simply returns `nums[0]`.
3. **Alternating Positives and Negatives:** It will continuously build up and discard prefixes perfectly, dropping any prefix that sums to less than 0.

## Notes
- **Thought Process & Recognition:** When you see "maximum/minimum contiguous subarray", your brain should instantly scream "Kadane's Algorithm". It's the gold standard. A secondary pattern to remember is sliding window, but sliding window generally requires all elements to be positive or a specific target sum. 
- **Extension (Divide and Conquer):** There is also a Divide and Conquer approach for this problem that runs in $O(N \log N)$. It involves finding the max subarray in the left half, right half, and crossing the midpoint. While not optimal for this specific problem, it's useful for segment trees and distributed systems.
- **To find the actual subarray indices:** Just maintain `start`, `end`, and `temp_start` variables. Whenever `current_sum` resets to `nums[i]`, update `temp_start = i`. Whenever `max_sum` gets updated, set `start = temp_start` and `end = i`.
