---
title: "Majority Element II"
link: "https://leetcode.com/problems/majority-element-ii/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
We need to find all elements that appear more than `⌊ n/3 ⌋` times. 
A known algorithm for finding majority elements is the **Boyer-Moore Voting Algorithm**.
Since we are looking for elements appearing more than `n/3` times, there can be at most **two** such elements. 
We can extend Boyer-Moore to track two candidates simultaneously.

## Code

### Brute-Force Approach
Use an unordered map to count the frequencies of all elements, then filter those > `n/3`.
```text
Pseudocode:
1. Count frequencies in an unordered_map.
2. Return all keys where value > length of nums / 3.
```

### Optimal Approach
Extended Boyer-Moore Voting Algorithm.
```text
Pseudocode:
1. Initialize cand1, cand2 to arbitrary values, and count1, count2 to 0.
2. Iterate num in nums:
   a. If num == cand1, count1++
   b. Else if num == cand2, count2++
   c. Else if count1 == 0, cand1 = num, count1 = 1
   d. Else if count2 == 0, cand2 = num, count2 = 1
   e. Else, count1--, count2--
3. Candidates are identified. Now do a second pass to verify if their exact counts > n/3.
4. Return verified candidates.
```

```cpp
class Solution {
public:
    vector<int> majorityElement(vector<int>& nums) {
        int cand1 = 0, cand2 = 0;
        int count1 = 0, count2 = 0;
        
        for (int num : nums) {
            if (num == cand1) {
                count1++;
            } else if (num == cand2) {
                count2++;
            } else if (count1 == 0) {
                cand1 = num;
                count1 = 1;
            } else if (count2 == 0) {
                cand2 = num;
                count2 = 1;
            } else {
                count1--;
                count2--;
            }
        }
        
        // Phase 2: Verification
        count1 = 0;
        count2 = 0;
        for (int num : nums) {
            if (num == cand1) count1++;
            else if (num == cand2) count2++;
        }
        
        vector<int> res;
        int n = nums.size();
        if (count1 > n / 3) res.push_back(cand1);
        if (count2 > n / 3) res.push_back(cand2);
            
        return res;
    }
};
```

## Complexity
- **Time Complexity:** O(N), we iterate through the array at most twice.
- **Space Complexity:** O(1), since we only track two candidates and their counts, regardless of N.

## Edge Cases
- **No majority elements:** e.g., `[1, 2, 3, 4, 5]`. Returns empty vector.
- **Exactly one majority element:** Validated and returned.
- **Small arrays:** `[1]`, `[1, 2]` - works correctly.

## Notes
**Thought Process & Recognition:**
When asked to find elements appearing more than `n/k` times in O(1) space, Boyer-Moore Voting is the trick. You need `k-1` candidates and `k-1` counts. Always remember the second pass for verification, because the algorithm only guarantees that *if* there is a majority element, it will be one of the candidates.
