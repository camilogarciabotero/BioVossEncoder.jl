## Voss representation

A Voss representation of a biological sequence is a binary matrix that encodes the sequence. The Voss representation of a sequence is obtained by encoding the sequence into a binary matrix where each column of the matrix represents a position in the sequence and each row represents a symbol in the alphabet.

For example, the Voss representation of the sequence `ACGT` is the following matrix:

```math
\begin{bmatrix}
\text{A} & 1 & 0 & 0 & 0 \\
\text{C} & 0 & 1 & 0 & 0 \\
\text{G} & 0 & 0 & 1 & 0 \\
\text{T} & 0 & 0 & 0 & 1 \\
\end{bmatrix}
```

In this case the alphabet chosen is the DNA alphabet, but the same representation can be used for any alphabet. In this package we focused on the DNA and RNA alphabets.

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

    4×4 BinarySequenceMatrix of DNAAlphabet{4}():
      1  0  0  0
      0  1  0  0
      0  0  1  0
      0  0  0  1

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

## Creating a one-hot vector of a sequence

Sometimes it proves to be useful to encode a sequence into a one-hot representation. This package provides a function `binaryseq` that returns a one-hot representation of a sequence given a `BioSequence` and the specific molecule (`BioSymbol`) that could be `DNA` or `AA`.

```julia
julia> binaryseq(seq, DNA_A)
```
    4-element view(::BitMatrix, 1, :) with eltype Bool:
     1
     0
     0
     0

Note that the output is actually using behind the scenes a view of the `BitMatrix` representation of the sequence. This is done for performance reasons.