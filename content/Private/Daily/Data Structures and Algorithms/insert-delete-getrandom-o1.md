---
title: "Insert Delete GetRandom O(1)"
link: "https://leetcode.com/problems/insert-delete-getrandom-o1/"
topic: "Array"
type: problem
created: 2026-07-19
---

## Approach
This is a data structure design problem. We need to implement a class that supports `insert`, `remove`, and `getRandom` operations, all in strictly `O(1)` average time complexity.
Let's analyze data structures:
- **Hash Set**: Provides `O(1)` insert and remove. However, getting a truly random element in `O(1)` is impossible because sets do not have indexing.
- **Array / List**: Provides `O(1)` insert (append at the end) and `O(1)` random access (via index). However, removing an arbitrary element is `O(N)` because all subsequent elements must shift down.

**The Solution**: Combine them!
We use a **List** to store the elements to allow `O(1)` random access.
We use a **Hash Map** (Dictionary) to store the element values as keys and their current *index* in the List as values.
- **Insert**: Append the value to the end of the List, and store its index in the Hash Map.
- **Remove**: Here's the magic trick. To remove an element in `O(1)` from a List without shifting, we **swap** it with the very last element in the List, and then `pop_back()` the last element. We also update the Hash Map to reflect the new index of the swapped element, and delete the removed element's entry.
- **GetRandom**: Generate a random integer between `0` and `nums.size() - 1`, and return the element at that index.

## Code
### Optimal Approach
```cpp
#include <vector>
#include <unordered_map>
#include <cstdlib>

class RandomizedSet {
private:
    // List stores the actual values for random access
    std::vector<int> nums;
    // Dictionary stores {value: index_in_nums} for O(1) location tracking
    std::unordered_map<int, int> val_to_index;

public:
    RandomizedSet() {
        
    }
    
    bool insert(int val) {
        if (val_to_index.find(val) != val_to_index.end()) {
            return false;
        }
        
        // Add to the end of the list
        nums.push_back(val);
        // Record its index (which is length - 1)
        val_to_index[val] = nums.size() - 1;
        return true;
    }
    
    bool remove(int val) {
        if (val_to_index.find(val) == val_to_index.end()) {
            return false;
        }
        
        // Get the index of the element to remove
        int idx_to_remove = val_to_index[val];
        // Get the value of the last element in the list
        int last_val = nums.back();
        
        // SWAP TRICK: Move the last element to the spot of the element to remove
        nums[idx_to_remove] = last_val;
        val_to_index[last_val] = idx_to_remove;
        
        // Now remove the very last element from the list (O(1) operation)
        nums.pop_back();
        // Remove the target value from the dictionary
        val_to_index.erase(val);
        
        return true;
    }
    
    int getRandom() {
        // rand() % nums.size() is O(1)
        return nums[rand() % nums.size()];
    }
};
```

## Complexity
- **Time Complexity**: 
  - `insert`: `O(1)` average. Appending to a list and adding to a hash map are both amortized `O(1)`.
  - `remove`: `O(1)` average. Dictionary lookup, list index assignment, and `pop_back()` from the end are all `O(1)`.
  - `getRandom`: `O(1)`. Generating a random number and array access are `O(1)`.
- **Space Complexity**: `O(N)` where `N` is the number of elements. Both the list and hash map store `N` elements.

## Edge Cases
1. **Removing the last element**: If the element we want to remove happens to already be the last element in the list, the "swap" logic still works perfectly. It overwrites itself with itself, updates the dict with the same index, pops itself, and deletes from the dict.
2. **Empty structure**: The constraints ensure `getRandom` is only called when there is at least one element, preventing random choice errors on empty lists.

## Notes
- **Recognition**: If a problem demands `O(1)` time for `insert`, `delete`, AND `random access/indexing`, the canonical answer is always Array + Hash Map mapping Value -> Array Index.
- The **Swap & Pop** technique is a very common systems trick to achieve `O(1)` array deletion when order doesn't matter. Understanding this fundamentally changes how you view array limitations.
