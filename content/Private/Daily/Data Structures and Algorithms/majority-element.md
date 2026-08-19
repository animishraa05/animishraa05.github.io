---
title: "Majority Element"
link: "https://leetcode.com/problems/majority-element/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The majority element is the element that appears more than `⌊n / 2⌋` times. You may assume that the majority element always exists in the array.
The best O(1) space algorithm for this is the **Boyer-Moore Voting Algorithm**.
The core idea is that if you pair up every majority element with a non-majority element and eliminate both, the majority element will always be the one left standing because it outnumbers all other elements combined.

## Code

### Brute-Force Approach
Count frequencies using an unordered map and return the one with count > N/2.
```text
Pseudocode:
1. counts = HashMap()
2. For num in nums:
3.   counts[num] += 1
4.   If counts[num] > length of nums / 2: return num
```

### Optimal Approach
Boyer-Moore Voting.
```text
Pseudocode:
1. Initialize `candidate = 0`, `count = 0`.
2. Iterate `num` in `nums`:
3.   If `count == 0`:
4.     `candidate = num`
5.   If `num == candidate`:
6.     `count += 1`
7.   Else:
8.     `count -= 1`
9. Return `candidate`
```

```cpp
class Solution {
public:
    int majorityElement(vector<int>& nums) {
        int count = 0;
        int candidate = 0;
        
        for (int num : nums) {
            if (count == 0) {
                candidate = num;
            }
            
            if (num == candidate) {
                count++;
            } else {
                count--;
            }
        }
        
        return candidate;
    }
};
```

## Complexity
- **Time Complexity:** O(N), we pass through the array exactly once.
- **Space Complexity:** O(1), using only two variables (`candidate`, `count`).

## Edge Cases
- **All elements are the same:** `[1, 1, 1]`. Count just increments.
- **Alternating but majority wins:** `[1, 2, 1, 2, 1]`. Count drops to zero but recovers. The candidate flips but correctly lands on the majority.

## Notes
**Thought Process & Recognition:**
When a problem says "element appears more than N/2 times" and demands O(1) space, Boyer-Moore Voting is essentially hardcoded for this exact scenario. Think of it as a battle royale where differing elements mutually destruct. The most abundant army wins.
