---
title: "Plus One"
link: "https://leetcode.com/problems/plus-one/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The problem asks us to increment a large integer represented as an array of digits by one. The most significant digit is at the head of the array, and each element contains a single digit.

**Why Reverse Iteration?**
When performing addition manually on paper, we start from the least significant digit (the rightmost end). We add 1. If the sum is 10, it causes a carry-over of 1 to the next digit to the left. We simply simulate this elementary school arithmetic process.

**Specific questions to practice:**
- Add Binary
- Add Two Numbers (Linked List version)
- Multiply Strings

## Code

### Brute-Force Approach
Convert the array of digits into an actual integer, add 1 to the integer, and then convert it back into an array of digits.
*Pseudocode logic:*
1. Convert array of digits to a string, then cast to an integer (or a large integer type).
2. Add 1.
3. Cast back to string, then parse back to an array of integers.
*Complexity:* $O(n)$ time, but $O(n)$ space for string/integer conversions. Also, this approach will definitely cause integer overflow in C++ for very large arrays, as built-in types like `long long` max out at 19 digits. It's fundamentally flawed for arbitrary precision arithmetic.

### Optimal Approach (In-Place Array Manipulation)
Iterate from the back of the array. If the digit is less than 9, increment it and immediately return. If it is 9, change it to 0 and continue the carry to the next digit left.

*Pseudocode logic:*
1. Loop `i` from `digits.size() - 1` down to 0:
   - If `digits[i] < 9`:
     - `digits[i] += 1`
     - Return `digits`
   - Else:
     - `digits[i] = 0`
2. If the loop finishes without returning, it means every digit was a 9 (e.g., `[9, 9, 9]`). It has now become `[0, 0, 0]`.
3. We need to prepend a 1. In C++, we can easily insert `1` at the beginning.

```cpp
class Solution {
public:
    std::vector<int> plusOne(std::vector<int>& digits) {
        // Iterate backwards through the array
        for (int i = digits.size() - 1; i >= 0; --i) {
            if (digits[i] < 9) {
                // No carry needed, just add 1 and return
                digits[i]++;
                return digits;
            } else {
                // Carry needed, set current to 0 and loop continues
                digits[i] = 0;
            }
        }
                
        // If we reach this point, all digits were 9 (e.g., 999 -> 000)
        // We need to prepend a 1 to make it 1000
        // inserting at begin() is O(n), which is fine here since it only happens once.
        digits.insert(digits.begin(), 1);
        return digits;
    }
};
```

## Complexity
- **Time Complexity:** 
  - **Best Case:** $O(1)$. When the last digit is $< 9$ (e.g., `[1, 2, 3]`), we do one operation and return.
  - **Worst Case:** $O(n)$. When all digits are 9 (e.g., `[9, 9, 9]`), we traverse the entire array and possibly do an $O(n)$ shift for `insert`. Overall time is $O(n)$.
- **Space Complexity:** 
  - $O(1)$ auxiliary space since we modify the array in-place. If the vector needs to reallocate for the `insert`, it takes $O(n)$ space.

## Edge Cases
- **All 9s:** `[9, 9, 9]`. The loop sets everything to `[0, 0, 0]`. The `insert` at the beginning successfully turns it into `[1, 0, 0, 0]`.
- **Single digit:** `[5]` becomes `[6]`. `[9]` becomes `[1, 0]`. Both handled cleanly.

## Notes
- **Recognition:** Problems involving "large numbers represented as strings or arrays" usually require manual simulation of grade-school arithmetic from right to left. Always look out for the carry overflow at the very end of the iteration.
- **Mental Model:** Think of an odometer in a car rolling over. Usually, only the last wheel turns (best case $O(1)$). But if the last wheel is at 9, it clicks to 0 and forces the next wheel to turn. If all wheels are at 9, they all click to 0, and you need to bolt on a brand new wheel at the front.
