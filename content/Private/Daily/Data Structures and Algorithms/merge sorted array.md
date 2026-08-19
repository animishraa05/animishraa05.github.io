_two integer array given in sorted non decreasing order. merge both array into one as a non decreasing array._

**solution**

- remember this will be needing two pointers approach (from back.)
- size(nums1) = m+n
- size(nums2) = n
  gotta merge both.-

**brute force** -
waht is the most straighforward solution. it is to put all the numbers in 2nd array to 1st array.means copy all number of 2nd to the end of 1st.

- append nums 2 in all the empty spots of nums1.
- just sort them after that.
- remember the traversal would be through num2, the contents of num1 which are empty will be accquired by num2.
  **pseudocode**

for ( int i =0; i ￼￼
< n; I++)
nums1[i+m]= nums2[i];
}
nums1.sort(nums1.begin(), nums1.end());

Tc- o(m+n)log(m+n)
sc- o(log(m+n))

**optimal**
gotta think about this as for the extra space, so we will be using two pointer approach.
we will use two pointer from back qki using it in front will make the things difficult if we use it from front.
as we will have to move the pointers continously, instead just do it from back and do the inplace ordering.

**thinking**

1. First what we have to do is put all the content of nums1 and nums2 is just compare them using i and j as pointer.
   (put the i = m-1 or last valid index and num2 as n-1) and put them all in inplace at nums1 using k of size (m+n-1)

pseudocode
int i = m-1;
int j = n-1;
int k = m+n-1;
while(j>=0){
if (i > = 0 && nums1[i] > nums2[j]){
nums1[k]= nums1[i];
i--; // after pushing go to next index
}
else {
nums1[k]=nums2[j] // go to next index
j--;}
k--;
// go to next indexx from back
}
why loop j and not i as j is used for nums2 and if the nums1 is used as the starting loop or i then if the values are bigger (5,6,4,,0,0,0) and nums2 (1,2,3)
then after the iteration nums1 will go to -1 in the start only

sc- o(1)

completed
