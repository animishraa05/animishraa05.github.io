---
title: "Maximum Average Subarray I"
link: "https://leetcode.com/problems/maximum-average-subarray-i/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This problem asks for the maximum average of any contiguous subarray of a fixed length `k`.
This perfectly matches the "Fixed-Size Sliding Window" pattern.
Instead of recalculating the sum of `k` elements from scratch for every subarray, we can maintain a "window" of size `k`. 
As the window slides to the right by one element, we subtract the element that leaves the window (on the left) and add the new element that enters the window (on the right). 
This allows us to update the window sum in `O(1)` time. We then track the maximum sum encountered and divide by `k` at the end to get the maximum average.

## Code
### Brute Force
```cpp
// Pseudocode:
// max_avg = -infinity
// For i from 0 to nums.size() - k:
//   current_sum = 0
//   For j from i to i + k - 1:
//       current_sum += nums[j]
//   max_avg = max(max_avg, current_sum / k)
// Return max_avg

#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    double findMaxAverage(std::vector<int>& nums, int k) {
        double max_avg = -std::numeric_limits<double>::infinity();
        for (int i = 0; i <= nums.size() - k; ++i) {
            double window_sum = 0;
            for (int j = i; j < i + k; ++j) {
                window_sum += nums[j];
            }
            max_avg = std::max(max_avg, window_sum / k);
        }
        return max_avg;
    }
};
```

### Optimal Approach
```cpp
// Pseudocode:
// 1. Compute the sum of the first 'k' elements.
// 2. Initialize max_sum = current_window_sum.
// 3. For i from k to nums.size() - 1:
//       current_window_sum = current_window_sum - nums[i - k] + nums[i]
//       max_sum = max(max_sum, current_window_sum)
// 4. Return max_sum / k

#include <vector>
#include <algorithm>

class Solution {
public:
    double findMaxAverage(std::vector<int>& nums, int k) {
        // Calculate the sum of the initial window of size k
        double curr_sum = 0;
        for (int i = 0; i < k; ++i) {
            curr_sum += nums[i];
        }
        double max_sum = curr_sum;
        
        // Slide the window from index k to the end
        for (int i = k; i < nums.size(); ++i) {
            // Update the sum by adding the new element and removing the oldest
            curr_sum += nums[i] - nums[i - k];
            // Track the maximum sum seen so far
            if (curr_sum > max_sum) {
                max_sum = curr_sum;
            }
        }
                
        // Return the maximum average
        return max_sum / k;
    }
};
```

## Complexity
- **Time Complexity**: `O(N)` where `N` is the number of elements in the array. We compute the initial window sum in `O(k)` and then slide the window across the remaining `N - k` elements in `O(N - k)`. Thus, overall time is `O(N)`.
- **Space Complexity**: `O(1)`. We only maintain a few variables (`curr_sum`, `max_sum`) regardless of the size of the array.

## Edge Cases
1. **`k` equals array length (`k == nums.size()`)**: The sliding window loop won't execute, and the function correctly returns the average of the entire array.
2. **Negative Numbers**: The initial `max_sum` is initialized to the first valid window sum, avoiding issues with setting it to 0 or arbitrary small numbers. The sliding window easily handles negative elements.

## Notes
- **Recognition**: The phrases "contiguous subarray" and a fixed size `k` are undeniable hallmarks of the Fixed-Size Sliding Window technique.
- Avoid calculating the average at every step, as floating-point division is slower than integer addition/subtraction. Track the max *sum* instead, and do the division only once at the very end.
