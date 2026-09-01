

* Maximum depth of a binary tree
        1
       / \
      2   3
     /
    4

The Depth of this tree is 3.
It starts from 1 and level by level becomes 3.

Like IF you look at 1,

        1
       / \
      2   3

If I know the Height/Depth(2) and 3
I automatically Know it for 1 

Or I can say Height(1) = 1+ max(height(2), height(3)).

so The basic height one is 

solve(root)
if ( root == nullptr){
return 0;
}
return 1 + max(solve(root->left), solve(root->right));

*this is also bottom up recursion*
MEANS TREE RECURSION GOES DOWN AND ANSWER COMES UP.

int main(){
Treenode* root = new node (6);
treenode* root->right = new node(4);

cout<<"maximum depth of tree"<<height(root)<<endl;
return 0;
}
Struct Treenode{
int data;
Treenode* left = nullptr;
Treenode* right = nullptr;

treenode(int x) : val(x) {}
};
// this is how you make a tree and initialise a tree and make its nodes.







**Count How many Nodes Exist**
        1
       / \
      2   3
     /
    4

answer = 4

So In this also the recursion stack is same but the way of using it changes.

To count at each node, 
How many are at its left, at its righta nd the current count itself

Meaning *Myself + count of left + count of right*


void Count(root){
if ( root == nullptr)
return 0;
return 1 + count(root->left) + count(root->right);
}

---
**Sum of all nodes**

        1
       / \
      2   3
     /
    4

answer = 10

Now unlike before we need to also add the current value, 
So Sum = Root->val + left + right
Tc- O(n). Sc- O(h)

---
**Search For a Value in tree**

        1
       / \
      2   3
     / \
    4   5

Search of 5, answer yes or no.
BOOl will be used


searchtree(int target, Treenode* root){
if (root == nullptr)
return false;
if ( root->val == target)
return true;
return search(root->left) || search(root-> right);
}

---
**Same tree**

are they the same tree
Tree A:              Tree B:

      1                   1
     / \                 / \
    2   3               2   3

Answer - true;

same means same structure and same values

Means- current valuue same and right, left subtree should be same as well 

return p.val == q.val && fun1(p->left,q->left) && fun(p->right,q->right);

so same(Treenode* p, Treenode* q){
// both are null
if (q == null && p == null){
return true;
}
else if (q == null || p == null){
return false;
}
else if ( p->val != q->val){
return false;
}

return same(p->left, q->left) && (p->right, q->right);
}

---
**Invert Binary tree**

        1
       / \
      2   3
     / \
    4   5 

convert this into  
        1
       / \
      3   2
         / \
        5   4

Change here is instead of doing some calculation at each node, we will invert it and then process the left and right node.

so, left and right node will also become inversed. 

at any node 
        X
       / \
      L   R 
  the change becomes 
        X
       / \
      R   L

So the basic process is swap(root->left, root->right)
and then invert the left node, invert the right node.


--- 
**Level Order Traversal or breadth firtst search** 

        1
       / \
      2   3
     / \   \
    4   5   6 

Print level by level 
1
2 3
4 5 6

usually in vector<int>
[123]
[456]
Like this.

*pseudocode*

- func levelorder(root)
 if root is null
 return empty

create queue
push root

while Queue is not empty:
size = number of nodes currently in queue
create currentlevel

Repeat size times this:
add node.value to currentlevel
push node.left if exists
push node.right if exists

add currentlevel to result

return currentlevel

---
**Minimum Depth of a tree**

Three basic cases are there, 
1. when the left and right side both are null, then we return 1.
2. when the left is null. we do 1+right()
3. when the right is null. We do 1+ left()
4. when nothing, then do 1 + min(left, right)

---

**Symmetric tree**
          1
        /   \
       2     2
      / \   / \
     3   4 4   3

this tree is symmetric, left->right == right->left

We need a helper function in this, basically make a helper function having a right node and a left node, two self referential pointer in the main function.
inside this helper, take these cases
- if The right node is null or left node is null(any one of those), it will be false.
- If the right and left node, both of them are null then its true
- if the value of both doesnt match, the current right and left, its false;
- If none of that, just call the mirror recursively on the left->right, right->left && right->right, left->left.
┌──────────────────────────┬────────┐
│ left / right             │ result │
├──────────────────────────┼────────┤
│ NULL + NULL              │ true   │
│ NULL + node              │ false  │
│ node + NULL              │ false  │
│ different values         │ false  │
│ same values              │ recurse│
└──────────────────────────┴────────┘
---


*Diameter of the Tree*

        5
       / \
      4   8
     /   / \
    11  13  4

Given the `root` of a binary tree and an integer `targetSum`, return `true` if the tree has a **root-to-leaf** path such that adding up all the values along the path equals `targetSum`.








