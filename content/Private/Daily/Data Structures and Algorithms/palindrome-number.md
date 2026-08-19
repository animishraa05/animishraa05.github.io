---
title: "Palindrome Number"
link: "https://leetcode.com/problems/palindrome-number/"
topic: "Math"
type: problem
created: 2026-07-19
---

## Approach
The goal is to determine if an integer reads the same backward as forward.
**Pattern:** Integer reversal / Half-reversal.

A common first instinct is to convert the integer to a string and check if the string equals its reverse. However, solving it *without* converting to a string is an excellent exercise in fundamental math operations (modulo and division).

The optimal approach is to reverse only the **second half** of the number and compare it to the **first half**. This prevents potential integer overflow. 

How do we know we've reached the halfway point? When the reversed number is greater than or equal to the original number (which is being reduced at each step).

## Code

### Brute-Force Approach (String Conversion)
Pseudocode:
1. Convert the integer `x` to a string.
2. Check if the string is equal to its reversed version.
3. Handle negative numbers (which can never be palindromes due to the `-` sign).

```cpp
class Solution {
public:
    bool isPalindrome(int x) {
        if (x < 0) {
            return false;
        }
        string s = to_string(x);
        string rev_s = s;
        reverse(rev_s.begin(), rev_s.end());
        return s == rev_s;
    }
};
```

### Optimal Approach (Half-Reversal Math)
Pseudocode:
1. Return false if `x < 0` or if `x` ends in 0 (but is not 0 itself), as leading zeros are invalid.
2. Initialize `revertedNumber = 0`.
3. Loop while `x > revertedNumber`:
   - `revertedNumber = revertedNumber * 10 + x % 10`
   - `x /= 10`
4. When the loop ends, check if `x == revertedNumber` (even length) or `x == revertedNumber / 10` (odd length).

```cpp
class Solution {
public:
    bool isPalindrome(int x) {
        // Special cases:
        // 1. Negative numbers are not palindromes.
        // 2. If the last digit is 0, the first digit must also be 0.
        //    Only 0 satisfies this property.
        if (x < 0 || (x % 10 == 0 && x != 0)) {
            return false;
        }
        
        int revertedNumber = 0;
        while (x > revertedNumber) {
            revertedNumber = revertedNumber * 10 + x % 10;
            x /= 10;
        }
            
        // When the length is an odd number, we can get rid of the middle digit by revertedNumber / 10
        // For example, with 12321, at the end of the loop x = 12, revertedNumber = 123.
        return x == revertedNumber || x == revertedNumber / 10;
    }
};
```

## Complexity
- **Brute Force (String):**
  - Time: $O(N)$ where $N$ is the number of digits. Converting integer to string takes time proportional to the number of digits.
  - Space: $O(N)$ to store the string representation.
- **Optimal (Half-Reversal):**
  - Time: $O(\log_{10}(n))$. We divide the input by 10 for every iteration, meaning we run the loop for half the number of digits in $x$.
  - Space: $O(1)$. We only use a single integer variable `revertedNumber`.

## Edge Cases
- **Negative Numbers:** `-121` reversed is `121-`, which is not equal to `-121`. Handled cleanly with an initial `if (x < 0)` check.
- **Trailing Zeros:** `10` reversed is `01`, which mathematically equals `1`, not `10`. `x % 10 == 0 && x != 0` immediately catches these without extra math.
- **Single Digits:** A number like `5` will immediately skip the `while (x > revertedNumber)` loop and return `True`, since `x == revertedNumber`.
- **Zero:** `0` returns `True`, bypassing the modulo zero check because of `x != 0`.

## Notes
**Thought Process & Recognition:** 
Problems that ask to manipulate an integer mathematically without strings often rely heavily on `% 10` to pop the last digit and `/ 10` to shift the number down. 

When trying to prevent integer overflow in reversal problems, the key insight is to **stop halfway**. For palindromes, halfway is all you need to compare both sides. If you see "palindrome" and "integer", immediately think "pop and push digits mathematically" until the new number matches or exceeds the remaining original number.
