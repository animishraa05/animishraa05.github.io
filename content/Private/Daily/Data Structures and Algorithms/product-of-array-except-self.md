---
title: "Product of Array Except Self"
link: "https://leetcode.com/problems/product-of-array-except-self/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem asks for an array `answer` where `answer[i]` is the product of all elements of `nums` except `nums[i]`. We must write an O(N) solution without using the division operation.
The pattern here is **Prefix and Suffix Arrays**. The product of all elements except `i` is simply `(product of elements to the left of i) * (product of elements to the right of i)`.

## Code

### Brute-Force Approach
For each element, iterate through the rest of the array to find the product.
```text
Pseudocode:
1. Initialize `ans` array of size N with 1s.
2. For i from 0 to N-1:
3.   For j from 0 to N-1:
4.     If i != j, ans[i] *= nums[j]
5. Return ans
```

### Optimal Approach
Compute prefix products and suffix products in two passes. We can store the prefix products directly in the output array, and then multiply by suffix products on the fly to save space.
```text
Pseudocode:
1. N = length of nums. Initialize `ans` array with 1s.
2. `prefix = 1`. For i from 0 to N-1:
     ans[i] = prefix
     prefix *= nums[i]
3. `suffix = 1`. For i from N-1 down to 0:
     ans[i] *= suffix
     suffix *= nums[i]
4. Return ans.
```

```cpp
class Solution {
public:
    vector<int> productExceptSelf(vector<int>& nums) {
        int n = nums.size();
        vector<int> ans(n, 1);
        
        int prefix = 1;
        for (int i = 0; i < n; ++i) {
            ans[i] = prefix;
            prefix *= nums[i];
        }
        
        int suffix = 1;
        for (int i = n - 1; i >= 0; --i) {
            ans[i] *= suffix;
            suffix *= nums[i];
        }
        
        return ans;
    }
};
```

## Complexity
- **Time Complexity:** O(N), as we traverse the array twice.
- **Space Complexity:** O(1) extra space (excluding the output array) since we only use a few integer variables (`prefix`, `suffix`).

## Edge Cases
- **Array with exactly one zero:** `[1, 2, 0, 4]`. The answer should be `[0, 0, 8, 0]`. Handled correctly.
- **Array with multiple zeroes:** `[1, 0, 0, 4]`. Everything should be zero. Handled correctly.
- **Negative numbers:** Automatically handles negative product rules.

## Notes
**Thought Process & Recognition:**
When division is disallowed and we need a cumulative operation excluding the current element, Prefix-Suffix aggregation is the definitive pattern. It works for sums, products, and even other associative operations. Visualizing left-to-right and right-to-left passes usually cracks these open.
