<div align="center">
<img src="docs/src/assets/logo.svg" height="150"><br/>
    <i>Encoding biological sequences into Voss representation</i><br/><br/>
</div>

<div align="center">

[![Documentation](https://img.shields.io/badge/documentation-online-blue.svg?logo=Julia&logoColor=white)](https://camilogarciabotero.github.io/BioVossEncoder.jl/dev/)
[![Latest Release](https://img.shields.io/github/release/camilogarciabotero/BioVossEncoder.jl.svg)](https://github.com/camilogarciabotero/BioVossEncoder.jl/releases/latest)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10452378.svg)](https://doi.org/10.5281/zenodo.10452378)
<br/>
[![CI Workflow](https://github.com/camilogarciabotero/BioVossEncoder.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/camilogarciabotero/BioVossEncoder.jl/actions/workflows/CI.yml)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/camilogarciabotero/BioVossEncoder.jl/blob/main/LICENSE)
[![Work in Progress](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Downloads](https://img.shields.io/badge/dynamic/json?url=http%3A%2F%2Fjuliapkgstats.com%2Fapi%2Fv1%2Fmonthly_downloads%2FBioVossEncoder&query=total_requests&suffix=%2Fmonth&label=Downloads)](http://juliapkgstats.com/pkg/BioVossEncoder)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

</div>

***

# BioVossEncoder

> A Julia package for encoding biological sequences into Voss representations

- Can encode DNA, RNA, and Protein sequences.
- Provides the fastest encoding of biological sequences into Voss representations (aka. OneHot vectors).
- Can handle ambiguous nucleotides and amino acids.
- Provides a simple and intuitive API for encoding biological sequences.
- Includes a dedicated type `VossEncoder` that match the `BioSequence`s types.
- Can be used for single nucletide encoding `vv = vossvector(dna"ACGT", DNA_A)`.

> [!WARNING] 
  This package uses internals from `BioSequences` and `BitMatrix` types, which might not be stable. Use with caution.


## Installation

<p>
BioVossEncoder is a &nbsp;
        <a href="https://julialang.org">
                <img src="https://raw.githubusercontent.com/JuliaLang/julia-logo-graphics/master/images/julia.ico" width="16em">
                Julia Language
        </a>
        &nbsp; package. To install BioVossEncoder,
        please <a href="https://docs.julialang.org/en/v1/manual/getting-started/">open
        Julia's interactive session (known as REPL)</a> and press <kbd>]</kbd>
        key in the REPL to use the package mode, then type the following command
</p>

```julia
pkg> add BioVossEncoder
```

## Encoding BioSequences

This package provides a simple and fast way to encode biological sequences into Voss representations. The main `struct` provided by this package is `VossEncoder` which is a wrapper of `BitMatrix` that encodes a biological sequence into a bit matrix and its corresponding alphabet. The following example shows how to encode a DNA sequence into a Voss matrix.

```julia
julia> using BioSequences, BioVossEncoder

```

```julia
julia> seq = dna"ACGT"

```

```julia
julia> VossEncoder(seq)
```

        4×4 Voss Matrix of DNAAlphabet{4}():
         1  0  0  0
         0  1  0  0
         0  0  1  0
         0  0  0  1

For simplicity the `VossEncoder` struct provides a property `bitmatrix` that returns the `BitMatrix` representation of the sequence.

```julia
julia> VossEncoder(seq).bitmatrix
```

        4×4 BitMatrix:
         1  0  0  0
         0  1  0  0
         0  0  1  0
         0  0  0  1

Similarly another function that makes use of the `VossEncoder` structure is `vossmatrix` which returns the `BitMatrix` representation of a sequence directly.

```julia
julia> vossmatrix(seq)
```
        4×4 BitMatrix:
         1  0  0  0
         0  1  0  0
         0  0  1  0
         0  0  0  1

## Creating a Voss vector of a sequence

Sometimes it proves to be useful to encode a sequence into a Voss vector representation (i.e a bit vector of the sequence from the corresponding molecule alphabet).

 This package provides a function `vossvector` that returns a Voss vector of a sequence given a `BioSequence` and the specific molecule (`BioSymbol`) that could be `DNA` or `AA`.

```julia
julia> vossvector(seq, DNA_A)
```
        4-element view(::BitMatrix, 1, :) with eltype Bool:
         1
         0
         0
         0

Note that the output is actually using behind the scenes a view of the `BitMatrix` representation of the sequence. This is done for performance reasons.

## Related Ideas

- [BioSequences.jl direct OneHot recipe](https://biojulia.dev/BioSequences.jl/stable/recipes/#One-hot-encoding-biosequences):

```julia
using BioSymbols, BioSequences

function onehot(s::NucSeq)
    M = falses(4, length(s))
    for (i, s) in enumerate(s)
        bits = compatbits(s)
        while !iszero(bits)
            M[trailing_zeros(bits) + 1, i] = true
            bits &= bits - one(bits) # clear lowest bit
        end
    end
    M
end
```

```julia
onehot(dna"TGNTKCTW-T")

4×10 BitMatrix:
 0  0  1  0  0  0  0  1  0  0
 0  0  1  0  0  1  0  0  0  0
 0  1  1  0  1  0  0  0  0  0
 1  0  1  1  1  0  1  1  0  1
```

- [Using BioMarkovChains.jl reinterpret trick](https://github.com/BioJulia/BioMarkovChains.jl/blob/87ca3c16eda91c7947ef13eaaac5066de8d91c6c/src/utils.jl#L9):


```julia
function onehot_reinterpretator(seq::BioSequence)
    seqlen = length(seq)
    modvect = Vector{Int8}(undef, seqlen)
    modifier(value) = (value == DNA_G) ? DNA_M : (value == DNA_T) ? DNA_G : value
    reinterpreter = seq -> reinterpret.(Int8, modifier.(seq))[1]
    @inbounds for i in 1:seqlen
        modvect[i] = reinterpreter(seq[i])
    end
    return 1:4 .== permutedims(modvect)
end
```

- [SequenceTokenizers.jl](https://github.com/mashu/SequenceTokenizers.jl): A Julia package for tokenizing biological sequences, providing efficient and flexible tokenization methods for various sequence types. Focused on `String` type.

```julia
function onehot_tokenizer(str::String)
    alphabet = ['A', 'C', 'G', 'T'] 
    tokenizer = SequenceTokenizer(alphabet, 'N')
    tokens = tokenizer([str]) 
    return onehot_batch(tokenizer, tokens)
end # 5×N×1 Array{Float32, 3}

```
```julia
onehot_tokenizer("ACATCAGCATC")

5×11×1 Array{Float32, 3}:
[:, :, 1] =
 0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
 1.0  0.0  1.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0  0.0
 0.0  1.0  0.0  0.0  1.0  0.0  0.0  1.0  0.0  0.0  1.0
 0.0  0.0  0.0  0.0  0.0  0.0  1.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  1.0  0.0  0.0  0.0  0.0  0.0  1.0  0.0
```

- [Fasta2onehot.jl](https://github.com/kchu25/Fasta2onehot.jl): A Julia package for converting FASTA sequences into one-hot encoded matrices.

- [A Discourse thread for OneHot for `String`](https://discourse.julialang.org/t/all-the-ways-to-do-one-hot-encoding/64807):


1. With `StatsBase.jl`

```julia
using StatsBase
function onehot_indicator(str::String)::Vector{BitVector}
    codeunits(str) |> indicatormat
end # returns 4-element Vector{BitVector}:
```

2. With `collect`: The output is a `Vector{BitVector}` which is somehow disorganized, but it is a valid one-hot encoding.

```julia
function onehot_collector(str::String)::Vector{BitVector}
    [collect(str) .== x for x ∈ ['A', 'C', 'G', 'T']]
end # retuns 4-element Vector{BitVector}:

```

3. With `permutedims` and `reinterpret`:

```julia
function onehot_permutator(seq::BioSequence)
    modifier(value) = (value == DNA_G) ? DNA_M : (value == DNA_T) ? DNA_G : value
    reinterpreter = seq -> reinterpret.(Int8, modifier.(seq))[1]
    return 1:4 .== permutedims(reinterpreter.(seq))
end
```

A more efficient version of the previous function is the following: With `codeunits` and `permutedims`:

```julia
       
function onehot_codeunits(str::String)
                # A     C     G     T  
    return UInt8[0x41, 0x43, 0x47, 0x54] .== permutedims(codeunits(str))
end
```

## Benchmarks

```julia
using BenchmarkTools

str = rand(codeunits("ACGT"),10^6) |> String
seq = randdnaseq(10^6)

# VossEncoder.jl
@btime vossmatrix($seq); # 32.056 μs (4 allocations: 488.42 KiB)

# Others
@btime onehot($seq); # 4.408 ms (4 allocations: 488.42 KiB)
@btime onehot_codeunits($str); # 8.124 ms (6 allocations: 488.48 KiB)
@btime onehot_reinterpretator($seq); # 10.140 ms (7 allocations: 1.43 MiB)
@btime onehot_permutator(seq); # 9.670 ms (10 allocations: 2.38 MiB)
@time onehot_indicator($str); # 17.413 ms (14 allocations: 3.82 MiB)
@btime onehot_collector($str); # 12.659 ms (32 allocations: 15.74 MiB)
@btime onehot_tokenizer(str) # 22.816 ms (19 allocations: 26.70 MiB)
```

```julia
versioninfo()

Julia Version 1.11.1
Commit 8f5b7ca12ad (2024-10-16 10:53 UTC)
Build Info:
  Official https://julialang.org/ release
Platform Info:
  OS: macOS (x86_64-apple-darwin22.4.0)
  CPU: 8 × Intel(R) Core(TM) i5-8257U CPU @ 1.40GHz
  WORD_SIZE: 64
  LLVM: libLLVM-16.0.6 (ORCJIT, skylake)
Threads: 1 default, 0 interactive, 1 GC (on 8 virtual cores)
```

