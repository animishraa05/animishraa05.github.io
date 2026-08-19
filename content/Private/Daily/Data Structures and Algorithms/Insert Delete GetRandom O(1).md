*To implement a randomisedset class with insert, delete and getRandom function.*

#### brute force and thinkings

take a vector<int> nums.

for Insert.
- take an iterator and iterator using find method, when iterator  searches for element and finds it, it returns false.
- other wise nums.push_back into the value.

for remove.
- take the iterator and search for the entire value in the group. when found then false, if not found then erase the given element and then return true.

for randomaccess

- Will use nums[rand() %  nums.size()] as this will return the  value 1-  1 - nums.size().

#### better and optimal approach


better could be producing a hashmap in this, but it would make one problem, that is the remove will still be On , but the insert will def become O(1). 
Now for the **optimal**
we will

- good intuition is how to remove an element without shifting the array. 
- Swap that element with the last element and then pop the last element.


Step-by-step

For insert() - checck in the hashmap, if it exists return false. But if it doesnt exist then push the value to the end of the array and then record the value in the index of hashmap.

for Remove , 
first just acess the entire map by find(val) ! =  map.end() 

then just first put the last value in the place of index map 
and then put the value in the index map to the last place.
then pop that value and return the refernce also.

