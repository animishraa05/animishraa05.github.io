_you will be a given a nums array and a integer val, you gotta remove the occurences of val inplace. return the number of element in nums not equal to val._

**brute force approach and thinking**

--I think the most easiest way to think is to iterate through the loop and when you see number equal to target then remove them from The array.

Return k, first k elements should be valid.(order of elements can be changed.)

**approach is whenver we see a number that is not val, we put it in front.**

two pointers needed, one to iterate and read each element and one pointer to write or store every valid element at front.
k= next position jispr valid number hoga
dry run- [0,1,2,2,3,0,4,2] val = 2
first k =0. k !=2, increase k, put in numsk
nums[i]=0, k!=2, increase k, put in numsk
nums[i]=2. k =2, skip k do not increase.k is at 2, dont put in numsk
nums[i]=2, skip k, same as above.
nums[i]=3,k !=2 put in nums[k],so the numsk, so nums[2] = 3 now.
this is how the entire shift will go on and the end result will be returning the k which will be equal to the valid elements which is what we need.

_pseudocode_
-- start k=0
for each element in nums
compare numsi not equal to val, place the element at nums[k] and increase k
then return k

tc- o(n)
sc- o(1)
**this a classic two pointer where we do it in one pass, one for read and one for write**
