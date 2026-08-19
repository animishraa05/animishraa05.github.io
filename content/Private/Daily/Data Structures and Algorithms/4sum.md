---
title: "4Sum"
link: "https://leetcode.com/problems/4sum/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem asks us to find all unique quadruplets in an array that sum up to a given `target`.
**Pattern:** Generalized k-Sum (Sorting + Two Pointers + Recursion/Loops).

Similar to 3Sum, a brute force approach of four nested loops would yield $O(N^4)$ time, which is unacceptable. 
We can extend the optimal logic of 3Sum:
1. Sort the array.
2. Fix one number, reducing the problem to 3Sum.
3. Fix a second number, reducing the problem to Two Sum II (Two Pointers).

This gives an $O(N^3)$ solution for 4Sum.
For a scalable approach, we can write a generalized `kSum` function. If $k=2$, we use the two-pointer approach. If $k>2$, we iterate through the array, fix the current element, and recursively call `kSum` with $k-1$ and a reduced target.

## Code

### Brute-Force Approach
Pseudocode:
1. Four nested loops `i`, `j`, `k`, `l`.
2. Check if the sum equals `target`.
3. Store in a set to avoid duplicates.

```cpp
// Unacceptably slow, purely for theoretical understanding
class Solution {
public:
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        set<vector<int>> res;
        sort(nums.begin(), nums.end());
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    for (int l = k + 1; l < n; ++l) {
                        if ((long long)nums[i] + nums[j] + nums[k] + nums[l] == target) {
                            res.insert({nums[i], nums[j], nums[k], nums[l]});
                        }
                    }
                }
            }
        }
        return vector<vector<int>>(res.begin(), res.end());
    }
};
```

### Optimal Approach (Sorting + Generalized k-Sum)
Pseudocode:
1. Sort `nums`.
2. Define `kSum(start_index, target, k)`.
3. Base Cases for `kSum`:
   - If `start_index` is out of bounds, return `[]`.
   - If the smallest possible sum (k * smallest element) > target, return `[]`.
   - If the largest possible sum (k * largest element) < target, return `[]`.
4. If $k == 2$: perform standard Two Sum using two pointers.
5. If $k > 2$:
   - Loop `i` from `start_index` to `n-1`.
   - Skip duplicates: `if i > start_index and nums[i] == nums[i-1]`.
   - Call `kSum(i + 1, target - nums[i], k - 1)`.
   - Append `nums[i]` to each result returned and collect them.

```cpp
class Solution {
public:
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        return kSum(nums, target, 0, 4);
    }

private:
    vector<vector<int>> kSum(vector<int>& nums, long long target, int start, int k) {
        vector<vector<int>> res;
        
        // Base cases to early terminate
        if (start == nums.size()) {
            return res;
        }
        
        long long average_value = target / k;
        // We cannot obtain a sum of target if the smallest value is greater than the average
        // or the largest value is smaller than the average.
        if (nums[start] > average_value || average_value > nums.back()) {
            return res;
        }
        
        if (k == 2) {
            return twoSum(nums, target, start);
        }
        
        for (int i = start; i < nums.size(); ++i) {
            // Skip duplicates
            if (i == start || nums[i - 1] != nums[i]) {
                for (vector<int>& subset : kSum(nums, target - nums[i], i + 1, k - 1)) {
                    res.push_back({nums[i]});
                    res.back().insert(res.back().end(), subset.begin(), subset.end());
                }
            }
        }
        
        return res;
    }

    vector<vector<int>> twoSum(vector<int>& nums, long long target, int start) {
        vector<vector<int>> res;
        int left = start;
        int right = nums.size() - 1;
        
        while (left < right) {
            long long total = (long long)nums[left] + nums[right];
            
            if (total < target) {
                left++;
            } else if (total > target) {
                right--;
            } else {
                res.push_back({nums[left], nums[right]});
                left++;
                right--;
                while (left < right && nums[left] == nums[left - 1]) {
                    left++;
                }
            }
        }
        
        return res;
    }
};
```

## Complexity
- **Time:** $O(N^{k-1})$. For 4Sum, $k=4$, so the time complexity is $O(N^3)$. The recursive `kSum` function nests loops up to $k-2$ times, and the base case (Two Sum) takes $O(N)$. Thus, $O(N^{k-2} \times N) = O(N^{k-1})$.
- **Space:** $O(k)$ for the recursion stack. For 4Sum, this is $O(1)$ auxiliary space. Sorting in C++ generally takes $O(\log N)$ space.

## Edge Cases
- **Large Target/Elements:** Overflows can happen if numbers are huge. Using `long long` for targets and sums handles arbitrarily large integers automatically. The early termination `nums[start] > average_value || average_value > nums.back()` handles mathematically impossible targets instantly.
- **Duplicates everywhere:** `[2, 2, 2, 2, 2]` with target `8`. Handled cleanly by the `i == start || nums[i - 1] != nums[i]` deduplication logic.

## Notes
**Thought Process & Recognition:** 
When scaling from 3Sum to 4Sum, you should immediately recognize that writing 3 nested loops (with a two-pointer base) is brittle. Hardcoding `n` nested loops is terrible practice.
Instead, recognize the recursive nature: $k$-Sum is just a loop that picks an element and calls $(k-1)$-Sum. 
The real magic is in the **early termination**. Calculating the average needed `target / k` and checking if the smallest or largest elements can even support that average prunes massive branches of the recursion tree, turning a slow $O(N^3)$ into an extremely fast execution in practice.
