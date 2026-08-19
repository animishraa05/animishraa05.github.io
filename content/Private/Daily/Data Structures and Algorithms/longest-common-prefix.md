---
title: "Longest Common Prefix"
link: "https://leetcode.com/problems/longest-common-prefix/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
The task is to find the longest common prefix string amongst an array of strings.
**Pattern:** Vertical Scanning / Horizontal Scanning.

There are two intuitive ways to approach this:
1. **Horizontal Scanning:** Compare the first two strings to find their common prefix. Then compare that prefix with the third string, and so on. If the prefix ever becomes empty, we can stop and return `""`.
2. **Vertical Scanning:** Look at the first character of all strings. If they all match, append it to the prefix. Then look at the second character of all strings, and so forth, stopping as soon as a mismatch occurs or a string's end is reached.

Another very elegant way relies on sorting. If we lexicographically sort the array of strings, the strings with the most differences will end up at the extreme ends. Therefore, the longest common prefix for the entire array is simply the longest common prefix between the **first** and **last** strings in the sorted array!

## Code

### Brute-Force (Vertical Scanning)
Pseudocode:
1. If the array is empty, return `""`.
2. Loop through the characters of the first string `strs[0]`.
3. For each character at index `i`, check if every other string in the array has the same character at index `i`.
4. If a string is too short or has a different character, return the substring of `strs[0]` up to `i`.
5. If the loop completes, return `strs[0]`.

```cpp
class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        if (strs.empty()) {
            return "";
        }
        
        for (int i = 0; i < strs[0].length(); ++i) {
            char c = strs[0][i];
            for (int j = 1; j < strs.size(); ++j) {
                // Stop if we reach the end of any string or find a mismatch
                if (i == strs[j].length() || strs[j][i] != c) {
                    return strs[0].substr(0, i);
                }
            }
        }
                    
        return strs[0];
    }
};
```

### Optimal Approach (Sorting)
Pseudocode:
1. If the array is empty, return `""`.
2. Sort the array of strings lexicographically.
3. Compare the first string `s1` and the last string `s2`.
4. Iterate through `s1` and `s2` simultaneously.
5. Keep adding characters to the prefix as long as `s1[i] == s2[i]`.
6. Return the resulting prefix.

```cpp
class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        if (strs.empty()) {
            return "";
        }
            
        // Sorting lexicographically places the most different strings at the ends
        sort(strs.begin(), strs.end());
        string first = strs.front();
        string last = strs.back();
        
        string prefix = "";
        for (int i = 0; i < min(first.length(), last.length()); ++i) {
            if (first[i] != last[i]) {
                break;
            }
            prefix += first[i];
        }
            
        return prefix;
    }
};
```

## Complexity
- **Vertical Scanning:**
  - Time: $O(S)$ where $S$ is the sum of all characters in all strings. In the worst case, all strings are identical.
  - Space: $O(1)$. We only use constant extra space.
- **Sorting Approach:**
  - Time: $O(N \log N \times M)$, where $N$ is the number of strings and $M$ is the maximum length of a string. String comparison during sorting takes $O(M)$ time.
  - Space: $O(M \log N)$ or $O(\log N)$ auxiliary space depending on the sorting algorithm's implementation in C++.

*Note: While sorting seems worse theoretically on time, in practice for typical inputs, it executes extremely fast due to highly optimized sorting routines.*

## Edge Cases
- **Empty Array:** `strs = []` handled explicitly at the beginning.
- **Array with one element:** `strs = ["a"]` sorted will compare `"a"` to `"a"`, returning `"a"`.
- **No common prefix:** `["dog","racecar","car"]`. The first comparison between the sorted first and last strings instantly breaks, returning `""`.
- **Strings with varying lengths:** Handled smoothly because vertical scanning limits `i` by the shortest string, and the sorting approach uses `min(first.length(), last.length())`.

## Notes
**Thought Process & Recognition:** 
For prefix problems involving arrays of strings, Vertical Scanning is the most standard, reliable method that doesn't do unnecessary work if a mismatch occurs early. 
However, recognizing the property of **lexicographical sorting** is a beautiful hack. Since words are sorted alphabetically, the words that share the least common characters are pushed as far apart as possible (the first and the last). If you find the common prefix of just those two, it is mathematically guaranteed to be the common prefix of everything in between.
