---
title: "Subarray Sum Equals K"
link: "https://leetcode.com/problems/subarray-sum-equals-k/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We need to find the total number of continuous subarrays whose sum equals `k`. 
Since there can be negative numbers, a sliding window (two pointers) strategy **will not work** (because expanding the window doesn't guarantee the sum will increase, and shrinking doesn't guarantee a decrease).
Instead, we use **Prefix Sums + Hash Map**.

Let `prefix_sum[i]` be the sum of elements from index `0` to `i`. 
The sum of a subarray from index `j` to `i` (where `j <= i`) is:
`sum[j...i] = prefix_sum[i] - prefix_sum[j-1]`

We want this subarray sum to equal `k`:
`prefix_sum[i] - prefix_sum[j-1] = k`
Rearranging this:
`prefix_sum[j-1] = prefix_sum[i] - k`

This means as we iterate through the array computing the running `prefix_sum`, if we have seen a past prefix sum equal to `prefix_sum - k`, it means there is a valid subarray ending at our current index. We use a Hash Map to store the frequencies of all prefix sums we've seen so far to achieve O(1) lookups.

## Code
### Brute Force
```cpp
// Pseudocode:
// count = 0
// For i from 0 to nums.size():
//   current_sum = 0
//   For j from i to nums.size():
//       current_sum += nums[j]
//       If current_sum == k:
//           count += 1
// Return count

#include <vector>

class Solution {
public:
    int subarraySum(std::vector<int>& nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int curr_sum = 0;
            for (int j = i; j < nums.size(); ++j) {
                curr_sum += nums[j];
                if (curr_sum == k) {
                    count++;
                }
            }
        }
        return count;
    }
};
```

### Optimal Approach
```cpp
// Pseudocode:
// prefix_counts = {0: 1} // Base case: a prefix sum of 0 has occurred once
// current_sum = 0, count = 0
// For num in nums:
//   current_sum += num
//   If (current_sum - k) is in prefix_counts:
//       count += prefix_counts[current_sum - k]
//   prefix_counts[current_sum]++
// Return count

#include <vector>
#include <unordered_map>

class Solution {
public:
    int subarraySum(std::vector<int>& nums, int k) {
        // Map to store the frequency of prefix sums
        // Initialize with {0: 1} for the case where the subarray starts at index 0
        std::unordered_map<int, int> prefix_sum_counts;
        prefix_sum_counts[0] = 1; 
        
        int curr_sum = 0;
        int count = 0;
        
        for (int num : nums) {
            curr_sum += num;
            
            // If curr_sum - k exists in our map, we found valid subarrays
            int target = curr_sum - k;
            if (prefix_sum_counts.find(target) != prefix_sum_counts.end()) {
                count += prefix_sum_counts[target];
            }
                
            // Add the current prefix sum to the map
            prefix_sum_counts[curr_sum]++;
        }
            
        return count;
    }
};
```

## Complexity
- **Time Complexity**: `O(N)` where `N` is the length of the array. We iterate through the array exactly once. Hash map lookups and insertions are `O(1)` on average.
- **Space Complexity**: `O(N)`. In the worst-case scenario (all elements are positive or distinct), all running sums will be different, storing `N` distinct sums in the hash map.

## Edge Cases
1. **Negative numbers**: This algorithm inherently handles negative numbers seamlessly. A prefix sum might go up and down, and the frequency map will accurately track how many times a particular sum was reached.
2. **Subarray starting from index 0**: The initialization `{0: 1}` is crucial. If `curr_sum == k`, then `curr_sum - k = 0`. The map looks up `0` and adds `1` to the count, correctly identifying the subarray from the start to the current element.
3. **`k = 0`**: It handles finding subarrays that sum to zero perfectly. It just checks if `curr_sum` has been seen before.

## Notes
- **Recognition**: If a problem involves subarray sums and contains negative numbers, sliding window is out, prefix sum + hash map is the gold standard. 
- Understand the math deeply: `prefix_i - prefix_j = k` means subarray `[j+1...i]` sums to `k`. Therefore, while at `i`, look backward for `prefix_j = prefix_i - k`.
- Always remember the `{0: 1}` base case. It solves the exact scenario where the entire prefix itself is exactly `k`.
