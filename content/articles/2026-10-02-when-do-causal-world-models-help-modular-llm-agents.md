---
title: "When Do Causal World Models Help Modular LLM Agents"
date: 2026-10-02
source: "arXiv CS.AI"
url: "https://arxiv.org/abs/2610.00012"
category: ai_ml
tags: [articles, ai_ml, "cs.AI"]
score: 72
---

# When Do Causal World Models Help Modular LLM Agents

> Originally published at [arXiv CS.AI](https://arxiv.org/abs/2610.00012) · 2026-10-02

![Hero](images/2026-10-02-img00.png)

---

# Computer Science > Artificial Intelligence

**arXiv:2610.00012** (cs) 

[Submitted on 12 Jul 2026]

# Title:When Do Causal World Models Help Modular LLM Agents

Authors:[Xinyuan Song](<https://arxiv.org/search/cs?searchtype=author&query=Song,+X>), [Zekun Cai](<https://arxiv.org/search/cs?searchtype=author&query=Cai,+Z>)


[View PDF](</pdf/2610.00012>) [HTML (experimental)](<https://arxiv.org/html/2610.00012v1>)

> Abstract:LLM agents increasingly act through modular systems, such as order, payment, inventory, and shipment services, where actions in one module change which transitions are valid in another. Standard world models usually fit observational traces, but this is not the quantity needed for intervention-time planning: a trace may show that payment precedes shipment without identifying whether payment authorizes shipment, inventory mediates the effect, or a hidden trigger explains both. We study this gap through FedCausalCompose, a causal world-model framework for modular LLM agents in which local actions provide intervention-response evidence for cross-module interfaces. We first show that observational world models incur an irreducible interventional error under unblocked back-door paths, that interface recovery improves with intervention-response coverage, and that an oracle causal composition can beat the non-causal lower bound when coverage and local mechanism errors are controlled. We then test the resulting prediction in diagnostic agent settings. Causal interfaces help most in structured tool environments, where API signatures expose preconditions and downstream effects. In contrast, dialogue and narrative environments often ignore raw edge lists unless a short attention anchor makes the causal information decision-relevant. These results identify a concrete condition for causal world models in LLM agents: causal structure helps when cross-module interfaces are both statistically identifiable and presented in a form the agent can use at action time. 

Comments:  
---  
Subjects: |  Artificial Intelligence (cs.AI)  
Cite as: | [arXiv:2610.00012](<https://arxiv.org/abs/2610.00012>) [cs.AI]  
| (or  [arXiv:2610.00012v1](<https://arxiv.org/abs/2610.00012v1>) [cs.AI] for this version)   
|  <https://doi.org/10.48550/arXiv.2610.00012> arXiv-issued DOI via DataCite  
  
