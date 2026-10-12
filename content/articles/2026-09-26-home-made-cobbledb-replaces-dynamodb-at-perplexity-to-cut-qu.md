---
title: "Home Made CobbleDB Replaces DynamoDB at Perplexity to Cut Query Latency 5x and Reduce Cloud Storage"
date: 2026-09-26
source: "InfoQ"
url: "https://www.infoq.com/news/2026/09/cobbledb-perplexity/?utm_campaign=infoq_content&utm_source=infoq&utm_medium=feed&utm_term=global"
category: general_cs
tags: [articles, general_cs, "Infrastructure Optimisation", "Key-Value Store", "AI, ML & Data Engineering", "news"]
score: 77
---

# Home Made CobbleDB Replaces DynamoDB at Perplexity to Cut Query Latency 5x and Reduce Cloud Storage

> Originally published at [InfoQ](https://www.infoq.com/news/2026/09/cobbledb-perplexity/?utm_campaign=infoq_content&utm_source=infoq&utm_medium=feed&utm_term=global) · 2026-09-25

![Hero](images/2026-09-26-img00.jpg)

---

[InfoQ Homepage](</> "InfoQ Homepage") [News](</news> "News") Home Made CobbleDB Replaces DynamoDB at Perplexity to Cut Query Latency 5x and Reduce Cloud Storage

[ AI, ML & Data Engineering ](</ai-ml-data-eng/> "AI, ML & Data Engineering")

[QCon San Francisco (Nov 16-20): Deep technical sessions. Peer conversations that change how you think. ](<https://qconsf.com/?utm_source=infoq&utm_medium=referral&utm_campaign=infoqyellowbox_qsf26 >)

#  Home Made CobbleDB Replaces DynamoDB at Perplexity to Cut Query Latency 5x and Reduce Cloud Storage 

Sep 25, 2026 3 min read 

by

  * [](</profile/Olimpiu-Pop/>) [Olimpiu Pop](</profile/Olimpiu-Pop/>)

#### Follow us on 

[Youtube232K Followers](<https://bit.ly/4bg6QM8>) [Linkedin26K Followers](<https://bit.ly/44IzAtf>) [InstagramNew](<https://bit.ly/4eYXrtM>) [RSS19K Readers](<https://bit.ly/3RaJalC>) [X57.1k Followers](<https://bit.ly/4pfxivv>) [Facebook21K Likes](<https://bit.ly/3QrGMH2>) [BlueskyNew](<https://bit.ly/4eS8FjG>)

Listen to this article - 0:00

Audio ready to play

Your browser does not support the audio element. 

0:00

0:00

  * [Reading list](</showbookmarks.action>)

Perplexity has transitioned its core search serving tier away from Amazon DynamoDB to CobbleDB, [an internally developed distributed key-value store written in Rust](<https://www.perplexity.ai/hub/blog/cobbledb?utm_source=gemini>). The migration addresses severe latency and cost bottlenecks that arose from serving multi-kilobyte document batches to large language models under heavy query volumes. By decoupling durable document storage from hot-tier retrieval, the engineering team achieved a fivefold reduction in batch-read latencies while lowering overall storage expenses by at least twenty percent.

Artificial intelligence answer engines impose read patterns distinct from conventional document search. Each query dispatched to Perplexity generates between 100 and 120 target page keys, which the retrieval service splits into parallel batches of 10 to 20 keys. Unlike traditional search engines that return brief metadata snippets, retrieval for language models requires extracting full chunked passages and dense vector embeddings, yielding average record payloads of roughly 50 kilobytes.

At production traffic scales exceeding 200,000 requests per second, DynamoDB usage-based pricing became financially unsustainable because AWS meters every byte transferred. Additionally, DynamoDB operates as a black box that conceals internal partition placement, memory caching policies, and replica routing. Engineers could not prevent tail-latency spikes caused by uncached reads, cross-zone networking hops, or lagging replicas. Reprocessing jobs triggered by updated chunking algorithms or newer embedding models also pushed high-volume writes directly into DynamoDB, creating noisy neighbor contention against live user requests.

To resolve these constraints, Perplexity split its storage architecture into three specialized systems: Pillar for durable state management, Lorry for batch aggregation, and CobbleDB for low-latency serving.

_Image Source: Generated with Gemini based on details from the article._

Pillar runs on YTsaurus over high-capacity mechanical drives, maintaining versioned table families for web page metadata, passages, and vector representations. Atomic YTsaurus transactions guarantee that crawl updates, state mutations, and export queues commit together. Lorry acts as a stateless queue consumer that groups Pillar exports into partition-aligned batch files, storing the payloads in Amazon S3 while posting metadata notices to CobbleDB. CobbleDB worker nodes pull and ingest these S3 batches independently, entirely isolating hot serving nodes from the write-heavy crawl pipeline.

CobbleDB operates as a distributed key-value store optimized exclusively for batched lookups. Each partition maintains three replicas distributed across independent compute nodes. The core daemon uses RocksDB as its embedded storage engine, pairing memory-mapped caching with local NVMe solid-state disks.

A stateless query router maps hashed page identifiers to partitions and coordinates read execution. To minimize network overhead, the router routes requests to node replicas located within the same availability zone. If a target replica exhibits elevated response times, the router speculatively hedges the request by issuing a concurrent read to an alternate replica on a different node. Within each node, CobbleDB retrieves keys simultaneously through the RocksDB batched MultiGet interface, eliminating round-trip overhead.
[code] 
    pub struct BatchedPageRequest {
        pub keys: Vec<PageKey>,
        pub zone_affinity: AvailabilityZone,
    }
    
    impl StorageEngine {
       pub fn multi_get_pages(&self, keys: &[PageKey]) -> Result<Vec<Option<PageRecord>>, Error> {
    
          let rocksdb_keys: Vec<&[u8]> = keys.iter().map(|k| k.as_bytes()).collect();
    
          self.rocksdb.batched_multi_get(&rocksdb_keys)
    
       }
    }
[/code]

The database discards standard distributed transaction protocols and synchronous consensus algorithms. Because search serving tolerates slight replication lag, replicas apply updates asynchronously at their own rate, substantially reducing operational overhead.

In live production measurements, CobbleDB reduced median batch-read latency from 31.4 milliseconds to 5.60 milliseconds, p90 latency dropped from 56.7 milliseconds to 9.77 milliseconds, and p99 tail latency decreased from 123 milliseconds to 24.2 milliseconds. Synthetic benchmarks handling payloads up to 100 kilobytes confirmed consistent throughput up to 500,000 requests per second.

_Image Source: Perplexity Blog_

The architecture incurs non-trivial trade-offs. Replacing a fully managed cloud database transfers node lifecycle management, backup verification, and partition rebalancing entirely onto internal site reliability engineers. Applications must also withstand eventual consistency, as replicas ingest batched files at different intervals.

[Aravind Srinivas](<https://linkedin.com/in/aravind-srinivas-16051987>), the CEO of the company, noted that the 40,000 lines of Rust comprising CobbleDB were built in two months by two systems engineers paired with an autonomous swarm of AI coding agents that handled integration testing, build monitoring, and operational runbooks. Perplexity has indicated plans to open-source the CobbleDB codebase in an upcoming release.

## About the Author

[ ](</profile/Olimpiu-Pop/>)

#### **Olimpiu Pop**

Show moreShow less

####  This content is in the [AI, ML & Data Engineering](</ai-ml-data-eng/>) topic 

##### Related Topics:

  * [AI, ML & Data Engineering](</ai-ml-data-eng/>)
  * [Infrastructure Optimisation](</infrastructure-optimisation/>)
  * [Key-Value Store](</Key-Value_Store/>)

  * #### Related Editorial

  * #### Related Sponsors

  * #### Related Sponsor

[ ](</url/f/98c0b56f-e998-4727-807e-17ca31461cfd/>)

    * October 8, 2026, 12 PM EDT

##### [When AI Accelerates Development, Can Your CI Pipeline Keep Up?](</url/f/bdb0659c-427a-4fb8-9323-7d712f1bee96/>)

[Presented by: Eric Metaj - Product Marketing Manager, Software Delivery at Datadog, and Rohin Chandra - Product Manager, CI/CD Optimization at Datadog](</url/f/a1a45fe2-dc75-4313-a04e-13b03bcd9f21/>)

---
*Fetched by article-pipeline · 2026-09-26*
