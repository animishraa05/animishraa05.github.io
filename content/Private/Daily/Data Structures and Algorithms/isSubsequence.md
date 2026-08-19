_2 strings s and t, one only has to tell whether a string s is subsequence of t or not_

**What is a subsequence**

a string or number s is subsequence of t if all the characters or number occur in t and they should just maintain relative order, there is no need to maintain continuity.

### Solution

- in this we will use 2 pointer where we will be putting both pointer at start of both the strings
- using loop iteration we will be comparing them char by char
- when they are equal we will increment both, if not we will increment t.
- in the end we will return if all are found .

**Trigger:** Checking relative order preservation across two strings.
**Mechanical Approach:** Two Pointers.

- Pointer `i` on `s`, pointer `j` on `t`.
- If `s[i] == t[j]`, move both. Else move `j`.
- Valid if `i` fully traverses `s` (`i == len(s)`).

**The System/Scale Follow-up:**

- _Scenario:_ 1 massive string `t`, $10^9$ incoming short strings `s`.
- _Architecture:_ Don't rescan `t`. Precompute `t` into a Hash Map of `char -> [list of indices]`.
- _Execution:_ For each char in `s`, use Binary Search (`bisect_right`) on the Hash Map's index list to find the next valid, strictly greater index in $O(\log N)$ time.

**Blindspot:** Always handle `s = ""` early. It should return `True`.
