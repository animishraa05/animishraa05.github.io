_same duplicate occurences of two times is allowed in this question, the first one had only one occurence allowed_

**brute force thinking and solution**

there are some facts to consider

- the k will start from 2 as two are allowed
- and as two are allowed the step becomes nums[i] != nums[k-2]

**pseudocode**

if size of array less than 2
return size
then for i=0 -> n
if nums[k]!=nums[i]
numsk = numsi
k++;
