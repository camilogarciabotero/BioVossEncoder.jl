<div align="center">
  <img src="docs/src/assets/logo.svg" height="150"><br/>
  <i>Encoding biological sequences into Voss representation</i><br/><br/>
</div>

<div align="center">

[![Documentation](https://img.shields.io/badge/documentation-online-blue.svg?logo=Julia&logoColor=white)](https://camilogarciabotero.github.io/BioVossEncoder.jl/dev/)
[![Latest Release](https://img.shields.io/github/release/camilogarciabotero/BioVossEncoder.jl.svg)](https://github.com/camilogarciabotero/BioVossEncoder.jl/releases/latest)
[![DOI](https://zenodo.org/badge/665161607.svg)](https://zenodo.org/badge/latestdoi/665161607)
<br/>
[![CI Workflow](https://github.com/camilogarciabotero/BioVossEncoder.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/camilogarciabotero/BioVossEncoder.jl/actions/workflows/CI.yml)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/camilogarciabotero/BioVossEncoder.jl/blob/main/LICENSE)
[![Work in Progress](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Downloads](https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/BioVossEncoder&label=downloads)](https://pkgs.genieframework.com?packages=BioVossEncoder)

</div>

***

# BioVossEncoder

> A Julia package for encoding biological sequences into Voss representation

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

This package provides a simple and fast way to encode biological sequences into Voss representation. The main struct provided by this package is `BinarySequenceMatrix` which is a wrapper of `BitMatrix` that encodes a biological sequence into a binary matrix. The following example shows how to encode a DNA sequence into a binary matrix.

```julia
julia> using BioSequences, BioVossEncoder

```

```julia
julia> seq = dna"ACGT"

```

```julia
julia> BinarySequenceMatrix(seq)
```

    BinarySequenceMatrix{NucleicAcidAlphabet, BitMatrix}(DNAAlphabet{4}(), Bool[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1])

For simplicity the `BinarySequenceMatrix` struct provides a property `bsm` that returns the `BitMatrix` representation of the sequence.

```julia
julia> BinarySequenceMatrix(seq).bsm
```

    4×4 BitMatrix:
     1  0  0  0
     0  1  0  0
     0  0  1  0
     0  0  0  1

Similarly another function that makes use of the `BinarySequenceMatrix` struct is `binary_sequence_matrix` which returns the `BitMatrix` representation of a sequence directly.

```julia
julia> binary_sequence_matrix(seq)
```

    4×4 BitMatrix:
     1  0  0  0
     0  1  0  0
     0  0  1  0
     0  0  0  1