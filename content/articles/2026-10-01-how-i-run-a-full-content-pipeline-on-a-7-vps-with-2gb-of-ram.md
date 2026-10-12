---
title: "How I Run a Full Content Pipeline on a $7 VPS With 2GB of RAM (And the 3am Crash That Taught Me Why)"
date: 2026-10-01
source: "Dev.to"
url: "https://dev.to/revanzart/how-i-run-a-full-content-pipeline-on-a-7-vps-with-2gb-of-ram-and-the-3am-crash-that-taught-me-why-4cho"
category: general_cs
tags: [articles, general_cs, "devops", "python", "automation", "sideprojects"]
score: 78
---

# How I Run a Full Content Pipeline on a $7 VPS With 2GB of RAM (And the 3am Crash That Taught Me Why)

> Originally published at [Dev.to](https://dev.to/revanzart/how-i-run-a-full-content-pipeline-on-a-7-vps-with-2gb-of-ram-and-the-3am-crash-that-taught-me-why-4cho) · 2026-10-01

![Hero](images/2026-10-01-img00.webp)

---

The cron job ran at 3am and the server went dark.

I woke up to a dead SSH session, a swap file that had been chewed through, and a pipeline that had produced nothing. The task was simple on paper: generate a batch of images, vectorise them, package them, upload them. On my laptop it took a few minutes. On a 1 vCPU box with 2GB of RAM it killed the machine.

I had written code that worked. I had not written code that fit.

##  Why small servers die 

The mistake was concurrency. I processed everything at once, because that is the default when you write a loop. Ten images in flight means ten copies of the model, ten decoded bitmaps, ten sets of intermediate buffers. On a big machine that is a rounding error. On 2GB it is the entire budget, and the kernel reaches for swap, and swap on a cheap VPS is a slow death.

The fix was not a bigger server. It was a smaller pipeline.

##  The rules I now follow 

**One process at a time.** The pipeline runs a single job, finishes it, frees the memory, and starts the next. It is slower in wall-clock terms and dramatically more reliable. For a background job nobody is watching, reliability is the only metric that matters.

**Measure peak, not average.** Average memory usage lies. A step that idles at 40MB and spikes to 900MB for two seconds will still kill you. I now log peak RSS per step, so I know exactly which stage is the dangerous one before it runs at 3am.

**Cap the inputs.** Most pipelines do not need to load a full-resolution source to produce a small output. I resize before the expensive step, not after. The model sees what it needs and nothing more.

**Garbage collect on purpose.** In Python, the reference counting is not always fast enough for big binary objects. Calling `gc.collect()` between heavy steps costs milliseconds and gives back hundreds of megabytes.

##  What the numbers looked like 

After the rewrite, generating a full batch of images peaked at 29MB of RSS. Twenty-nine. The crash was never about the work being too big. It was about doing too much of it at the same time.

That batch now runs unattended. It has run dozens of times without me touching it, on the same cheap box, because it respects the ceiling it is running under.

##  The broader point 

There is a temptation to treat infrastructure as someone else's problem, to assume that if the code is correct the server will cope. The server does not care about correctness. It cares about memory, and it will tell you exactly where your assumptions were wrong, usually at the worst possible hour.

If you are building automation on cheap hardware, budget memory the way you budget money. Know your peak. Do one thing at a time. Resize early. Free explicitly.

The whole system I run, generation, vectorising, packaging, and publishing, fits comfortably inside a tier that costs less than a coffee a week. Not because it is clever, but because it is disciplined about what it holds in memory at once.

If you want to see what the pipeline produces, there is a free set of kawaii stickers (transparent PNG, commercial use) here:

[Free cute sticker sampler](<https://revanzart.gumroad.com/l/free-cute-sticker-sampler>)

For further actions, you may consider blocking this person and/or [reporting abuse](</report-abuse>)

---
*Fetched by article-pipeline · 2026-10-01*
