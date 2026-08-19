---
title: "Find the Smallest Divisor Given a Threshold"
link: "https://leetcode.com/problems/find-the-smallest-divisor-given-a-threshold/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We need to find the smallest integer divisor such that the sum of the division results (rounded up) of an array is less than or equal to a given threshold.

This is a classic "Binary Search on Answer" problem. 
If we pick a divisor `d`, we calculate the sum of `ceil(num/d)` for all `num` in the array. 
- If the sum is > threshold, the divisor is too small (it didn't shrink the numbers enough). We must search larger divisors.
- If the sum is <= threshold, the divisor is valid, but we want the *smallest* valid divisor. We record this divisor and search smaller divisors.

The search space for the divisor is from `1` (minimum possible divisor) to `max(nums)` (any divisor larger than max(nums) will yield a sum equal to len(nums), which is the minimum possible sum).

## Code
### Brute Force
```cpp
// Pseudocode:
// For divisor from 1 to max(nums):
//   sum = 0
//   For num in nums:
//     sum += ceil(num / divisor)
//   If sum <= threshold:
//     return divisor

#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestDivisor_brute(vector<int>& nums, int threshold) {
        int max_val = *max_element(nums.begin(), nums.end());
        for (int d = 1; d <= max_val; d++) {
            long long current_sum = 0;
            for (int num : nums) {
                // Integer division math trick for ceiling: (num + divisor - 1) / divisor
                current_sum += (num + d - 1) / d;
            }
            if (current_sum <= threshold) {
                return d;
            }
        }
        return -1;
    }
};
```

### Optimal Approach (Binary Search)
```cpp
// Pseudocode:
// left = 1, right = max(nums)
// ans = -1
// While left <= right:
//   mid = (left + right) / 2
//   sum_val = 0
//   For num in nums: sum_val += ceil(num / mid)
//   If sum_val <= threshold:
//     ans = mid
//     right = mid - 1
//   Else:
//     left = mid + 1
// Return ans

#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestDivisor(vector<int>& nums, int threshold) {
        auto compute_sum = [&](int divisor) {
            long long sum = 0;
            for (int num : nums) {
                // We can avoid math.ceil by using integer division math trick: (num + divisor - 1) / divisor
                sum += (num + divisor - 1) / divisor;
            }
            return sum;
        };
        
        int left = 1;
        int right = *max_element(nums.begin(), nums.end());
        int ans = -1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (compute_sum(mid) <= threshold) {
                ans = mid;
                // Try to find a smaller valid divisor
                right = mid - 1;
            } else {
                // Divisor is too small, sum is too large
                left = mid + 1;
            }
        }
        
        return ans;
    }
};
```

## Complexity
- **Time Complexity:** $O(N \log M)$, where $N$ is the length of the array and $M$ is the maximum element in the array. The binary search takes $O(\log M)$ iterations, and in each iteration, we traverse the array of length $N$ to compute the sum.
- **Space Complexity:** $O(1)$. Only variables for the binary search bounds and running sums are used.

## Edge Cases
1. **Threshold equals array length:** The only way to get a sum equal to `nums.size()` is if every division yields 1. This happens when the divisor is >= the maximum element. The binary search will correctly narrow down to `max(nums)`.
2. **Very large threshold:** If threshold is huge, a very small divisor like `1` might immediately satisfy the condition. The search correctly returns 1.

## Notes
- **Thought Process & Recognition:** Whenever a problem asks for the "minimum integer to satisfy a condition" or "maximum integer to satisfy a condition", and the condition's output is monotonically decreasing/increasing with respect to the input integer, it is a Binary Search on Answer problem. 
- **Mental Model:** Think of the divisor as a "compression level". Higher compression (larger divisor) makes the file (sum) smaller. We want the minimum compression level that fits the file onto a disk of size `threshold`. If it doesn't fit, turn up compression (move `left` up). If it fits, try turning down compression to see if we can get better quality (move `right` down).
