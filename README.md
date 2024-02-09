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
[![Downloads](https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/BioVossEncoder&label=downloads)](https://pkgs.genieframework.com?packages=BioVossEncoder)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

</div>

***

# BioVossEncoder

> A Julia package for encoding biological sequences into Voss representations

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
julia> using BioSequences, VossEncoder

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

 This package provides a function `vossvector` that returns a one-hot representation of a sequence given a `BioSequence` and the specific molecule (`BioSymbol`) that could be `DNA` or `AA`.

```julia
julia> vossvector(seq, DNA_A)
```
    4-element view(::BitMatrix, 1, :) with eltype Bool:
     1
     0
     0
     0

Note that the output is actually using behind the scenes a view of the `BitMatrix` representation of the sequence. This is done for performance reasons.