# 167. Two Sum II - Input Array Is Sorted

**Trigger:** "Sorted Array" + Finding a "Sum" + $O(1)$ Space constraint.
**Mechanical Approach:** Opposite-Directional Two Pointers.

- `left` at start (0), `right` at end ($N-1$).
- If `sum < target`: we need a bigger number $\rightarrow$ `left += 1`.
- If `sum > target`: we need a smaller number $\rightarrow$ `right -= 1`.
- If `sum == target`: Return indices.

**System/Engineering Value:** - Replaces $O(N)$ HashMap memory with $O(1)$ pointer memory. Crucial for massive, sorted datasets that cannot fit into RAM (e.g., streaming large log files from disk where we only hold pointer offsets).

**Blindspot:** - The problem explicitly asks for **1-based indices**. Return `[left + 1, right + 1]`.
