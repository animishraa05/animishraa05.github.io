---
title: "Coverage, Not Difficulty, Sets How Much Synthetic Data an Activation Probe Needs"
date: 2026-10-10
source: "arXiv CS.LG"
url: "https://arxiv.org/abs/2610.10594"
category: ai_ml
tags: [articles, ai_ml, "cs.LG"]
score: 74
---

# Coverage, Not Difficulty, Sets How Much Synthetic Data an Activation Probe Needs

> Originally published at [arXiv CS.LG](https://arxiv.org/abs/2610.10594) · 2026-10-09

![Hero](images/2026-10-10-img00.png)

---

# Computer Science > Machine Learning

**arXiv:2610.10594** (cs) 

[Submitted on 6 Oct 2026]

# Title:Coverage, Not Difficulty, Sets How Much Synthetic Data an Activation Probe Needs

Authors:[Ankush Checkervarty](<https://arxiv.org/search/cs?searchtype=author&query=Checkervarty,+A>)

View a PDF of the paper titled Coverage, Not Difficulty, Sets How Much Synthetic Data an Activation Probe Needs, by Ankush Checkervarty

[View PDF](</pdf/2610.10594>) [HTML (experimental)](<https://arxiv.org/html/2610.10594v1>)

> Abstract:Activation probes that monitor deployed language models are trained on synthetic conversations, and how many a probe needs is open. We trace learning curves over 10-590 synthetic samples for three monitoring concepts, high-stakes situations, replies harmful to a person, and replies that do not follow the user's instruction, on fourteen held-out evaluation distributions and four probe models, varying the generator LLM and the prompt's detail. The need is set by what is monitored: probes for high-stakes and harmful are within a few hundredths of their plateau from 80 samples on Gemma-3-27B-IT, instruction probes need several times as many, and the ordering holds on three smaller probe models and on real samples (from dev set). Prior work advises spending a generation budget on breadth, more kinds of data, over depth, more of each kind. We read the depth a concept needs as the half-gain size of a fitted curve, the number of samples at which half the gain is in hand. Concept and distribution account for 42-45% of its variance, the generator, probe model, and prompt detail for under 10%. What sets the value of the half-gain size is coverage, not per-kind difficulty: the number of samples of its own kind a distribution needs to saturate. Every kind, one per evaluation distribution, has a median half-gain size of 7-11 own-kind synthetic samples under all three concepts alike. What differs is how far samples of one kind transfer to the concept's other kinds, almost fully under high-stakes, less under harmful, and least under instruction, which accounts for most of the gap between concepts on generated and real samples. Breadth therefore pays differently by concept: many kinds are necessary under instruction, where no kind covers another, and nearly redundant under high-stakes, where one kind covers the rest. We release the evaluation suites, dev sets, and generated sets. 

Comments:  
---  
Subjects: |  Machine Learning (cs.LG)  
Cite as: | [arXiv:2610.10594](<https://arxiv.org/abs/2610.10594>) [cs.LG]  
| (or  [arXiv:2610.10594v1](<https://arxiv.org/abs/2610.10594v1>) [cs.LG] for this version)   
|  <https://doi.org/10.48550/arXiv.2610.10594> arXiv-issued DOI via DataCite  
  
## Submission history

From: Ankush Checkervarty [[view email](</show-email/a2bb12f7/2610.10594>)]   
**[v1]** Tue, 6 Oct 2026 18:49:40 UTC (52 KB)  

Full-text links:

## Access Paper:

View a PDF of the paper titled Coverage, Not Difficulty, Sets How Much Synthetic Data an Activation Probe Needs, by Ankush Checkervarty

  * [View PDF](</pdf/2610.10594>)
  * [HTML (experimental)](<https://arxiv.org/html/2610.10594v1>)
  * [TeX Source ](</src/2610.10594>)

[ view license ](<http://creativecommons.org/licenses/by/4.0/> "Rights to this article")

### Additional Features

  * [Audio Summary](</audio/2610.10594>)

### Current browse context:

cs.LG

[< prev](</prevnext?id=2610.10594&function=prev&context=cs.LG> "previous in cs.LG \(accesskey p\)") |  [next >](</prevnext?id=2610.10594&function=next&context=cs.LG> "next in cs.LG \(accesskey n\)")   

[new](</list/cs.LG/new>) |  [recent](</list/cs.LG/recent>) | [2026-10](</list/cs.LG/2026-10>)

Change to browse by: 

[cs](</abs/2610.10594?context=cs>)  

### References & Citations

  * [NASA ADS](<https://ui.adsabs.harvard.edu/abs/arXiv:2610.10594>)
  * [Google Scholar](<https://scholar.google.com/scholar_lookup?arxiv_id=2610.10594>)
  * [Semantic Scholar](<https://api.semanticscholar.org/arXiv:2610.10594>)

Loading...

## BibTeX formatted citation

loading...

Data provided by: 

### Bookmark

[ ](<http://www.bibsonomy.org/BibtexHandler?requTask=upload&url=https://arxiv.org/abs/2610.10594&description=Coverage, Not Difficulty, Sets How Much Synthetic Data an Activation Probe Needs> "Bookmark on BibSonomy") [ ](<https://reddit.com/submit?url=https://arxiv.org/abs/2610.10594&title=Coverage, Not Difficulty, Sets How Much Synthetic Data an Activation Probe Needs> "Bookmark on Reddit")

Bibliographic Tools

# Bibliographic and Citation Tools

Bibliographic Explorer Toggle

Bibliographic Explorer _([What is the Explorer?](<https://info.arxiv.org/labs/showcase.html#arxiv-bibliographic-explorer>))_

Connected Papers Toggle

Connected Papers _([What is Connected Papers?](<https://www.connectedpapers.com/about>))_

Litmaps Toggle

Litmaps _([What is Litmaps?](<https://www.litmaps.co/>))_

scite.ai Toggle

scite Smart Citations _([What are Smart Citations?](<https://www.scite.ai/>))_

Code, Data, Media

# Code, Data and Media Associated with this Article

alphaXiv Toggle

alphaXiv _([What is alphaXiv?](<https://alphaxiv.org/>))_

Links to Code Toggle

CatalyzeX Code Finder for Papers _([What is CatalyzeX?](<https://www.catalyzex.com>))_

DagsHub Toggle

DagsHub _([What is DagsHub?](<https://dagshub.com/>))_

GotitPub Toggle

Gotit.pub _([What is GotitPub?](<http://gotit.pub/faq>))_

Huggingface Toggle

Hugging Face _([What is Huggingface?](<https://huggingface.co/huggingface>))_

ScienceCast Toggle

ScienceCast _([What is ScienceCast?](<https://sciencecast.org/welcome>))_

Demos

# Demos

Replicate Toggle

Replicate _([What is Replicate?](<https://replicate.com/docs/arxiv/about>))_

Spaces Toggle

Hugging Face Spaces _([What is Spaces?](<https://huggingface.co/docs/hub/spaces>))_

Spaces Toggle

TXYZ.AI _([What is TXYZ.AI?](<https://txyz.ai>))_

Related Papers

# Recommenders and Search Tools

Link to Influence Flower

Influence Flower _([What are Influence Flowers?](<https://influencemap.cmlab.dev/>))_

Core recommender toggle

CORE Recommender _([What is CORE?](<https://core.ac.uk/services/recommender>))_

IArxiv recommender toggle

IArxiv Recommender _([What is IArxiv?](<https://iarxiv.org/about>))_

  * Author
  * Venue
  * Institution
  * Topic

About arXivLabs 

# arXivLabs: experimental projects with community collaborators

arXivLabs is a framework that allows collaborators to develop and share new arXiv features directly on our website.

Both individuals and organizations that work with arXivLabs have embraced and accepted our values of openness, community, excellence, and user data privacy. arXiv is committed to these values and only works with partners that adhere to them.

Have an idea for a project that will add value for arXiv's community? [**Learn more about arXivLabs**](<https://info.arxiv.org/labs/index.html>).

[Which authors of this paper are endorsers?](</auth/show-endorsers/2610.10594>) | [Disable MathJax](<javascript:setMathjaxCookie\(\)>) ([What is MathJax?](<https://info.arxiv.org/help/mathjax.html>))

---
*Fetched by article-pipeline · 2026-10-10*
