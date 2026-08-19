_A collection like in mathematics in which all the elements are unique._
three operations can be perfomed mainly
**Insertion** - TO insert new element
**Deletion** - To remove element
**Search** - to search a element

#### Ordered Set ND Unordered Set

**ordered Set**

Set in which elements are in sorted order and organised is the ordered set, in this the insertion and other actions take O(logn) time.
this has following properties

- Built on Red Black tree or Balanced binary tree
- The time for adding ,searching and deleting element in logn.
- Always sorted. whatever we insert in it will get sorted and tree will maintain its structure according to that.

**Unordered Set**
Set in which the element are not sorted and usually used for pure speed.
Properties-

- Built on _Hash Tables_.
- All the operations in it are of O(1)
- Elements are randomly stored on the basis of hash function here.

What to use when

- If only want to check if element exists and need pure speed, there is not need of any order one should be using unordered_set.
- If we need to traverse element in sorted or ranged order, the Set is required.

set<int> s;
s.insert(5);
s.insert(3);
s.insert(5); // error

cout << s.count(1)<< "/n"; // checks whether the 3 exists or not, is basically a search function and only returns 1 or 0

Difference between set and vector is that we can't access the set element using[] operator.

- why so - as the vector is under the hood memory blocks(continous memory) but set underlying is a binary tree which only its left and right indexes so it doesnt know any random position but only the left and right branch.
- so we need an iterator to traverse in loop .
- If using multiset, the change is that there can be more than one element meaning they can be repeated. So to remove one element we should use s.erase(s.find()) otherwise it would delete all of the instance of one element, like if there are three 5s in the multiset, and one needs to erase one, if used s.erase(5) it would erase all of them.
