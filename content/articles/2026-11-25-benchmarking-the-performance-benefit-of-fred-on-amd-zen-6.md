---
title: "Benchmarking The Performance Benefit Of FRED On AMD Zen 6"
date: 2026-11-25
source: "Phoronix"
url: "https://www.phoronix.com/news/AMD-Zen-6-FRED-Benefits"
category: security_perf
tags: [articles, security_perf, "security_perf"]
score: 74
---

# Benchmarking The Performance Benefit Of FRED On AMD Zen 6

> Originally published at [Phoronix](https://www.phoronix.com/news/AMD-Zen-6-FRED-Benefits) · 2026-11-25

---

# Benchmarking The Performance Benefit Of FRED On AMD Zen 6

Written by [Michael Larabel](<https://www.michaellarabel.com/>) in [AMD](</linux/AMD>) on 24 November 2026 at 08:55 PM EST. [Add A Comment](</forums/node/1671812>)

With the new [EPYC 9006](<https://www.phoronix.com/search/EPYC+9006>) SP7 Venice processors now shipping, one of the curious follow-up benchmarks I have been wanting to pursue is around quantifying the performance impact of [Flexible Return and Event Delivery](<https://www.phoronix.com/search/Flexible+Return+and+Event+Delivery>) "FRED". After all, [FRED showed very nice gains for Intel Panther Lake](<https://www.phoronix.com/review/intel-fred-panther-lake>) for first featuring FRED. Since then the Linux kernel has enabled FRED usage by default with capable CPUs, so all the EPYC 9006 benchmarks on Phoronix have already been with FRED, so here are some numbers when going ahead and forcing FRED off in the Linux kernel.   
  
FRED is a far more efficient and modern way for dealing with interrupts, exceptions, and system calls over the legacy IDT approach. FRED will be supported by all AMD Zen 6 processors while for the benchmarking with released hardware leaves us with the EPYC 9006 SP7 processors for the moment.   

[](<//www.phoronix.com/image-viewer.php?id=2026&image=amd_zen6_fred_1_lrg>)

  

[](<//www.phoronix.com/image-viewer.php?id=2026&image=amd_zen6_fred_2_lrg>)

  
I was curious about the performance impact of FRED, so toggling the Linux kernel support I ran some benchmarks to show the impact of FRED disabled on AMD Zen 6. [FRED is enabled by default with Linux 7.1 and newer](<https://www.phoronix.com/news/Intel-FRED-Enabling-Linux-7.1>) as an important consideration.   

  
When testing with the [AMD EPYC 9686F](<https://www.phoronix.com/review/amd-epyc-9686f>) 2P setup on Ubuntu 26.10 and running a Linux 7.4 Git kernel build, I ran some quick benchmarks given time constraints:   

  

  

  

  

  

  

  

  
In I/O whether networking or local storage there were up to a few percent gains on AMD 6th Gen EPYC that appear to be attributed to the presence of FRED with Zen 6 and its usage being [enabled by default on Linux 7.1 and newer](<https://www.phoronix.com/news/Linux-7.1-Best-Features>). It's just one of the contributing factors to the standout performance for EPYC 9006 in addition to [MRDIMM-12800 memory support](<https://www.phoronix.com/review/mrdimm-8800-12800-amd-epyc>), [solid SMT performance](<https://www.phoronix.com/review/amd-epyc-zen6-smt>), and other architectural improvements over Zen 5 or even going back in looking at [Zen 6 performance against Zen 1 servers](<https://www.phoronix.com/review/amd-epyc-9006-7601>). It's been a wild ride.

[Add A Comment](</forums/node/1671812>)

---
*Fetched by article-pipeline · 2026-11-25*
