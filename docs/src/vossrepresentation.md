## Voss representation

## Encoding BioSequences

This package provides a simple and fast way to encode biological sequences into Voss representation. The main struct provided by this package is `BinarySequenceMatrix` which is a wrapper of `BitMatrix` that encodes a biological sequence into a binary matrix. The following example shows how to encode a DNA sequence into a binary matrix.

```julia

julia> using BioVossEncoder

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