---
title: "Roman to Integer"
link: "https://leetcode.com/problems/roman-to-integer/"
topic: "Hash Table"
type: problem
created: 2026-07-19
---

## Approach
The core problem is to convert a string of Roman numerals into an integer. 
**Pattern:** Hash Table & String Traversal.

Roman numerals are generally written from largest to smallest from left to right. When this rule is followed, we simply add the values.
However, if a smaller numeral appears *before* a larger numeral, it means we subtract the smaller numeral from the larger one (e.g., IV = 5 - 1 = 4).

The optimal approach is to traverse the string from left to right. For each character, we compare its value with the value of the *next* character. If the current value is less than the next value, we subtract it from our total. Otherwise, we add it. 
An alternative, equally good way is to traverse from right to left, adding values unless a value is strictly less than the previously seen maximum value, in which case we subtract it.

## Code

### Brute-Force / Naive Approach
A naive approach might involve doing string replacements for the edge cases (e.g., replace "IV" with "IIII", "IX" with "VIIII") and then just summing up the characters. This works but requires extra string modification overhead.

```cpp
class Solution {
public:
    int romanToInt(string s) {
        unordered_map<string, string> replacements = {
            {"IV", "IIII"}, {"IX", "VIIII"},
            {"XL", "XXXX"}, {"XC", "LXXXX"},
            {"CD", "CCCC"}, {"CM", "DCCCC"}
        };
        
        for (const auto& pair : replacements) {
            size_t pos = 0;
            while ((pos = s.find(pair.first, pos)) != string::npos) {
                s.replace(pos, pair.first.length(), pair.second);
                pos += pair.second.length();
            }
        }
        
        unordered_map<char, int> roman = {
            {'I', 1}, {'V', 5}, {'X', 10}, {'L', 50},
            {'C', 100}, {'D', 500}, {'M', 1000}
        };
        
        int total = 0;
        for (char c : s) {
            total += roman[c];
        }
        return total;
    }
};
```

### Optimal Approach (Left to Right Evaluation)
Pseudocode:
1. Create a hash map for Roman symbols to their integer values.
2. Initialize `total = 0`.
3. Loop through `s` using an index `i`.
4. If `i + 1 < s.length()` and the value of `s[i]` is less than `s[i+1]`, subtract `s[i]`'s value from `total`.
5. Else, add `s[i]`'s value to `total`.

```cpp
class Solution {
public:
    int romanToInt(string s) {
        unordered_map<char, int> roman = {
            {'I', 1}, {'V', 5}, {'X', 10}, {'L', 50},
            {'C', 100}, {'D', 500}, {'M', 1000}
        };
        
        int total = 0;
        int n = s.length();
        
        for (int i = 0; i < n; ++i) {
            // If current symbol is less than the next symbol, we subtract it.
            if (i + 1 < n && roman[s[i]] < roman[s[i + 1]]) {
                total -= roman[s[i]];
            } else {
                // Otherwise, we add it.
                total += roman[s[i]];
            }
        }
                
        return total;
    }
};
```

## Complexity
- **Optimal (Left-to-Right):**
  - Time: $O(N)$ where $N$ is the length of the string. We iterate through the string exactly once. Lookups in the hash map take $O(1)$ time. (Note: Since the maximum Roman numeral string length is finite and small, this is effectively $O(1)$, but $O(N)$ relative to string size is accurate).
  - Space: $O(1)$. The hash map requires a constant amount of space (7 symbols).

## Edge Cases
- **Smallest preceding largest:** e.g., `MCMXCIV` -> 1000 + (1000-100) + (100-10) + (5-1) = 1994. Handled correctly because 'C' < 'M' triggers subtraction, 'X' < 'C' triggers subtraction, etc.
- **String with repeating characters:** `III` -> 1+1+1=3. The condition `roman[s[i]] < roman[s[i+1]]` evaluates to False, so it correctly adds.
- **Single character:** e.g., `D`. Loop runs once, `i+1 < n` is false, adds 500.

## Notes
**Thought Process & Recognition:** 
Whenever a problem involves symbols mapped to values with sequential rules, a Hash Table to store the mappings is standard. The "look ahead" logic is the key realization here. 
You can easily identify this pattern in parsing problems where the meaning of a token depends heavily on its immediately adjacent neighbors.
By comparing adjacent tokens efficiently, you avoid complex state machines.
