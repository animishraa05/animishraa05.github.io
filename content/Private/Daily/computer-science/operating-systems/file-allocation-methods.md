---
title: "File Allocation Methods"
topic: "operating-systems"
tags: [operating-systems, gate-cse, os, operating-systems, gate-cse, os, operating-systems, gate-cse, os]
scraped_date: [[2026-03-29]]
---

# File Allocation Methods
The allocation methods define how the files are stored in the disk blocks. There are three main disk space or file allocation methods.

- Contiguous Allocation
- Linked Allocation
- Indexed Allocation

The main idea behind these methods is to provide Efficient disk space utilization & Fast access to the file blocks.

## Contiguous Allocation

In this scheme, each file occupies a contiguous set of blocks on the disk. This means that given the starting block address and the length of the file (in terms of blocks required), we can determine the blocks occupied by the file. The directory entry for a file with contiguous allocation contains:

- Address of starting block
- Length of the allocated portion.
- Example: If a file requires n blocks and is given a block b as the starting location, then the blocks assigned to the file will be:

> b, b+1, b+2,......b+n-1.

b, b+1, b+2,......b+n-1.

![Continuous-allocation](images_continuous-allocation.webp)

Advantages

- Both the Sequential and Direct Accesses are supported by this. For direct access, the address of the kth block of the file which starts at block b can easily be obtained as (b+k).
- This is extremely fast since the number of seeks are minimal because of contiguous allocation of file blocks.

Disadvantages

- This method suffers from both internal and external fragmentation. This makes it inefficient in terms of memory utilization.
- Increasing file size is difficult because it depends on the availability of contiguous memory at a particular instance.

## Linked Allocation

In this scheme, each file is a linked list of disk blocks which need not be contiguous. Here,

- The disk blocks can be scattered anywhere on the disk. The directory entry contains a pointer to the starting and the ending file block.
- Each block contains a pointer to the next block occupied by the file.
- Example: The file 'jeep' in following image shows how the blocks are randomly distributed. The last block (25) contains -1 indicating a null pointer and does not point to any other block.

![Linked-Allocation](images_linked-allocation.webp)

Advantages

- This is very flexible in terms of file size. File size can be increased easily since the system does not have to look for a contiguous chunk of memory.
- This method does not suffer from external fragmentation. This makes it relatively better in terms of memory utilization.

Disadvantages

- Because the file blocks are distributed randomly on the disk, a large number of seeks are needed to access every block individually. This makes linked allocation slower.
- It does not support random or direct access. We can not directly access the blocks of a file. A block k of a file can be accessed by traversing k blocks sequentially (sequential access ) from the starting block of the file via block pointers.
- Pointers required in the linked allocation incur some extra overhead.

## Indexed Allocation

In this scheme, a special block known as the [[index|Index]] block contains the pointers to all the blocks occupied by a file. Here,

- Each file has its own [[index]] block.
- The ith entry in the [[index]] block contains the disk address of the ith file block.
- The directory entry contains the address of the [[index]] block as shown in the image.

![Indexed-Allocation](images_indexed-allocation.webp)

Advantages

- This supports direct access to the blocks occupied by the file and therefore provides fast access to the file blocks.
- It overcomes the problem of external fragmentation.

Disadvantages

- The pointer overhead for indexed allocation is greater than linked allocation.
- For very small files, say files that expand only 2-3 blocks, the indexed allocation would keep one entire block ([[index]] block) for the pointers which is inefficient in terms of memory utilization. However, in linked allocation we lose the space of only 1 pointer per block.

## Indexing Schemes for Large Files

When a file is very large, a single [[index]] block may not have enough space to hold all the pointers to the data blocks. To manage this, the following indexing mechanisms are used:

### 1. Linked Scheme

- In this approach, multiple [[index]] blocks are linked together.
- Each [[index]] block contains some pointers to disk blocks and a pointer to the next [[index]] block.
- The chain continues until all the pointers are covered.

### 2. Multilevel Index

- Instead of a single large [[index]] block, we use a hierarchy of [[index]] blocks.
- The first-level [[index]] block points to second-level [[index]] blocks and those second-level blocks contain pointers to the actual data blocks.
- Can be extended to three or more levels as required by file size.

### 3. Combined Scheme (Inode Structure)

A special block called the Inode (Information Node) stores File metadata (name, size, permissions, timestamps) & Block addresses (pointers).

The Inode typically contains:

> 1. Direct Pointers: Point directly to data blocks (e.g., first 10 pointers).2. Single Indirect Pointer: Points to a block that holds further block addresses.3. Double Indirect Pointer: Points to a block that contains pointers to other indirect blocks, which in turn point to data blocks.4. Triple Indirect Pointer: Adds another layer of indirection for extremely large files.

1. Direct Pointers: Point directly to data blocks (e.g., first 10 pointers).2. Single Indirect Pointer: Points to a block that holds further block addresses.3. Double Indirect Pointer: Points to a block that contains pointers to other indirect blocks, which in turn point to data blocks.4. Triple Indirect Pointer: Adds another layer of indirection for extremely large files.

![Combined_scheme](images_combined_scheme.webp)

Why Combined Scheme Is Preferred:

- Combines direct access for small files (faster).
- Allows efficient scalability for large files.
- Widely used in modern filesystems like ext2, ext3, ext4 (Linux).