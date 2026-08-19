_given an integer array nums, sorted in increasing order,
remove all the duplicate element inplace_
,
some things to note:

1. the relative order should be same
2. the unique element k, should be returned in sorted order

\*\*brute force
we can just do the same thing as before where we take k as the position of next unique element.
so just do the following

- start and get the edge case if array is empty return 0
- then start i from 1 as first element is always unique.
- then do compare with the last element where the iterator of one will be i and other will be k
- then if not equal then its unique, meaning put it in the position and continue with k++,
- otherwise just the i increases

**psuedocode**

first see if empty
return 0

for int i=1 -> n
if numsi != numsk # meaning if they are unique
numsk = numsi # meaning the value of i will be inserted in k or the next valid element
and k++

then return k
