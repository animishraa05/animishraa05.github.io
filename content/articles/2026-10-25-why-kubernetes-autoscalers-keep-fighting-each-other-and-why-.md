---
title: "Why Kubernetes autoscalers keep fighting each other (and why the solution must be autonomous)"
date: 2026-10-25
source: "The New Stack"
url: "https://thenewstack.io/why-kubernetes-autoscalers-fight/"
category: general_cs
tags: [articles, general_cs, "Cloud Native Ecosystem", "Kubernetes", "Platform Engineering", "sponsor-cncf", "sponsored-post-contributed"]
score: 68
---

# Why Kubernetes autoscalers keep fighting each other (and why the solution must be autonomous)

> Originally published at [The New Stack](https://thenewstack.io/why-kubernetes-autoscalers-fight/) · 2026-10-24

![Hero](images/2026-10-25-img00.jpg)

---

[ ](</>)

NEW! Try Stackie AI 

ARCHITECTURE 

[ Cloud Native Ecosystem ](<https://thenewstack.io/cloud-native/>) [ Containers ](<https://thenewstack.io/containers/>) [ Databases ](<https://thenewstack.io/databases/>) [ Edge Computing ](<https://thenewstack.io/edge-computing/>) [ Infrastructure as Code ](<https://thenewstack.io/infrastructure-as-code/>) [ Linux ](<https://thenewstack.io/linux/>) [ Microservices ](<https://thenewstack.io/microservices/>) [ Open Source ](<https://thenewstack.io/open-source/>) [ Networking ](<https://thenewstack.io/networking/>) [ Storage ](<https://thenewstack.io/storage/>)

ENGINEERING 

[ AI ](<https://thenewstack.io/ai/>) [ AI Engineering ](<https://thenewstack.io/ai-engineering/>) [ API Management ](<https://thenewstack.io/api-management/>) [ Backend development ](<https://thenewstack.io/backend-development/>) [ Data ](<https://thenewstack.io/data/>) [ Frontend Development ](<https://thenewstack.io/frontend-development/>) [ Large Language Models ](<https://thenewstack.io/llm/>) [ Security ](<https://thenewstack.io/security/>) [ Software Development ](<https://thenewstack.io/software-development/>) [ WebAssembly ](<https://thenewstack.io/webassembly/>)

OPERATIONS 

[ AI Operations ](<https://thenewstack.io/ai-operations/>) [ CI/CD ](<https://thenewstack.io/ci-cd/>) [ Cloud Services ](<https://thenewstack.io/cloud-services/>) [ DevOps ](<https://thenewstack.io/devops/>) [ Kubernetes ](<https://thenewstack.io/kubernetes/>) [ Observability ](<https://thenewstack.io/observability/>) [ Operations ](<https://thenewstack.io/operations/>) [ Platform Engineering ](<https://thenewstack.io/platform-engineering/>)

PROGRAMMING 

[ C++ ](<https://thenewstack.io/c/>) [ Developer tools ](<https://thenewstack.io/developer-tools/>) [ Go ](<https://thenewstack.io/go/>) [ Java ](<https://thenewstack.io/java/>) [ JavaScript ](<https://thenewstack.io/javascript/>) [ Programming Languages ](<https://thenewstack.io/programming-languages/>) [ Python ](<https://thenewstack.io/python/>) [ Rust ](<https://thenewstack.io/rust/>) [ TypeScript ](<https://thenewstack.io/typescript/>)

CHANNELS 

[ Podcasts ](<https://thenewstack.io/podcasts/>) [ Ebooks ](<https://thenewstack.io/ebooks/>) [ Events ](<https://thenewstack.io/events/>) [ Webinars ](<https://thenewstack.io/webinars/>) [ Newsletter ](<https://thenewstack.io/newsletter/>) [ TNS RSS Feeds ](</rss-feeds/>)

THE NEW STACK 

[ About / Contact ](<https://thenewstack.io/about-and-contact-info/>) [ Sponsors ](<https://thenewstack.io/sponsors/>) [ Advertise With Us ](<https://thenewstack.io/sponsorship/>) [ Contributions ](<https://thenewstack.io/contributions/>)

[PODCASTS](</podcasts/>) [EBOOKS](</ebooks/>) [EVENTS](</events/>) [WEBINARS](</webinars/>) [NEWSLETTER](</newsletter/>) [CONTRIBUTE](</contributions/>)

ARCHITECTURE  ENGINEERING  OPERATIONS  PROGRAMMING 

[ Cloud Native Ecosystem ](<https://thenewstack.io/cloud-native/>) [ Containers ](<https://thenewstack.io/containers/>) [ Databases ](<https://thenewstack.io/databases/>) [ Edge Computing ](<https://thenewstack.io/edge-computing/>) [ Infrastructure as Code ](<https://thenewstack.io/infrastructure-as-code/>) [ Linux ](<https://thenewstack.io/linux/>) [ Microservices ](<https://thenewstack.io/microservices/>) [ Open Source ](<https://thenewstack.io/open-source/>) [ Networking ](<https://thenewstack.io/networking/>) [ Storage ](<https://thenewstack.io/storage/>)

[ Why Kubernetes autoscalers keep fighting each other (and why the solution must be autonomous)  Oct 24th 2026 9:00am, by  Nikhil Kurup  ](</why-kubernetes-autoscalers-fight/>)

[ The distroless security gap: Why bottom-up containers are the next evolution in OCI images  Oct 19th 2026 9:00am, by  Lily Rivers-Klee  ](</distroless-container-security-gap/>)

[ Scale isn't one number: three ways a Kubernetes control plane runs out of room  Oct 18th 2026 10:00am, by  Joe Betz and Walter Fender  ](</scaling-kubernetes-control-planes/>)

[ What Kubernetes’ "monolith" lesson means for AI agent harnesses  Oct 2nd 2026 12:31pm, by  Bill Doerrfeld  ](</kubecon-agent-harness-koordinator/>)

[ OpenTelemetry and Prometheus are getting along. What’s still missing?  Sep 25th 2026 12:56pm, by  Bill Doerrfeld  ](</opentelemetry-prometheus-observability-interoperability/>)

[ The distroless security gap: Why bottom-up containers are the next evolution in OCI images  Oct 19th 2026 9:00am, by  Lily Rivers-Klee  ](</distroless-container-security-gap/>)

[ Amazon ECS now auto-repairs failing GPUs and instances. Here's why it matters for SREs.  Oct 9th 2026 9:00am, by  Anirudh Aithal  ](</amazon-ecs-auto-repair/>)

[ K3s vs. K8s: When lightweight Kubernetes distros win (and when they don't)  Oct 2nd 2026 9:00am, by  Peter Smails  ](</k3s-vs-k8s-comparison/>)

[ How buildpacks help enterprises finally operate container security controls at scale  Sep 18th 2026 10:00am, by  Catherine Edelveis  ](</buildpacks-container-security-scale/>)

[ Your container runs. Everything around it shouldn't be your problem.  Aug 29th 2026 11:00am, by  Satej Sawant  ](</amazon-ecs-express-mode/>)

[ Your database decision could come back to haunt you  Oct 14th 2026 11:00am, by  Meredith Shubel  ](</ai-prototypes-database-replatforming/>)

[ You can outgrow vanilla Postgres without abandoning Postgres  Oct 8th 2026 12:23pm, by  Kimberly Fessel  ](</postgres-at-scale-why-it-struggles/>)

[ Redis by proxy: Percona targets the last major hurdle to Valkey adoption  Oct 8th 2026 2:54am, by  Paul Sawers  ](</valkey-proxy-redis-percona/>)

[ Use Graph RAG when relationships are part of the evidence  Oct 1st 2026 9:30am, by  Jeremy Daly  ](</when-to-use-graph-rag/>)

[ Your AI agent aced the demo. Your data may still derail it.  Sep 30th 2026 11:00am, by  Kimberly Fessel  ](</ai-agents-production-data/>)

[ Anthropic’s red team ran AI on 15 cheap TV boxes. Then the math got unsettling.  Oct 13th 2026 12:40pm, by  Amanda Caswell  ](</self-replicating-ai-worms/>)

[ Kubernetes on cgroup v1 is dead. Here’s what comes next.  Oct 9th 2026 4:15pm, by  Bill Doerrfeld  ](</kubernetes-node-swap-ai/>)

[ Your phone's vector index might be bigger than the AI model running it  Oct 6th 2026 2:53pm, by  Amanda Caswell  ](</google-embeddinggemma-multimodal-search/>)

[ K3s vs. K8s: When lightweight Kubernetes distros win (and when they don't)  Oct 2nd 2026 9:00am, by  Peter Smails  ](</k3s-vs-k8s-comparison/>)

[ SpaceX designed an orbital Vera Rubin. Radiation comes next.  Aug 31st 2026 2:55pm, by  Steven J. Vaughan-Nichols  ](</spacex-nvidia-orbital-ai/>)

[ The API tax: Why AI agents stall without infrastructure context  Oct 8th 2026 9:30am, by  Oleg Danilyuk  ](</autonomous-cloud-context-layer/>)

[ Shai-Hulud: Whoever controls your package registry controls your pipeline  Aug 31st 2026 12:00pm, by  Zeen Rachidi  ](</shai-hulud-pipeline-security/>)

[ DNS is infrastructure. It’s time to manage it that way.  Jul 30th 2026 11:00am, by  Venus Kohli  ](</dns-domain-management-automation/>)

[ Why Terraform is green when your cloud is broken  Apr 28th 2026 9:00am, by  Joe Karlsson  ](</terraform-state-infrastructure-drift/>)

[ The one Slack message that proved our elite engineering team was flying blind  Apr 26th 2026 11:00am, by  Joe Karlsson  ](</multi-cloud-blind-spots/>)

[ A few engineers asked IT for Linux. Then it spread to 200 machines.  Oct 23rd 2026 10:00am, by  David Eastman  ](</linux-developer-device-management/>)

[ His scanner wouldn’t work on Linux — so he let Claude study the Windows driver  Oct 17th 2026 10:30am, by  Amanda Caswell  ](</claude-code-linux-driver/>)

[ Linus Torvalds let Claude Code fix the Linux page cache. Then reviewers found a race.  Oct 14th 2026 6:59pm, by  Amanda Caswell  ](</torvalds-claude-code-kernel/>)

[ OpenAI's ChatGPT/Codex desktop app is now on Linux  Aug 11th 2026 1:53pm, by  Frederic Lardinois  ](</openais-chatgpt-desktop-linux/>)

[ Linux creator Linus Torvalds tells AI haters to walk away from Linux, or go fork it  Jul 16th 2026 11:15am, by  Adrian Bridgwater  ](</torvalds-linux-ai-stance/>)

[ Building scalable, agent-friendly APIs for AI applications  Oct 8th 2026 7:00am, by  Nacho Martínez  ](</building-agent-friendly-apis/>)

[ Your merge gate was a compromise. Coding agents are making it a liability.  Jul 11th 2026 1:00pm, by  Arjun Iyer  ](</merge-gate-coding-agents/>)

[ Tetrate launches open source marketplace to simplify Envoy adoption  Mar 11th 2026 10:52am, by  Adrian Bridgwater  ](</tetrate-built-on-envoy/>)

[ OpenTelemetry roadmap: Sampling rates and collector improvements ahead  Feb 24th 2026 11:00am, by  B. Cameron Gain  ](</opentelemetry-roadmap-sampling-rates-and-collector-improvements-ahead/>)

[ Merging To Test Is Killing Your Microservices Velocity  Dec 16th 2025 7:00am, by  Arjun Iyer  ](</merging-to-test-is-killing-your-microservices-velocity/>)

[ PHP2Shell was only the beginning: AI is accelerating the patch race  Oct 23rd 2026 10:00am, by  Matthew Weier O’Phinney  ](</php2shell-ai-patch-race/>)

[ OpenAI donates Open Responses, its spec for a common LLM API, to the Agentic AI Foundation  Oct 22nd 2026 12:01pm, by  Frederic Lardinois  ](</openai-donates-open-responses/>)

[ AI found a critical PHP flaw. The bigger failure began in 2024.  Oct 22nd 2026 11:01am, by  Steven J. Vaughan-Nichols  ](</php2shell-chainguard-embargo-dispute/>)

[ PHP’s security scramble is just a preview: AI is digging up flaws faster than maintainers can fix them  Oct 22nd 2026 10:35am, by  Paul Sawers  ](</php2shell-ai-vulnerabilities-maintainers/>)

[ AI found flaws in the code behind 70% of the web. The fix took two months.  Oct 21st 2026 6:17pm, by  Amanda Caswell  ](</ai-php2shell-disclosure-framework/>)

[ Why your KubeVirt VMs can’t move between clusters — and how EVPN fixes it  Aug 8th 2026 10:00am, by  Miguel Duarte Barroso  ](</kubevirt-evpn-vm-migration/>)

[ DNS is infrastructure. It’s time to manage it that way.  Jul 30th 2026 11:00am, by  Venus Kohli  ](</dns-domain-management-automation/>)

[ From intent to enforcement: Lessons from operating Kubernetes controllers at scale  Jul 17th 2026 8:00am, by  Sri Saran Balaji Vellore Rajakumar and Jayanth Varavani  ](</kubernetes-controllers-at-scale/>)

[ What happens when your VPN meets 200 AI agents  Jul 14th 2026 2:53pm, by  Alex Wilhelm  ](</unified-access-ai-agents/>)

[ Cloudflare wants to build the economic layer of the AI web  Jul 1st 2026 4:10pm, by  Amanda Caswell  ](</cloudflare-ai-web-economics/>)

[ AI data lakes are driving new storage demands  Oct 8th 2026 10:00am, by  Mrinal Kochar  ](</ai-data-lakes-storage/>)

[ Kubernetes 1.36 restores a lost guarantee for database backups  Sep 15th 2026 9:00am, by  Shubham Pampattiwar  ](</kubernetes-volume-group-snapshots/>)

[ When AI agent traces become application data  Aug 26th 2026 9:00am, by  Manveer Chawla  ](</agent-traces-application-data/>)

[ Why Postgres wants NVMe on the hot path, and S3 everywhere else  Apr 17th 2026 9:00am, by  Alasdair Brown  ](</postgres-nvme-s3-storage/>)

[ Scaling Btrfs to petabytes in production: a 74% cost reduction story  Mar 18th 2026 5:00am, by  Motiejus Jakštys  ](</btrfs-petabyte-cost-reduction/>)

[ AI ](<https://thenewstack.io/ai/>) [ AI Engineering ](<https://thenewstack.io/ai-engineering/>) [ API Management ](<https://thenewstack.io/api-management/>) [ Backend development ](<https://thenewstack.io/backend-development/>) [ Data ](<https://thenewstack.io/data/>) [ Frontend Development ](<https://thenewstack.io/frontend-development/>) [ Large Language Models ](<https://thenewstack.io/llm/>) [ Security ](<https://thenewstack.io/security/>) [ Software Development ](<https://thenewstack.io/software-development/>) [ WebAssembly ](<https://thenewstack.io/webassembly/>)

[ PHP2Shell was only the beginning: AI is accelerating the patch race ](</php2shell-ai-patch-race/>)

Oct 23rd 2026 10:00am, by  [Matthew Weier O’Phinney](<https://thenewstack.io/author/matthew-weier-ophinney/> "Posts by Matthew Weier O’Phinney")

[ A few engineers asked IT for Linux. Then it spread to 200 machines. ](</linux-developer-device-management/>)

Oct 23rd 2026 10:00am, by  [David Eastman](<https://thenewstack.io/author/david-eastman/> "Posts by David Eastman")

[ OpenAI donates Open Responses, its spec for a common LLM API, to the Agentic AI Foundation ](</openai-donates-open-responses/>)

Oct 22nd 2026 12:01pm, by  [Frederic Lardinois](<https://thenewstack.io/author/frederic-lardinois/> "Posts by Frederic Lardinois")

[ AI found a critical PHP flaw. The bigger failure began in 2024. ](</php2shell-chainguard-embargo-dispute/>)

Oct 22nd 2026 11:01am, by  [Steven J. Vaughan-Nichols](<https://thenewstack.io/author/sjvn/> "Posts by Steven J. Vaughan-Nichols")

[ PHP’s security scramble is just a preview: AI is digging up flaws faster than maintainers can fix them ](</php2shell-ai-vulnerabilities-maintainers/>)

Oct 22nd 2026 10:35am, by  [Paul Sawers](<https://thenewstack.io/author/paul-sawers/> "Posts by Paul Sawers")

[ Microsoft’s new voice AI can start working out what you want before you finish speaking ](</microsoft-streaming-speech-models/>)

Oct 23rd 2026 8:00am, by  [Adrian Bridgwater](<https://thenewstack.io/author/adrian-bridgwater/> "Posts by Adrian Bridgwater")

[ Five AI agent harnesses took the same memory test. The results weren't even close. ](</letta-frontiermemory-agent-harness-benchmark/>)

Oct 22nd 2026 2:34pm, by  [Amanda Caswell](<https://thenewstack.io/author/amanda-caswell/> "Posts by Amanda Caswell")

[ Ramp built an AI agent harness in six weeks — and LangChain's CEO says it's part of a bigger shift ](</ramp-laminar-agent-harness/>)

Oct 22nd 2026 12:31pm, by  [Amanda Caswell](<https://thenewstack.io/author/amanda-caswell/> "Posts by Amanda Caswell")

[ OpenAI’s COBOL migration score has made a striking leap ](</penai-cobol-migration-benchmark/>)

Oct 22nd 2026 11:34am, by  [Meredith Shubel](<https://thenewstack.io/author/mshubel/> "Posts by Meredith Shubel")

[ AI sped up coding. Sonar instills confidence with verification. ](</ai-coding-verification-loops/>)

Oct 21st 2026 9:00am, by  [Megan Carnegie](<https://thenewstack.io/author/megan-carnegie/> "Posts by Megan Carnegie")

[ Vercel moved to kill static credentials. Then developers spotted its own deployment token. ](</vercel-oidc-static-credentials/>)

Oct 23rd 2026 4:04pm, by  [Amanda Caswell](<https://thenewstack.io/author/amanda-caswell/> "Posts by Amanda Caswell")

[ AWS, Upstage and Ollama agree on a decision-model API. OpenAI hasn’t signed on. ](</decision-models-system-one/>)

Oct 9th 2026 8:00am, by  [Janakiram MSV](<https://thenewstack.io/author/janakiram/> "Posts by Janakiram MSV")

[ Building scalable, agent-friendly APIs for AI applications ](</building-agent-friendly-apis/>)

Oct 8th 2026 7:00am, by  [Nacho Martínez](<https://thenewstack.io/author/nacho-martinez/> "Posts by Nacho Martínez")

[ AI agents speed up development — data access slows them down ](</unified-api-layer-agents/>)

Oct 1st 2026 7:00am, by  [Doug Sillars](<https://thenewstack.io/author/doug-sillars/> "Posts by Doug Sillars")

[ MCP gets AI agents into your APIs. It doesn't decide what they should see. ](</mcp-ai-agents-api/>)

Sep 29th 2026 9:06am, by  [Matt DeBergalis](<https://thenewstack.io/author/matt-debergalis1/> "Posts by Matt DeBergalis")

[ Here are the engineering lessons we learned when live-streaming sports to 32 million people ](</live-streaming-engineering-lessons/>)

Oct 17th 2026 12:00pm, by  [Cynthia Dunlop](<https://thenewstack.io/author/cynthiadunlop/> "Posts by Cynthia Dunlop")

[ You can outgrow vanilla Postgres without abandoning Postgres ](</postgres-at-scale-why-it-struggles/>)

Oct 8th 2026 12:23pm, by  [Kimberly Fessel](<https://thenewstack.io/author/kimberly-fessel/> "Posts by Kimberly Fessel")

[ Personalization is a ranking problem — architecture makes it work ](</vespa-realtime-personalization-ranking/>)

Jul 23rd 2026 12:00pm, by  [Jenny Morris](<https://thenewstack.io/author/jenny-morris/> "Posts by Jenny Morris")

[ Can prompt caching tame RAG costs without sacrificing accuracy? ](</production-rag-architecture-fixes/>)

Jul 23rd 2026 9:00am, by  [Emmanuel Akita](<https://thenewstack.io/author/emmanuel-akita/> "Posts by Emmanuel Akita")

[ How async processing hides latency and improves responsiveness ](</async-processing-hides-latency/>)

Jul 12th 2026 1:00pm, by  [Pekka Enberg](<https://thenewstack.io/author/pekka-enberg/> "Posts by Pekka Enberg")

[ Only 34% trust synthetic data's referential integrity — and it’s holding adoption back ](</synthetic-data-referential-integrity/>)

Oct 16th 2026 11:00am, by  [Mayank Ahluwalia](<https://thenewstack.io/author/mayank-ahluwalia/> "Posts by Mayank Ahluwalia")

[ Claude can now build your dashboards ](</claude-dashboards-data-motion/>)

Oct 8th 2026 3:00pm, by  [Frederic Lardinois](<https://thenewstack.io/author/frederic-lardinois/> "Posts by Frederic Lardinois")

[ You can outgrow vanilla Postgres without abandoning Postgres ](</postgres-at-scale-why-it-struggles/>)

Oct 8th 2026 12:23pm, by  [Kimberly Fessel](<https://thenewstack.io/author/kimberly-fessel/> "Posts by Kimberly Fessel")

[ OpenSearch veterans launch Infino. Here's why it matters for agent builders. ](</infino-agent-retrieval-layer/>)

Oct 7th 2026 10:25am, by  [Adrian Bridgwater](<https://thenewstack.io/author/adrian-bridgwater/> "Posts by Adrian Bridgwater")

[ SAP acquires TechWolf to feed more context into its HR agents ](</sap-acquires-techwolf-skills/>)

Oct 6th 2026 12:52pm, by  [Frederic Lardinois](<https://thenewstack.io/author/frederic-lardinois/> "Posts by Frederic Lardinois")

[ Runway wants to generate software as you use it. Solaris is its first step. ](</runway-solaris-generated-interfaces/>)

Sep 1st 2026 3:44pm, by  [Meredith Shubel](<https://thenewstack.io/author/mshubel/> "Posts by Meredith Shubel")

[ Astro's GitHub issue backlog is heading to zero for the first time in 5 years. Now Cloudflare is open-sourcing the tool that did it. ](</cloudflare-astro-triage-bot/>)

Aug 4th 2026 9:00am, by  [Paul Sawers](<https://thenewstack.io/author/paul-sawers/> "Posts by Paul Sawers")

[ Your social login buttons run on third-party cookies. FedCM doesn't. ](</fedcm-federated-login-standard/>)

Jul 2nd 2026 10:00am, by  [Jeff Hickman](<https://thenewstack.io/author/jeff-hickman/> "Posts by Jeff Hickman")

[ Anthropic overhauled Claude Design to fix the handoff. A designer and an engineer disagree on whether it worked. ](</anthropic-claude-design-overhaul/>)

Jun 19th 2026 9:35am, by  [Meredith Shubel](<https://thenewstack.io/author/mshubel/> "Posts by Meredith Shubel")

[ Google wants to make the web agent-ready ](</google-agent-ready-web/>)

May 19th 2026 1:45pm, by  [Frederic Lardinois](<https://thenewstack.io/author/frederic-lardinois/> "Posts by Frederic Lardinois")

[ OpenAI donates Open Responses, its spec for a common LLM API, to the Agentic AI Foundation ](</openai-donates-open-responses/>)

Oct 22nd 2026 12:01pm, by  [Frederic Lardinois](<https://thenewstack.io/author/frederic-lardinois/> "Posts by Frederic Lardinois")

[ DeepSeek V4.1-Flash-1017 vs. Claude Haiku 5.5: More accurate at a fraction of the price ](</deepseek-flash-haiku-test/>)

Oct 22nd 2026 10:22am, by  [Jessica Wachtel](<https://thenewstack.io/author/jessica-wachtel/> "Posts by Jessica Wachtel")

[ Gemini 4 Argon vs. Claude Opus 5.5: Half the price and about half as accurate ](</gemini-argon-claude-opus/>)

Oct 18th 2026 11:30am, by  [Jessica Wachtel](<https://thenewstack.io/author/jessica-wachtel/> "Posts by Jessica Wachtel")

[ Muse Wonder vs. Claude Fable 5.1: Meta’s new model came closer than I expected ](</muse-wonder-claude-fable/>)

Oct 16th 2026 8:00am, by  [Jessica Wachtel](<https://thenewstack.io/author/jessica-wachtel/> "Posts by Jessica Wachtel")

[ “Developers are paying frontier prices for amnesia”: Uvi wants to stop the agent relearning brain drain ](</uvi-ai-agent-context/>)

Oct 16th 2026 7:00am, by  [Adrian Bridgwater](<https://thenewstack.io/author/adrian-bridgwater/> "Posts by Adrian Bridgwater")

[ Vercel moved to kill static credentials. Then developers spotted its own deployment token. ](</vercel-oidc-static-credentials/>)

Oct 23rd 2026 4:04pm, by  [Amanda Caswell](<https://thenewstack.io/author/amanda-caswell/> "Posts by Amanda Caswell")

[ PHP2Shell was only the beginning: AI is accelerating the patch race ](</php2shell-ai-patch-race/>)

Oct 23rd 2026 10:00am, by  [Matthew Weier O’Phinney](<https://thenewstack.io/author/matthew-weier-ophinney/> "Posts by Matthew Weier O’Phinney")

[ A few engineers asked IT for Linux. Then it spread to 200 machines. ](</linux-developer-device-management/>)

Oct 23rd 2026 10:00am, by  [David Eastman](<https://thenewstack.io/author/david-eastman/> "Posts by David Eastman")

[ AI found a critical PHP flaw. The bigger failure began in 2024. ](</php2shell-chainguard-embargo-dispute/>)

Oct 22nd 2026 11:01am, by  [Steven J. Vaughan-Nichols](<https://thenewstack.io/author/sjvn/> "Posts by Steven J. Vaughan-Nichols")

[ PHP’s security scramble is just a preview: AI is digging up flaws faster than maintainers can fix them ](</php2shell-ai-vulnerabilities-maintainers/>)

Oct 22nd 2026 10:35am, by  [Paul Sawers](<https://thenewstack.io/author/paul-sawers/> "Posts by Paul Sawers")

[ OpenAI’s COBOL migration score has made a striking leap ](</penai-cobol-migration-benchmark/>)

Oct 22nd 2026 11:34am, by  [Meredith Shubel](<https://thenewstack.io/author/mshubel/> "Posts by Meredith Shubel")

[ AI sped up coding. Sonar instills confidence with verification. ](</ai-coding-verification-loops/>)

Oct 21st 2026 9:00am, by  [Megan Carnegie](<https://thenewstack.io/author/megan-carnegie/> "Posts by Megan Carnegie")

[ Scripted tests can't keep up with AI-written code. Datadog is betting agents can. ](</datadog-propolis-agentic-testing/>)

Oct 20th 2026 12:49pm, by  [Alex Wilhelm](<https://thenewstack.io/author/alex-wilhelm/> "Posts by Alex Wilhelm")

[ How to review AI code without reading the code ](</review-decisions-not-code/>)

Oct 20th 2026 12:00pm, by  [Ankit Jain](<https://thenewstack.io/author/ankitjain/> "Posts by Ankit Jain")

[ AI’s Midas problem: When code is free, features are worthless ](</ai-commoditizes-software-value/>)

Oct 20th 2026 9:00am, by  [Steve Fenton](<https://thenewstack.io/author/steve-fenton/> "Posts by Steve Fenton")

[ Edge-forward: Akamai eyes sweet spot between centralized & decentralized AI inference ](</akamai-edge-ai-inference/>)

Apr 1st 2026 7:00am, by  [Adrian Bridgwater](<https://thenewstack.io/author/adrian-bridgwater/> "Posts by Adrian Bridgwater")

[ WebAssembly is now outperforming containers at the edge ](</webassembly-component-model-future/>)

Mar 29th 2026 9:00am, by  [B. Cameron Gain](<https://thenewstack.io/author/bruce-gain/> "Posts by B. Cameron Gain")

[ WebAssembly could solve AI agents' most dangerous security gap ](</webassembly-sandboxing-ai-agents/>)

Mar 24th 2026 9:01am, by  [B. Cameron Gain](<https://thenewstack.io/author/bruce-gain/> "Posts by B. Cameron Gain")

[ How WebAssembly plugins simplify Kubernetes extensibility ](</how-webassembly-plugins-simplify-kubernetes-extensibility/>)

Mar 3rd 2026 2:00pm, by  [B. Cameron Gain](<https://thenewstack.io/author/bruce-gain/> "Posts by B. Cameron Gain")

[ WebAssembly is everywhere. Here's how it works ](</webassembly-is-everywhere-heres-how-it-works/>)

Feb 25th 2026 11:00am, by  [Jessica Wachtel](<https://thenewstack.io/author/jessica-wachtel/> "Posts by Jessica Wachtel")

[ AI Operations ](<https://thenewstack.io/ai-operations/>) [ CI/CD ](<https://thenewstack.io/ci-cd/>) [ Cloud Services ](<https://thenewstack.io/cloud-services/>) [ DevOps ](<https://thenewstack.io/devops/>) [ Kubernetes ](<https://thenewstack.io/kubernetes/>) [ Observability ](<https://thenewstack.io/observability/>) [ Operations ](<https://thenewstack.io/operations/>) [ Platform Engineering ](<https://thenewstack.io/platform-engineering/>)

[ Who on-calls an AI? This is the unresolved crisis of agent ownership ](</production-ai-agent-ownership/>)

Oct 22nd 2026 11:00am, by  Oladimeji Sowole 

[ From feral to fiduciary: making AI agents serve your interests ](</ai-agent-trust-score/>)

Oct 21st 2026 10:00am, by  Vin Sharma 

[ Your Kubernetes dashboard is green. Your users are seeing red. ](</kubernetes-hidden-latency-telemetry/>)

Oct 20th 2026 3:02pm, by  Chris J. Preimesberger 

[ Most AI incident tools still leave a key decision to humans ](</ai-sre-agent-autonomy-phases/>)

Oct 20th 2026 7:13am, by  Charles Humble 

[ What it takes to become an AI company: Four lessons from the top ](</becoming-an-ai-company/>)

Oct 15th 2026 11:00am, by  Walid Abu-Hadba 

[ Vercel moved to kill static credentials. Then developers spotted its own deployment token. ](</vercel-oidc-static-credentials/>)

Oct 23rd 2026 4:04pm, by  Amanda Caswell 

[ Scripted tests can't keep up with AI-written code. Datadog is betting agents can. ](</datadog-propolis-agentic-testing/>)

Oct 20th 2026 12:49pm, by  Alex Wilhelm 

[ Hackers hijacked 1,900 GitHub accounts. Then they went after 30,000 repos. ](</ghostaction-github-actions-attack/>)

Oct 15th 2026 5:13pm, by  Amanda Caswell 

[ Anthropic built its own git replacement for AI-scale coding. But you can’t have it. ](</anthropic-scion-git-replacement/>)

Oct 15th 2026 10:12am, by  Meredith Shubel 

[ 66% of billion-dollar companies leave critical bugs unpatched — the part the AI bug-hunting hype leaves out ](</chainguard-mythos-security-harness/>)

Oct 14th 2026 1:00am, by  Amanda Caswell 

[ Amazon ECS now auto-repairs failing GPUs and instances. Here's why it matters for SREs. ](</amazon-ecs-auto-repair/>)

Oct 9th 2026 9:00am, by  Anirudh Aithal 

[ How to reassign resource ownership before someone's last day ](</reassign-cloud-resource-ownership/>)

Sep 29th 2026 10:00am, by  Zeen Rachidi 

[ The cloud reduced operational complexity. But many teams need someone to own it completely. ](</elastic-beanstalk-operational-ownership/>)

Sep 22nd 2026 10:00am, by  Sabari Sawant and Janakiram MSV 

[ AWS open-sources an AI agent it says is 45% cheaper than Claude Code and Codex ](</aws-strands-harness-agent/>)

Sep 21st 2026 2:30pm, by  Paul Sawers 

[ “Dormant deployments were quietly consuming storage”: Why Vercel tightened its free-tier rules ](</vercel-hobby-deployment-retention/>)

Sep 19th 2026 9:00am, by  Meredith Shubel 

[ Most AI incident tools still leave a key decision to humans ](</ai-sre-agent-autonomy-phases/>)

Oct 20th 2026 7:13am, by  Charles Humble 

[ Amazon ECS now auto-repairs failing GPUs and instances. Here's why it matters for SREs. ](</amazon-ecs-auto-repair/>)

Oct 9th 2026 9:00am, by  Anirudh Aithal 

[ Harness bought Augment’s coding agents to show them what happens after the merge ](</harness-augment-cosmos-acquisition/>)

Oct 8th 2026 5:38pm, by  Amanda Caswell 

[ AI changed how you respond to incidents. Your tabletops haven't caught up. ](</ai-incident-response-tabletops/>)

Oct 8th 2026 9:00am, by  Andy Gombar 

[ OpenSSH 10.6 deliberately breaks two features in the name of security ](</openssh-breaks-compression-usernames/>)

Oct 7th 2026 5:27pm, by  Amanda Caswell 

[ Why Kubernetes autoscalers keep fighting each other (and why the solution must be autonomous) ](</why-kubernetes-autoscalers-fight/>)

Oct 24th 2026 9:00am, by  Nikhil Kurup 

[ Before you expand your GPU pool, measure the outcome ](</optimize-kubernetes-gpu-pools/>)

Oct 24th 2026 8:00am, by  Danielle Zeis 

[ AI jobs are waiting while GPUs sit idle. Kubernetes has a new plan. ](</kubernetes-agentic-ai-inference/>)

Oct 23rd 2026 3:08pm, by  Nick Lucchesi and Bill Doerrfeld 

[ Your Kubernetes dashboard is green. Your users are seeing red. ](</kubernetes-hidden-latency-telemetry/>)

Oct 20th 2026 3:02pm, by  Chris J. Preimesberger 

[ Scale isn't one number: three ways a Kubernetes control plane runs out of room ](</scaling-kubernetes-control-planes/>)

Oct 18th 2026 10:00am, by  Joe Betz and Walter Fender 

[ AI jobs are waiting while GPUs sit idle. Kubernetes has a new plan. ](</kubernetes-agentic-ai-inference/>)

Oct 23rd 2026 3:08pm, by  Nick Lucchesi and Bill Doerrfeld 

[ Your Kubernetes dashboard is green. Your users are seeing red. ](</kubernetes-hidden-latency-telemetry/>)

Oct 20th 2026 3:02pm, by  Chris J. Preimesberger 

[ Most AI incident tools still leave a key decision to humans ](</ai-sre-agent-autonomy-phases/>)

Oct 20th 2026 7:13am, by  Charles Humble 

[ How to turn AI production feedback into better agents ](</ai-agent-evaluation-loop/>)

Oct 10th 2026 12:00pm, by  Chen Goldberg 

[ Dynatrace wants its AI agents to fix problems instead of adding alerts ](</dynatrace-arize-ai-observability/>)

Oct 5th 2026 3:06pm, by  Matthew Burns 

[ MiniMax just halved its token prices. Your AI agent bill may not follow. ](</minimax-flash-agent-costs/>)

Oct 19th 2026 6:00pm, by  Amanda Caswell 

[ Redis by proxy: Percona targets the last major hurdle to Valkey adoption ](</valkey-proxy-redis-percona/>)

Oct 8th 2026 2:54am, by  Paul Sawers 

[ A live Kubernetes cluster can still have an ownership gap ](</kubernetes-operations-ownership-governance/>)

Oct 1st 2026 11:30am, by  Chris J. Preimesberger 

[ The cloud reduced operational complexity. But many teams need someone to own it completely. ](</elastic-beanstalk-operational-ownership/>)

Sep 22nd 2026 10:00am, by  Sabari Sawant and Janakiram MSV 

[ How to find failures without drowning in tracing data ](</tracing-data-overload-sampling/>)

Sep 3rd 2026 4:17pm, by  Alex Wilhelm 

[ Why Kubernetes autoscalers keep fighting each other (and why the solution must be autonomous) ](</why-kubernetes-autoscalers-fight/>)

Oct 24th 2026 9:00am, by  Nikhil Kurup 

[ Who on-calls an AI? This is the unresolved crisis of agent ownership ](</production-ai-agent-ownership/>)

Oct 22nd 2026 11:00am, by  Oladimeji Sowole 

[ Scale isn't one number: three ways a Kubernetes control plane runs out of room ](</scaling-kubernetes-control-planes/>)

Oct 18th 2026 10:00am, by  Joe Betz and Walter Fender 

[ AI has lowered the barrier to building. Here's what that means for engineers. ](</ai-lowering-building-barrier/>)

Oct 17th 2026 11:00am, by  Matt Waxman 

[ AI agents vs. Kubernetes: where each belongs in the control loop ](</ai-agents-kubernetes-control/>)

Oct 17th 2026 10:00am, by  Vikram Seshadri 

[ C++ ](<https://thenewstack.io/c/>) [ Developer tools ](<https://thenewstack.io/developer-tools/>) [ Go ](<https://thenewstack.io/go/>) [ Java ](<https://thenewstack.io/java/>) [ JavaScript ](<https://thenewstack.io/javascript/>) [ Programming Languages ](<https://thenewstack.io/programming-languages/>) [ Python ](<https://thenewstack.io/python/>) [ Rust ](<https://thenewstack.io/rust/>) [ TypeScript ](<https://thenewstack.io/typescript/>)

[ Open source USearch library jumpstarts ScyllaDB vector search ](</open-source-usearch-library-jumpstarts-scylladb-vector-search/>)

Feb 5th 2026 12:00pm, by  Jelani Harper 

[ AWS WAF vs. Google Cloud Armor: A Multicloud Security Showdown ](</aws-waf-vs-google-cloud-armor-a-multicloud-security-showdown/>)

Nov 25th 2025 10:00am, by  Advait Patel 

[ Goodbye Dashboards: Agents Deliver Answers, Not Just Reports ](</goodbye-dashboards-agents-deliver-answers-not-just-reports/>)

Nov 23rd 2025 9:00am, by  Ketan Karkhanis 

[ Rust vs. C++: a Modern Take on Performance and Safety ](</rust-vs-c-a-modern-take-on-performance-and-safety/>)

Oct 22nd 2025 2:00pm, by  Zziwa Raymond Ian 

[ Building a Real-Time System Monitor in Rust Terminal ](</building-a-real-time-system-monitor-in-rust-terminal/>)

Oct 15th 2025 7:05am, by  Tinega Onchari 

[ Google and AWS open new paths for PyTorch beyond Nvidia ](</pytorch-tpu-trainium-migration/>)

Oct 22nd 2026 11:23am, by  Meredith Shubel 

[ ElevenLabs wants to run your voice agent. Here's what developers give up. ](</elevenlabs-voice-agent-tradeoffs/>)

Oct 20th 2026 2:43pm, by  Amanda Caswell 

[ Scripted tests can't keep up with AI-written code. Datadog is betting agents can. ](</datadog-propolis-agentic-testing/>)

Oct 20th 2026 12:49pm, by  Alex Wilhelm 

[ How to review AI code without reading the code ](</review-decisions-not-code/>)

Oct 20th 2026 12:00pm, by  Ankit Jain 

[ DeepSeek made its name with cheap AI models. Now it’s undercutting search API rivals, too. ](</deepseek-web-search-api/>)

Oct 19th 2026 10:29am, by  Paul Sawers 

[ Code that passes every test can still break the next AI agent that touches it ](</go-language-ai-agents/>)

Aug 12th 2026 1:00pm, by  Amanda Caswell 

[ Microsoft joins Google in backing Go for AI agents — OpenAI and Anthropic lag ](</microsoft-agent-framework-go/>)

Jul 11th 2026 10:00am, by  Paul Sawers 

[ Go Experts: 'I Don't Want to Maintain AI-Generated Code' ](</go-experts-i-dont-want-to-maintain-ai-generated-code/>)

Sep 28th 2025 6:00am, by  David Cassel 

[ How To Run Kubernetes Commands in Go: Steps and Best Practices ](</how-to-run-kubernetes-commands-in-go-steps-and-best-practices/>)

Jun 27th 2025 8:00am, by  Sunny Yadav 

[ Prepare Your Mac for Go Development ](</prepare-your-mac-for-go-development/>)

Apr 12th 2025 7:00am, by  Damon M. Garn 

[ How a forgotten node can put Oracle Java back in production ](</azul-ai-assistant-java-risk/>)

Sep 24th 2026 1:50pm, by  Adrian Bridgwater 

[ Azul wants to find your unpatched JVMs before AI does ](</azul-java-security-jvm-mythos/>)

Jun 24th 2026 4:53pm, by  Darryl K. Taft 

[ Chainguard targets Java's unpatched vulnerability backlog with drop-in remediated libraries ](</chainguard-java-libraries-spring-boot-cves/>)

Jun 24th 2026 4:48pm, by  Darryl K. Taft 

[ Transform your AI coding agent into a deterministic Java Spring expert ](</deterministic-ai-spring-upgrades/>)

Jun 11th 2026 9:00am, by  Raquel Pau 

[ Spring is 23 years old. AI just made it a security emergency. ](</broadcom-spring-java-cve-security-ai/>)

Jun 9th 2026 2:48pm, by  Darryl K. Taft 

[ Employees are vibe-coding their own apps. Cloudflare open-sources Void to give IT a handle on them ](</cloudflare-voidzero-void-vibe-coding/>)

Oct 16th 2026 8:16am, by  Paul Sawers 

[ Cloudflare acquires Node.js creator’s startup that copied its serverless playbook ](</cloudflare-acquires-deno-ryan-dahl/>)

Oct 9th 2026 2:52pm, by  Paul Sawers 

[ Cloudflare aqui-hires VoidZero: Did a piece of the open web just stabilize, or become more brittle? ](</cloudflare-voidzero-acquisition-vite/>)

Jun 5th 2026 3:01pm, by  Adrian Bridgwater 

[ "Real maturity problems": Not every developer is thrilled with Bun after Anthropic acquisition ](</bun-developers-complaints-anthropic/>)

May 5th 2026 1:03pm, by  Adrian Bridgwater 

[ TypeScript 6.0 RC arrives as a bridge to a faster future ](</typescript-6-0-rc-arrives-as-a-bridge-to-a-faster-future/>)

Mar 14th 2026 9:00am, by  Darryl K. Taft 

[ GitHub and Anthropic used their own agents for major Rust rewrites -- but with very different playbooks ](</github-copilot-anthropic-rust-migration/>)

Sep 17th 2026 2:06pm, by  Paul Sawers 

[ JetBrains kills Kotlin Notebook months after Microsoft's Polyglot exit. But Jupyter is doing just fine. ](</kotlin-notebook-jupyter-python-retreat/>)

Jun 29th 2026 1:59pm, by  Paul Sawers 

[ Trust in Rust: Foundation debuts official training to tackle steep learning curve ](</rust-foundation-training-certification/>)

Jun 25th 2026 12:30pm, by  Darryl K. Taft 

[ Who will maintain the web when PHP's veterans retire? ](</php-web-skills-hiring-age/>)

Apr 16th 2026 2:53pm, by  Darryl K. Taft 

[ Will AI force code to evolve or make it extinct? ](</ai-programming-languages-future/>)

Mar 22nd 2026 6:00am, by  David Cassel 

[ Google paid $90,000 for this bug, then waited two months to fix it ](</google-devsite-rce-bounty/>)

Oct 12th 2026 4:47pm, by  Amanda Caswell 

[ Stop AI code sprawl before it destroys your software design ](</stop-ai-code-sprawl/>)

Sep 10th 2026 8:30am, by  Emmanuel Akita 

[ Why basic RAG fails at multi-hop reasoning (and how GraphRAG fixes it) ](</graphrag-multi-hop-reasoning-python/>)

Aug 27th 2026 10:00am, by  Emmanuel Akita 

[ Nvidia's NOOA makes an agent one Python class ](</nvidia-nooa-agent-framework/>)

Aug 4th 2026 10:02am, by  Meredith Shubel 

[ Spark 4.2 has a feature that could retire your vector database ](</spark-4-2-ai-workloads/>)

Jul 19th 2026 12:00pm, by  Amanda Caswell 

[ Respan spent two years building on LiteLLM. One upgrade made it start over. ](</respan-rust-ai-gateway/>)

Oct 20th 2026 6:13pm, by  Amanda Caswell 

[ “We are not forking TypeScript”: Cloudflare spearheads Rust port written by agents, for agents ](</cloudflare-rust-typescript-tsrs/>)

Oct 20th 2026 5:36pm, by  Paul Sawers 

[ GitHub and Anthropic used their own agents for major Rust rewrites -- but with very different playbooks ](</github-copilot-anthropic-rust-migration/>)

Sep 17th 2026 2:06pm, by  Paul Sawers 

[ How AWS Lambda logs every flow across thousands of microVMs per host with eBPF and Rust ](</aws-lambda-ebpf-rust/>)

Sep 11th 2026 8:00am, by  Prashant Kumar Singh, Kshitij Gupta and Shivendra Srivastava 

[ AI-generated Rust compiles perfectly. That's the scary part. ](</canonical-c-rust-apparmor/>)

Aug 19th 2026 3:30pm, by  Amanda Caswell 

[ “We are not forking TypeScript”: Cloudflare spearheads Rust port written by agents, for agents ](</cloudflare-rust-typescript-tsrs/>)

Oct 20th 2026 5:36pm, by  Paul Sawers 

[ From clobbered drafts to real-time sync ](</real-time-sync-engine/>)

Apr 14th 2026 10:00am, by  David Moore 

[ TypeScript 6.0 RC arrives as a bridge to a faster future ](</typescript-6-0-rc-arrives-as-a-bridge-to-a-faster-future/>)

Mar 14th 2026 9:00am, by  Darryl K. Taft 

[ Mastra empowers web devs to build AI agents in TypeScript ](</mastra-empowers-web-devs-to-build-ai-agents-in-typescript/>)

Jan 28th 2026 11:00am, by  Loraine Lawson 

[ Inferno Vet Creates Frontend Framework Built With AI in Mind ](</inferno-vet-creates-frontend-framework-built-with-ai-in-mind/>)

Dec 10th 2025 11:00am, by  Loraine Lawson

---
*Fetched by article-pipeline · 2026-10-25*
