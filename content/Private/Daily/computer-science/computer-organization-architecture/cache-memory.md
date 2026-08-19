---
title: "Cache Memory"
topic: "computer-organization-architecture"
scraped_date: 2026-03-29
---

# Cache Memory
Cache memory is a small, fast storage space within a computer. It holds duplicates of data from commonly accessed locations in the main memory. The CPU contains several separate caches that store both instructions and data.

![cache](images_cache.webp)

- The key function of cache memory is to reduce the average time needed to retrieve data from the main memory.
- Cache's effectiveness relies on the principle of locality of reference, where recently accessed items or nearby items are more likely to be accessed again.
- Cache memory stores data close to the CPU, which helps speed up processing. It's much faster than the main memory (RAM). When the CPU needs data, it checks the cache first. If the data is there, it’s quickly accessed. If not, the CPU gets it from the slower main memory.

## Key Features of Cache Memory

Cache memory acts as a high-speed bridge between the CPU and RAM, storing frequently used data close to the CPU. This proximity allows the CPU to access data more quickly, reducing the need to fetch information from slower main memory. By minimizing wait times, cache memory significantly enhances CPU efficiency and overall system performance.

1. Speed: Faster than the main memory (RAM), which helps the CPU retrieve data more quickly.
2. Proximity: Located very close to the CPU, often on the CPU chip itself, reducing data access time.
3. Function: Temporarily holds data and instructions that the CPU is likely to use again soon, minimizing the need to access the slower main memory.

## Working of Cache Memory

To understand the working of the cache, we must understand a few points:

1. Fast but Small: Cache is way faster than RAM but can only hold a small amount of data because it’s limited in size.
2. Checking the Cache First: When the CPU needs data, it looks in the cache first because it’s so quick. If the data is there (called a cache hit), the CPU grabs it and gets to work.
3. Data Isn’t in Cache: If the data isn’t in the cache (called a cache miss), the CPU looks in the slower RAM, gets the data, and copies it to the cache for next time.
4. Speeding Things Up: By keeping frequently used data in the cache, the CPU spends less time waiting for data from RAM. This makes your computer run faster.

## Types of Cache Memory

1. L1 or Level 1 Cache: It is the first level of cache memory that is present inside the processor. It is present in a small amount inside every core of the processor separately. The size of this memory ranges from 2KB to 64 KB.
2. L2 or Level 2 Cache: It is the second level of cache memory that may present inside or outside the CPU. If not present inside the core, It can be shared between two cores depending upon the architecture and is connected to a processor with the high-speed bus. The size of memory ranges from 256 KB to 512 KB.
3. L3 or Level 3 Cache: It is the third level of cache memory that is present outside the CPU and is shared by all the cores of the CPU. Some high processors may have this cache. This cache is used to increase the performance of the L2 and L1 cache. The size of this memory ranges from 1 MB to 8MB.

## Cache Hit and Cache Miss

Cache Hit: When the CPU finds the required data in the cache memory, allowing for quick access. On searching in the cache if data is found, a cache hit has occurred.

Cache Miss: When the required data is not found in the cache, forcing the CPU to retrieve it from the slower main memory. On searching in the cache if data is not found, a cache miss has occurred

> Point to Know:Performance of cache is measured by the number of cache hits to the number of searches. This parameter of measuring performance is known as the Hit Ratio.Hit ratio=(Number of cache hits)/(Number of searches).

Point to Know:

- Performance of cache is measured by the number of cache hits to the number of searches. This parameter of measuring performance is known as the Hit Ratio.
- Hit ratio=(Number of cache hits)/(Number of searches).

## Cache vs RAM

Although Cache and RAM both are used to increase the performance of the system there exists a lot of differences in which they operate to increase the efficiency of the system.

| Cache Memory | RAM (Random Access Memory) |
| --- | --- |
| Very close to CPU | Close to CPU, connected via memory bus |
| Stores frequently accessed data for faster CPU access | Main working memory for currently running programs |
| Extremely fast (nanoseconds) | Fast, but slower than cache (tens of nanoseconds) |
| Small (KB to few MB) | Large (GB to TB) |
| SRAM (faster, more expensive) | DRAM (slower, cost-effective) |
| Multi-level (L1, L2, L3) | Single level |
| Acts as a buffer between CPU and RAM | Stores data/instructions currently being processed |
| High | Lower |
| Limited | Larger, supports multiple applications |