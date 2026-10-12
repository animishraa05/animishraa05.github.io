---
title: "GKE Pod Snapshots Cut Model Load Times, and Move the Work to Snapshot Lifecycle Management"
date: 2026-09-28
source: "InfoQ"
url: "https://www.infoq.com/news/2026/09/gke-pod-snapshots-benchmarks/?utm_campaign=infoq_content&utm_source=infoq&utm_medium=feed&utm_term=global"
category: general_cs
tags: [articles, general_cs, "Containers", "Cloud", "Performance", "Kubernetes", "Google Cloud", "Machine Learning", "Architecture", "AI, ML & Data Engineering", "DevOps", "Development", "Architecture & Design", "news"]
score: 68
---

# GKE Pod Snapshots Cut Model Load Times, and Move the Work to Snapshot Lifecycle Management

> Originally published at [InfoQ](https://www.infoq.com/news/2026/09/gke-pod-snapshots-benchmarks/?utm_campaign=infoq_content&utm_source=infoq&utm_medium=feed&utm_term=global) · 2026-09-27

![Hero](images/2026-09-28-img00.jpg)

---

[InfoQ Homepage](</> "InfoQ Homepage") [News](</news> "News") GKE Pod Snapshots Cut Model Load Times, and Move the Work to Snapshot Lifecycle Management

[ Cloud ](</Cloud/> "Cloud")

[QCon San Francisco (Nov 16-20): Deep technical sessions. Peer conversations that change how you think. ](<https://qconsf.com/?utm_source=infoq&utm_medium=referral&utm_campaign=infoqyellowbox_qsf26 >)

#  GKE Pod Snapshots Cut Model Load Times, and Move the Work to Snapshot Lifecycle Management 

Sep 27, 2026 4 min read 

by

  * [](</profile/Steef%7EJan-Wiggers/>) [Steef-Jan Wiggers](</profile/Steef%7EJan-Wiggers/>)

#### Follow us on 

[Youtube232K Followers](<https://bit.ly/4bg6QM8>) [Linkedin26K Followers](<https://bit.ly/44IzAtf>) [InstagramNew](<https://bit.ly/4eYXrtM>) [RSS19K Readers](<https://bit.ly/3RaJalC>) [X57.1k Followers](<https://bit.ly/4pfxivv>) [Facebook21K Likes](<https://bit.ly/3QrGMH2>) [BlueskyNew](<https://bit.ly/4eS8FjG>)

Listen to this article - 0:00

Audio ready to play

Your browser does not support the audio element. 

0:00

0:00

  * [Reading list](</showbookmarks.action>)

Google has [published benchmark results](<https://cloud.google.com/blog/products/containers-kubernetes/gke-pod-snapshots>) for GKE Pod snapshots, reporting startup latency reductions of as much as 89%, with a 70B parameter model loading in 37 seconds and an 8B model in 15 seconds. The feature saves the running state of a workload, including CPU and GPU memory, and restores it on demand. It [reached general availability](<https://docs.cloud.google.com/kubernetes-engine/docs/release-notes-new-features>) in May on clusters running version 1.35.3-gke.1234000 or later.

This is checkpoint and restore, not caching. The snapshot holds everything the application had running: open file descriptors, threads, CPU registers, memory. It also holds the container root filesystem, EmptyDir volumes, and tmpfs mounts. A new replica picks up from there. It never runs the initialization that loads the model, which is where most of the startup time goes on large models.

[gVisor](<https://gvisor.dev/>) is what makes that possible, and it comes with a condition. Pods have to run in GKE Sandbox, since that is where the gVisor runtime lives. Autopilot clusters already have it. Standard clusters need a node pool with gVisor turned on. An agent on each node handles the snapshot lifecycle. A controller on the control plane clears out obsolete snapshots. Cloud Storage holds the data.

Two [custom resources](<https://docs.cloud.google.com/kubernetes-engine/docs/reference/crds/podsnapshot>) do the configuring. PodSnapshotStorageConfig points at the bucket. PodSnapshotPolicy picks Pods by label, sets the trigger to workload or manual, and sets retention with a `lastAccessTimeout` and a cap on snapshots per group.

Google's customer example is Codeway. Its Retake platform had a custom caching layer for compiled artifacts, which got startup down to a minute. Lead DevOps engineer Ahmet Furkan Çomak said Pod snapshots cut that to "just 8 seconds". The team now starts H100 instances for a specific job and shuts them down when it finishes.

Practitioner reaction has centered less on the capture than on what happens afterward. Responding to a [LinkedIn analysis](<https://www.linkedin.com/posts/suresh-rajashekaraiah_googlecloud-gke-kubernetes-share-7508052455197171712-JUmQ>) of the release by Suresh Rajashekaraiah, Mohana Narasimha G., a senior DevOps and MLOps engineer, wrote:

> The restore path is compelling, but I suspect snapshot invalidation will be the harder platform problem than capture itself. Model digest, CUDA/driver version, GPU type/topology, and runtime config all become part of the compatibility key; secrets, DNS, and downstream connections need explicit rehydration after restore. Are you treating snapshots as immutable artifacts with an admission check before scheduling?

Google's [documentation](<https://docs.cloud.google.com/kubernetes-engine/docs/concepts/pod-snapshots>) answers the first half of that. GKE builds a hash from the Pod's essential runtime fields, which it calls the distilled Pod spec, and embeds it in the snapshot; a Pod restoring from it must produce an identical hash. The target node must have an identical machine series and CPU architecture (N2 to N2 or G2 to G2), and the gVisor kernel version and GPU driver version must match those captured. Where no compatible snapshot exists, the Pod starts normally.

A rootfs-only scope relaxes the rules. GKE skips the hash comparison, and because process memory is not restored, snapshots can cross machine families, including to E2.

The rehydration half remains with the application, and the documentation is specific about it. Encryption keys and certificates created before a snapshot must be re-created afterward, since the restored process resumes holding what it held when frozen. Environment variables live in application memory, where gVisor cannot reliably find and replace them, so a workload depending on new values has to read them from a file at `/proc/gvisor/spec_environ`. External connections are terminated on restore, persistent volumes are not checkpointed, and user-added iptables or nftables rules and routes are not restored.

If that reaction is representative, the work moves to managing snapshots rather than turning the feature on. Upgrade a node pool and the gVisor kernel or GPU driver version may change. Existing snapshots no longer match. The Pod then starts normally, per the documented fallback, and nothing errors. The benefit is just gone.

Restore is not instant either, whatever the headline numbers suggest. gVisor's kernel comes back first, usually within a few seconds. The application starts running at that point. Its memory is still loading in the background.

Hardware support is narrower than the framing suggests: whole-pod snapshots do not work on E2 machine types, multi-GPU Pods are supported only on L4 GPUs, and GPU sharing with Multi-Instance GPU is not supported.

The governance question follows from what a snapshot contains. A file in Cloud Storage holds the complete memory of a running workload, which in the agent sandbox case is memory that executed untrusted, model-generated code. Access rests on Workload Identity Federation and IAM bindings for each Pod's service account, which Google notes can take time to propagate.

The agent sandbox case sits on top of this. [GKE Agent Sandbox](<https://www.infoq.com/news/2026/05/gke-agent-sandbox-hypercluster/>) reached general availability in May, with a warm pool Google says allocates up to 300 sandboxes per second per cluster, 90% of them within 200 milliseconds, and it uses Pod snapshots to suspend idle agents rather than hold compute warm. [Agent Substrate](<https://github.com/agent-substrate/substrate>), the open-source project Google introduced at the same time, explores the same suspend and resume multiplexing at higher density, and its repository states it is not ready for production.

Meet Shah, AVP of cloud platform and AI engineering, who [drew the line](<https://www.linkedin.com/posts/meetshah10290_kubernetes-gke-agenticai-ugcPost-7507648409642713088-9CXY>) between them:

> Agent Sandbox GA is the foundation you can plan against for secure execution. Agent Substrate is the density chapter still being written in the open.

Google describes the feature as workload-agnostic, naming Java applications, game servers and legacy monoliths alongside AI inference. The decisions it leaves to teams are which node pools run gVisor, which bucket holds the snapshots and who can read it, how long snapshots persist, and what the workload refreshes when it resumes from a state it did not expect to be frozen in.

## About the Author

[ ](</profile/Steef%7EJan-Wiggers/>)

#### **Steef-Jan Wiggers**

Show moreShow less

####  This content is in the [Cloud](</Cloud/>) topic 

##### Related Topics:

  * [Development](</development/>)
  * [Architecture & Design](</architecture-design/>)
  * [DevOps](</Devops/>)
  * [AI, ML & Data Engineering](</ai-ml-data-eng/>)
  * [Cloud](</Cloud/>)
  * [Containers](</Containers/>)
  * [Performance](</performance/>)
  * [Kubernetes](</Kubernetes/>)
  * [Architecture](</architecture/>)
  * [Google Cloud](</google-cloud/>)
  * [Machine Learning](</MachineLearning/>)

  * #### Related Editorial

  * #### Related Sponsors

    * #####  [ AI's Physical Constraints: How AI Rewired the Data Center ](</url/f/5a42eb51-987e-4407-bcad-141ac7fe5de5/>)

  * #### Related Sponsor

[ ](</url/f/435e8826-b9fc-463a-9fa3-382ba5389da3/>)

**PostgreSQL Built for Time-Series Scale**  
Handle massive time-series data with PostgreSQL, without sacrificing performance. Discover how Tiger Data delivers high-speed ingest, fast queries, and scalable storage. **[Learn More](</url/f/bfd089cf-67a6-48f0-a0df-b45228da036b/>).**

---
*Fetched by article-pipeline · 2026-09-28*
