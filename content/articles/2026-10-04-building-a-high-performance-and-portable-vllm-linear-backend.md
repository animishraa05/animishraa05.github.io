---
title: "Building a High-Performance and Portable vLLM Linear Backend with Helion"
date: 2026-10-04
source: "PyTorch Blog"
url: "https://pytorch.org/blog/building-a-high-performance-and-portable-vllm-linear-backend-with-helion/"
category: ai_ml
tags: [articles, ai_ml, "Blog"]
score: 76
---

# Building a High-Performance and Portable vLLM Linear Backend with Helion

> Originally published at [PyTorch Blog](https://pytorch.org/blog/building-a-high-performance-and-portable-vllm-linear-backend-with-helion/) · 2026-10-02

---

### Featured projects

  * [  
](<https://pytorch.org/projects/helion/> "Helion")
  * [  
](<https://pytorch.org/projects/vllm/> "vLLM")

## TL;DR

We integrated [Helion](<https://helionlang.com/index.html>) into vLLM’s [linear backend](<https://docs.vllm.ai/en/latest/api/vllm/model_executor/kernels/linear/>) to explore how an autotuned, high-level kernel DSL can improve LLM inference performance while reducing kernel implementation complexity. A single Helion general matrix multiplication (GEMM) implementation can cover multiple algorithmic variants, including Standard GEMM, Split-K, and Swap-AB, with the best variant and config automatically selected through per-shape autotuning.

On NVIDIA Hopper GPUs, the Helion linear backend combines per-shape tuning with hybrid dispatch to outperform the vLLM default CUTLASS and DeepGEMM backends across the evaluated models, delivering consistent end-to-end performance gains and more than 10% throughput improvement for some workloads.

## Brief Background on vLLM and Helion

[vLLM](<https://docs.vllm.ai/en/latest/>) is a high-performance inference and serving framework for large language models (LLMs). For quantized linear layers, such as FP8, INT8, INT4, and NVFP4, vLLM provides specialized [linear backends](<https://docs.vllm.ai/en/latest/api/vllm/model_executor/kernels/linear/>) that integrate hardware-optimized kernel implementations from libraries such as CUTLASS, DeepGEMM, and FlashInfer. These backends allow vLLM to use optimized kernels for different quantization formats and hardware platforms.

[Helion](<https://helionlang.com/index.html>) is a PyTorch-native hardware agnostic kernel DSL designed for writing high-performance kernels using a tile-programming model. Its high-level abstraction allows developers to express a kernel once in concise Pythonic code, while Helion generates specialized code for different workloads on different hardware platforms. Rather than manually specializing kernels for each workload and hardware target, Helion relies on ahead-of-time (AOT) autotuner to systematically explore a broad search space, from low-level memory layout and kernel scheduling to high-level algorithmic choices, and select the best-performing config. This combination of high-level abstraction and systematic autotuning enables a single kernel implementation to be optimized across diverse workloads and hardware. Helion also supports LLM-guided search to further improve tuning efficiency.

## Helion Adoption Opportunities and Challenges

This section summarizes the key opportunities and challenges of adopting Helion kernels in inference engines such as vLLM, providing a high-level overview of Helion’s value proposition and tradeoffs.

### Opportunities

**Performance** : Our [previous work](<https://pytorch.org/blog/portable-vllm-model-inference-kernels-in-helion/>) demonstrated Helion’s potential to achieve SOTA performance for inference kernels across diverse workload patterns and hardware platforms through fine-grained tuning. 

**Systematic Tuning Framework** : Compared with more open-ended agentic approaches that iteratively generate, profile, and refine kernel implementations, Helion formulates kernel tuning as a structured numerical optimization problem over a well-defined search space. This makes the tuning process more robust and reliable while remaining competitive in tuning efficiency, without relying on profiling to guide the search. Helion further supports LLM-guided search, combining the reasoning capabilities of LLMs with systematic numerical optimization to efficiently navigate the search space.

**Portability and Abstraction** : Helion is not only a portable DSL. It is possible to maintain a single kernel implementation while optimizing it for different workload patterns and hardware platforms. 

**Client-Side Kernel Optimization** : Default kernels in inference engines such as vLLM are typically optimized for general workloads and commonly used models. With Helion, users can further tune kernel performance for their specific deployments without requiring specialized kernel expertise or significant engineering effort.

### Challenges

Helion still has some challenges integrating into inference engines, with ongoing work from the Helion team to address and mitigate them.

**Ahead-of-time kernel tuning overhead** : Helion automates and systematizes kernel tuning, but fine-grained tuning can still take hours. This overhead comes primarily from the granularity of the tuning strategy rather than from Helion itself. Achieving the same level of workload-specific specialization with other kernel DSLs would incur comparable—or potentially greater—tuning costs.

**Startup-time overhead** : CUDA Graph capture during vLLM startup triggers Helion JIT compilation, increasing cold-start latency. This overhead can be largely eliminated on warm starts by caching compiled artifacts.

**Inference-runtime overhead** : Outside the CUDA Graph capture range, Helion kernel dispatch and launch during inference can introduce additional CPU overhead, potentially offsetting the performance gains from fine-grained tuning. In practice, Helion is most effective when executed under CUDA Graphs to avoid this CPU overhead.

**Maintenance overhead** : Shipping pre-tuned configs for popular models creates an ongoing upstream maintenance burden. Large config files are difficult to maintain and impractical to validate exhaustively through unit tests and CI. 

### The Tradeoff Triangle

Fine-grained kernel tuning with Helion presents a tradeoff among **performance** , **usability** , and **maintainability**. This tradeoff is not specific to Helion, but is inherent to workload-specific kernel optimization: optimizing for two often comes at the expense of the third.

_Fig. 1: The Performance-Usability-Maintainability tradeoff triangle_

Higher performance generally requires more fine-grained config tuning. This either increases client-side autotuning overhead or requires maintainers to provide and maintain more pre-tuned configs upstream. The goal, therefore, is to strike the right balance for the target use case. 

## Helion Linear Backend 

### Scope

This work adds a Helion linear backend to vLLM and focuses on NVIDIA Hopper GPUs using Helion’s Triton backend. FP8 and INT8 are the primary quantization formats for efficient inference on Hopper, so we target quantized GEMM with the following formats:

  * [**FP8_Dynamic**](<https://docs.vllm.ai/en/latest/features/quantization/llm_compressor/fp8/>) : FP8 per-token activation and per-channel weight scaling.
  * [**W8A8_INT8**](<https://docs.vllm.ai/en/latest/features/quantization/llm_compressor/int8_w8a8/>) : INT8 per-token activation and per-channel weight scaling.
  * [**Block_FP8**](<https://docs.vllm.ai/en/latest/features/quantization/llm_compressor/fp8/>) : FP8 with 1×128 activation scaling and 128×128 weight scaling. 

[Initial results](<https://github.com/pytorch/helion/pull/3377#issuecomment-5345673133>) with Helion’s CuteDSL backend show competitive GEMM performance on NVIDIA Blackwell GPUs. As the CuteDSL backend matures, this work can be extended to support Blackwell.

### Kernel Implementation

Several GEMM algorithm variants can improve performance for specific input shapes. In particular:

  * **Split-K** : Partitions the K dimension across multiple thread blocks to increase parallelism when the M and/or N dimensions are too small.
  * **Swap-AB** : Rewrites A@B as (B.T@A.T).T to improve performance for shapes with a small M dimension by enabling more favorable tiling and better GPU utilization.

Traditionally, kernel authors need to implement multiple GEMM variants, benchmark the standard GEMM against these specialized variants, and develop heuristics to determine which implementation to dispatch to based on the input shape. For example, vLLM’s current Block_FP8 linear backend dispatches to the Swap-AB variant when M < 32 on Hopper. Such heuristics are typically designed to perform well in general, but may not be optimal for every model or workload. 

With Helion, a single unified GEMM implementation can cover all three variants—Standard, Split-K, and Swap-AB. Instead of implementing separate kernels and manually designing dispatch heuristics, the algorithmic choices are exposed as tunable parameters. The AOT autotuner can then automatically select the best variant along with the low-level kernel config for each workload.

For simplicity, we use a basic matrix multiplication kernel below to illustrate the approach. The quantized GEMM kernels used in this work follow the same structure, with additional quantization and scaling logic.
[code] 
    def matmul(
        out: torch.Tensor,  # [M, N]
        a: torch.Tensor,    # [M, K]
        b: torch.Tensor,    # [K, N]
    ) -> None:
        M, K = a.shape
        N = b.shape[1]
        hl.specialize(K)
        hl.specialize(N)
    
        out_dtype = out.dtype
        acc_dtype = torch.float32
    
        split_k = hl.register_tunable(
            "split_k", PowerOfTwoFragment(1, 256)
        )
        k_block_size = helion.next_power_of_2(helion.cdiv(K, split_k))
        if split_k > 1:
            out.zero_()
    
        swap_ab = hl.register_tunable(
            "swap_ab", BooleanFragment()
        )
    
        for tile_m, tile_n, outer_k in hl.tile(
            [M, N, K],
            block_size=[None, None, k_block_size]
        ):
            acc = hl.zeros([tile_m, tile_n], acc_dtype)
            acc_t = acc.t()
            for tile_k in hl.tile(outer_k.begin, outer_k.end):
                if swap_ab:
                    a_blk = hl.load(a, [tile_m.index[None, :], tile_k.index[:, None]])
                    b_blk = hl.load(b, [tile_k.index[None, :], tile_n.index[:, None]])
                    acc_t = hl.dot(
                        b_blk,
                        a_blk,
                        acc=acc_t,
                        out_dtype=acc_dtype,
                    )
                else:
                    acc = hl.dot(
                        a[tile_m, tile_k],
                        b[tile_k, tile_n],
                        acc=acc,
                        out_dtype=acc_dtype,
                    )
    
            if swap_ab:
                out_blk = acc_t.t().to(out_dtype)
            else:
                out_blk = acc.to(out_dtype)
    
            if split_k == 1:
                out[tile_m, tile_n] = out_blk
            else:
                hl.atomic_add(out, [tile_m, tile_n], out_blk)
[/code]

This implementation exposes both algorithmic choices as tunable parameters: `split_k` is constrained to power-of-two values up to 256, while `swap_ab` is a Boolean parameter. The autotuner explores the constrained search space, benchmarks different combinations, and selects the best variant for each workload.

### Hybrid Dispatch

_Fig. 2: Helion linear backend hybrid dispatch strategy based on runtime num_tokens and CUDA Graph coverage._

We adopt a hybrid dispatch strategy based on runtime `num_tokens` and CUDA Graph coverage. For small shapes up to `max_helion_size`, the linear backend dispatches to Helion under CUDA Graph replay. For larger shapes beyond `max_helion_size`, it falls back to the default kernel (CUTLASS/DeepGEMM).

This hybrid dispatch strategy provides three practical benefits:

  * **Eliminates Helion runtime overhead**. Helion kernels execute only through CUDA Graph replay, avoiding the additional CPU overhead from kernel dispatch and launch.
  * **Reduces kernel tuning overhead**. Fine-grained Helion tuning is limited to the small `num_tokens` range that dominates decoding workloads, significantly reducing the number of input shapes that need to be tuned while preserving the opportunity for meaningful end-to-end performance gains.
  * **Reduces config maintenance overhead**. The smaller set of tuned configs makes pre-tuned configs more practical to validate, ship, and maintain over time.

### Kernel Autotuning

We autotune the Helion linear kernels using the utility script available in vLLM:
[code] 
    HELION_AUTOTUNER=LLMSeededLFBOTreeSearch \
    HELION_BENCHMARK_CUDAGRAPH =1 \
    python scripts/autotune_helion_kernels.py \
      --kernels scaled_mm block_scaled_mm \
      --autotune-effort "full"
[/code]

The following sections describe the key tuning strategies and setups used in this work.

#### Per-shape Config Tuning

To compete with highly optimized GEMM libraries such as CUTLASS, DeepGEMM, and FlashInfer, we tune the Helion kernel individually for each input shape within the Helion dispatch range.

As described in the hybrid dispatch strategy, we set `max_helion_size = 32` for this work. vLLM captures CUDA Graphs for the following num_tokens values:
[code] 
    [1, 2, 4] + range(8, 256, 8) + range(256, max_graph_size + 1, 16)
[/code]

With `max_helion_size = 32`, the Helion kernels are therefore autotuned for:
[code] 
    num_tokens = [1, 2, 4, 8, 16, 24, 32]
[/code]

Each num_tokens value is tuned individually for the corresponding GEMM shapes used by the model.

#### Enable CUDA Graph for Autotuner Benchmarking

Due to the additional CPU overhead from kernel dispatch and launch, Helion kernels are used only under CUDA Graph execution. Benchmarking with CUDA Graph enabled therefore allows the autotuner to evaluate configs under conditions that more closely match actual inference execution.

Helion exposes this feature through the `HELION_BENCHMARK_CUDAGRAPH`environment variable and is turned on for this work.

#### Use LLM-Guided Search

The kernel configs in this work are generated using the [LLMSeededLFBOTreeSearch](<https://pytorch.org/blog/from-minutes-to-seconds-llm-guided-autotuning-for-helion-kernels/>) autotuner, which uses an LLM to identify a set of promising config candidates as seeds for the subsequent LFBOTreeSearch. For this work, we use [Claude Opus 4.8](<https://www.anthropic.com/news/claude-opus-4-8>).

Starting the search from higher-quality candidates helps the autotuner discover better-performing configs. It may also reduce overall autotuning time by directing the search toward more promising regions of the search space.

## Performance Evaluation

We evaluate the Helion linear backend at both the kernel and end-to-end serving levels across a range of dense models and quantization formats. To understand how performance scales with model size, we benchmark Qwen3-1.7B, Qwen3-4B, Qwen3-8B, Qwen3-14B, and Qwen3-32B. We additionally include the latest Qwen3.8-27B model to evaluate the backend on a more recent model architecture.

For each model, we evaluate three commonly used 8-bit quantization formats on NVIDIA Hopper GPUs. For example, for Qwen3.8-27B, we benchmark: 

  * [AzatAI/Qwen3.8-27B-FP8-dynamic](<https://huggingface.co/AzatAI/Qwen3.8-27B-FP8-dynamic>) (FP8_Dynamic)
  * [Freaksterz/Qwen3.8-27B-SmoothQuant-W8A8-INT8](<https://huggingface.co/Freaksterz/Qwen3.8-27B-SmoothQuant-W8A8-INT8>) (W8A8_INT8)
  * [Qwen/Qwen3.8-27B-FP8](<https://huggingface.co/Qwen/Qwen3.8-27B-FP8>) (Block_FP8) 

All benchmarks are performed on an NVIDIA H100 80GB HBM3 GPU.

### Kernel-Level Evaluation

We first evaluate the Helion quantized GEMM kernels in isolation to understand the performance benefit of fine-grained tuning independent of the rest of the inference stack. Each Helion kernel is compared against the corresponding kernel used by the default vLLM linear backend on Hopper:

  * FP8_Dynamic: Helion vs. CUTLASS
  * W8A8_INT8: Helion vs. CUTLASS
  * Block_FP8: Helion vs. FlashInfer/DeepGEMM

_Fig. 3: Helion quantized GEMM kernel speedup distribution over the default vLLM kernel libraries across all input shapes used by the end-to-end benchmarked models. Diamonds indicate the geometric mean speedup._

Helion achieves geometric mean speedups of **1.110×** for FP8_Dynamic over CUTLASS, **1.178×** for W8A8_INT8 over CUTLASS, **1.149×** for Block_FP8 over FlashInfer, and **1.177×** for Block_FP8 over DeepGEMM. The distribution also shows that performance varies across individual input shapes, highlighting the value of fine-grained tuning rather than relying on a single kernel config or generic dispatch heuristic.

### End-to-End Evaluation

We next evaluate whether the kernel-level improvements translate into end-to-end serving performance.

#### Server Setup

We use the following command to start the vLLM server:
[code] 
    vllm serve \
        --model "$MODEL" \
        --max-num-seqs 32 \
        --tensor-parallel-size 1 \
        --no-enable-prefix-caching \
        --linear-backend helion
[/code]

The relevant options are:

  * `--max-num-seqs 32`: The Helion linear backend currently uses a hybrid dispatch threshold of 32 `num_tokens`. We therefore focus the evaluation on batch sizes up to 32, where Helion kernels are active and can directly affect end-to-end performance.
  * `--no-enable-prefix-caching`: Prefix caching is intentionally disabled to avoid its impact on benchmark results.
  * `--linear-backend helion`: Enables the Helion linear backend. Omitting this flag uses the default linear backend.

### Benchmark Setup

We run end-to-end serving benchmarks using the ShareGPT dataset with:
[code] 
    vllm bench serve \
        --backend vllm \
        --model "${MODEL}" \
        --endpoint /v1/completions \
        --dataset-name sharegpt \
        --dataset-path "${DATASET}" \
        --max-concurrency "${BATCH_SIZE}" \
        --num-warmups "${NUM_WARMUPS}" \
        --num-prompts "${PROMPTS}" \
        --ignore-eos
[/code]

Each workload is benchmarked with both the default and Helion linear backends. The default vLLM [linear backends](<https://docs.vllm.ai/en/latest/api/vllm/model_executor/kernels/linear/scaled_mm/>) used as baselines on Hopper are:

  * **FP8_Dynamic** : CutlassFP8ScaledMMLinearKernel
  * **W8A8_INT8** : CutlassInt8ScaledMMLinearKernel
  * **Block_FP8** : FlashInferFp8DeepGEMMDynamicBlockScaledKernel

#### End-to-End Benchmark Results

The following Figure shows the end-to-end throughput speedup of the Helion linear backend over the corresponding default backend across different model sizes, batch sizes, and quantization formats.

_Fig. 4: Helion linear backend end-to-end throughput speedup._

Overall, the Helion linear backend delivers consistent end-to-end performance gains across the evaluated models and quantization formats, with more than 10% throughput improvement for some workloads.

## Toward a Practical Adoption Model

The Helion linear backend presented in this work is currently available in our [vLLM fork](<https://github.com/redhat-et/vllm-helion>) and ready for production use. The fork also includes the autotuning tooling and instructions needed for end users to generate optimized configs for additional models and workloads. One remaining challenge for upstream adoption is the maintenance overhead of shipping and validating a large collection of pre-tuned configs.

For latency-critical kernels such as the GEMM kernels studied in this work, we are exploring a model in which the Helion kernels and integration framework are maintained upstream with a default config for functional testing and CI, while workload-specific autotuning is delegated to end users. The same automated tooling used in this work allows users to generate optimized configs for their target models and hardware before deployment. This model favors performance and maintainability over out-of-the-box usability. We believe this tradeoff is practical for latency-critical kernels, where the performance benefits can justify the additional offline optimization effort, particularly for model serving providers willing to make this investment before production deployment.

Fine-grained tuning, however, is not the only practical adoption strategy for Helion kernels. For smaller auxiliary kernels, such as quantization, activation, and normalization kernels, it can be preferable to trade some peak performance for a much smaller config set that generalizes across shapes. Our [initial experiments](<https://github.com/vllm-project/vllm/issues/53788>) show that meaningful performance improvements can be achieved for these kernels with as few as six configs. This provides another path toward upstream adoption with substantially lower tuning and maintenance overhead for auxiliary kernels.

We encourage interested users to try the current implementation and share their experience in the ⁠[vLLM Helion linear backend RFC](<https://github.com/vllm-project/vllm/issues/46526>). Feedback from real-world deployments will help us evaluate these approaches and guide the integration toward broader adoption.

## Future work

Future work will focus on expanding Helion kernel coverage across inference workloads and hardware platforms.

**Hardware coverage**. The Helion team is continuing to expand and optimize backend support across hardware platforms, including the CuteDSL backend for NVIDIA Blackwell GPUs and ongoing performance work for AMD GPUs and [TPUs](<https://pytorch.org/blog/helion-on-tpu-towards-hardware-heterogeneous-kernel-authoring/>). As these backends mature, we plan to extend and re-evaluate the Helion linear backend across these hardware targets.

**Model coverage**. This work primarily targets dense models, where the linear backend accounts for a significant portion of inference latency. For MoE models, the MoE backend becomes the more important optimization target. We are working on a Helion MoE backend to bring Helion’s kernel optimization capabilities to these workloads and broaden model coverage.

## Conclusion

Helion’s high-level abstraction makes it possible to express and maintain a single kernel implementation while optimizing it across different workloads and hardware targets. As demonstrated by the quantized GEMM kernels in this work, even algorithmic variants such as Standard GEMM, Split-K, and Swap-AB can be unified into one implementation and exposed as tunable choices for the autotuner. Combined with per-shape fine-grained kernel tuning and hybrid dispatch, the Helion linear backend outperforms the default CUTLASS, DeepGEMM, and FlashInfer backends on Hopper GPUs across the evaluated models, delivering consistent end-to-end performance gains and throughput improvements exceeding 10% for some workloads.

These performance gains, however, come with tradeoffs. Fine-grained tuning for latency-critical kernels improves performance but increases AOT tuning effort, while shipping pre-tuned configs improves out-of-the-box usability at the cost of ongoing maintenance. This reflects the broader performance-usability-maintainability tradeoff discussed throughout this post.

Today, we ship the pre-tuned configs with our [vLLM fork](<https://github.com/redhat-et/vllm-helion>). For upstream adoption, we are exploring a different model: maintain the Helion kernels and integration framework upstream while delegating workload-specific autotuning to end users. This favors performance and maintainability over out-of-the-box usability, but Helion’s automated tuning framework makes the additional optimization step practical for performance-sensitive deployments.

## Acknowledgments

This work was supported by many contributors across the OCTO and vLLM teams at Red Hat, as well as the Helion team at Meta. In particular, we would like to thank our colleagues: Richard Zou and Jongsok Choi for their feedback and support throughout this work.

---
*Fetched by article-pipeline · 2026-10-04*
