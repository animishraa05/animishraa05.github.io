---
title: "3Sum"
link: "https://leetcode.com/problems/3sum/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem asks us to find all unique triplets in an array that sum up to zero.
**Pattern:** Sorting + Two Pointers.

A brute-force approach would check all possible triplets using three nested loops. This would take $O(N^3)$ time, which is too slow.

To optimize, we can sort the array first. Sorting takes $O(N \log N)$ but allows us to use the **Two Pointers** technique, bringing the time down to $O(N^2)$.
By iterating through the array and fixing one number `nums[i]`, the problem reduces to finding two numbers in the remaining sorted array that sum up to `-nums[i]`. This is exactly the "Two Sum II" problem, which can be solved efficiently using two pointers (one at the beginning of the remaining array, one at the end).

A critical constraint is that the solution set must not contain duplicate triplets. Sorting inherently helps with this because duplicates are placed next to each other, allowing us to easily skip them.

## Code

### Brute-Force Approach
Pseudocode:
1. Initialize an empty set `res` to store unique triplets.
2. Loop `i` from 0 to n-1.
3. Loop `j` from `i+1` to n-1.
4. Loop `k` from `j+1` to n-1.
5. If `nums[i] + nums[j] + nums[k] == 0`, sort the triplet and add to `res`.
6. Return `res` as a list.

```cpp
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        set<vector<int>> res;
        sort(nums.begin(), nums.end()); // Sorting helps to easily add identical tuples to the set
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    if (nums[i] + nums[j] + nums[k] == 0) {
                        res.insert({nums[i], nums[j], nums[k]});
                    }
                }
            }
        }
        return vector<vector<int>>(res.begin(), res.end());
    }
};
```

### Optimal Approach (Sorting + Two Pointers)
Pseudocode:
1. Sort the input array `nums`.
2. Initialize an empty list `res`.
3. Loop `i` from 0 to n-1:
   - If `i > 0` and `nums[i] == nums[i-1]`, `continue` (skip duplicates for the first element).
   - Set `left = i + 1`, `right = n - 1`.
   - While `left < right`:
     - Calculate `total = nums[i] + nums[left] + nums[right]`.
     - If `total > 0`, decrement `right`.
     - If `total < 0`, increment `left`.
     - If `total == 0`, append `[nums[i], nums[left], nums[right]]` to `res`.
       - Increment `left` and decrement `right`.
       - Skip duplicates for `left` and `right` by advancing them past duplicate values.

```cpp
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        vector<vector<int>> res;
        sort(nums.begin(), nums.end());
        int n = nums.size();
        
        for (int i = 0; i < n; ++i) {
            // If the current value is greater than zero, we can't ever sum to zero
            // since the array is sorted.
            if (nums[i] > 0) {
                break;
            }
                
            // Skip positive duplicates to avoid identical triplets
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue;
            }
                
            int left = i + 1;
            int right = n - 1;
            while (left < right) {
                int total = nums[i] + nums[left] + nums[right];
                
                if (total > 0) {
                    right--;
                } else if (total < 0) {
                    left++;
                } else {
                    res.push_back({nums[i], nums[left], nums[right]});
                    left++;
                    right--;
                    // Skip internal duplicates
                    while (left < right && nums[left] == nums[left - 1]) {
                        left++;
                    }
                    while (left < right && nums[right] == nums[right + 1]) {
                        right--;
                    }
                }
            }
        }
                        
        return res;
    }
};
```

## Complexity
- **Brute Force:**
  - Time: $O(N^3)$ due to the three nested loops.
  - Space: $O(N)$ for the set to store unique triplets.
- **Optimal (Sorting + Two Pointers):**
  - Time: $O(N^2)$. The outer loop runs $N$ times. For each iteration, the two pointers traverse the rest of the array in $O(N)$ time. Sorting takes $O(N \log N)$. Overall time is dominated by $O(N^2)$.
  - Space: $O(\log N)$ or $O(N)$ depending on the sorting algorithm implementation in C++. We don't use extra space for sets or hash maps.

## Edge Cases
- **All Zeros:** `[0, 0, 0, 0]`. The algorithm successfully records `[0, 0, 0]` once and uses the inner duplicate skipping logic to bypass the rest.
- **No valid triplets:** `[1, 2, 3]`. The `total > 0` condition breaks early since it's sorted, returning `[]` efficiently.
- **Array size less than 3:** A simple check or the range logic inherently handles this by never entering the loops.

## Notes
**Thought Process & Recognition:** 
Whenever a problem asks for combinations of items (pairs, triplets, quadruplets) that meet a target sum *and specifically demands unique combinations*, **Sorting** should be your immediate instinct. 
Hash maps are great for Two Sum because they find exact indices fast, but when uniqueness is required, hash maps get messy with deduplication. Sorting places identical elements adjacent to each other, making duplicate skipping trivial (`nums[i] == nums[i-1]`). 

Mental breakdown:
1. Sort the array.
2. Fix one element.
3. Solve the rest using classic two pointers.
