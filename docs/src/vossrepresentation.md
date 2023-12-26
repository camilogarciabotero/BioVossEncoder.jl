## Voss representation

## Encoding BioSequences

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

```julia

julia> BinarySequenceMatrix(seq).bsm

```

    4×4 BitMatrix:
     1  0  0  0
     0  1  0  0
     0  0  1  0
     0  0  0  1

