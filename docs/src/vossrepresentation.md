## Voss representation

A Voss representation of a biological sequence is a binary matrix that encodes the sequence. The Voss representation of a sequence is obtained by encoding the sequence into a binary matrix where each column of the matrix represents a position in the sequence and each row represents a symbol in the alphabet (Voss, 1992). Formally, given a sequence ``S`` of length ``n`` and an alphabet ``\mathscr{A}`` of size ``m``, the Voss matrix of ``S`` is a ``m \times n`` binary matrix ``M`` such that ``M_{i,j} = 1`` if the ``j^{th}`` position of the sequence ``S`` contains the ``i^{th}`` symbol of the alphabet ``\mathscr{A}`` and ``M_{i,j} = 0`` otherwise.


For example, the Voss matrix of the sequence ``ACGT`` is the following matrix:

```math
\begin{bmatrix}
\text{A} & 1 & 0 & 0 & 0 \\
\text{C} & 0 & 1 & 0 & 0 \\
\text{G} & 0 & 0 & 1 & 0 \\
\text{T} & 0 & 0 & 0 & 1 \\
\end{bmatrix}
```

In this case the alphabet chosen is the DNA alphabet, but the same representation can be used for other alphabets.

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

 This package provides a function `vossvector` that returns Voss vector of a sequence given a `BioSequence` and the specific molecule (`BioSymbol`) that could be `DNA` or `AA`.

```julia
julia> vossvector(seq, DNA_A)
```
    4-element view(::BitMatrix, 1, :) with eltype Bool:
     1
     0
     0
     0

Note that the output is actually using behind the scenes a view of the `BitMatrix` representation of the sequence. This is done for performance reasons.

## References

Voss, R. F. Evolution of long-range fractal correlations and 1/ f noise in DNA base sequences. Phys. Rev. Lett. 68, 3805–3808 (1992).
