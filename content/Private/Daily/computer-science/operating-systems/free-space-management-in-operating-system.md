---
title: "Free Space Management in Operating System"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# Free Space Management in Operating System
Free space management involves managing the available storage space on the hard disk or other secondary storage devices. To reuse the space released from deleting the files, a free space list is maintained. The free space list can be implemented mainly as:

![Free_space_management](images_free_space_management.webp)

- Bitmap or Bit vector
- Linked List
- Boundary Tags
- Free List

## Bitmap or Bit vector

In this approach, A Bitmap or Bit Vector is series or collection of bits where each bit corresponds to a disk block. The bit can take two values 0 and 1:

- 0 indicates that the block is free and 1 indicates an allocated block.
- The given instance of disk blocks on the disk in Figure 1 can be represented by a bitmap of 16 bits as: 1111000111111001. Bitmap

![Bitmap](images_bitmap.webp)

Advantages:

- Simple to understand.
- Finding the first free block is efficient. It requires scanning the words (a group of 8 bits) in a bitmap for a non-zero word. (A 0-valued word has all bits 0). The first free block is then found by scanning for the first 1 bit in the non-zero word.

Disadvantages:

- For finding a free block, Operating System needs to iterate all the blocks which is time consuming.
- The efficiency of this method reduces as the disk size increases.

## Linked List

In this approach, Free blocks are linked together in a list. Each free block stores the address of the next free block. The list is maintained dynamically as blocks are allocated and freed.

![Free_List](images_free_list.webp)

> Note: The free space list head points to Block 5 which points to Block 6, the next free block and so on. The last free block would contain a null pointer indicating the end of free list.

Note: The free space list head points to Block 5 which points to Block 6, the next free block and so on. The last free block would contain a null pointer indicating the end of free list.

Advantages:

- The total available space is used efficiently using this method.
- Dynamic allocation in Linked List is easy, thus can add the space as per the requirement dynamically.

Disadvantages:

- When the size of Linked List increases, the headache of miniating pointers is also increases.
- This method is not efficient during iteration of each block of memory.
- I/O IS required for free space list traversal.

## Boundary Tags

In this approach, Each block contains a boundary tag indicating its size and whether it is free or occupied. Adjacent free blocks are merged during deallocation to reduce fragmentation.

Advantages:

- Useful in memory management systems.
- Simplifies coalescing of adjacent free blocks.

Disadvantages:

- Slight overhead in storing tag information.
- More complex than bitmap or linked list.

## Free List

In this approach, The free blocks are maintained in a list (array or linked list). Each entry in the free list points directly to a free block on disk.

![disk_block](images_disk_block.webp)

Advantages:

- Fast allocation as free blocks are known upfront.
- Easy to traverse and maintain.

Disadvantages:

- Extra memory needed to store the list.
- May suffer from fragmentation over time.