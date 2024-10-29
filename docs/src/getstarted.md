
## Installation


You can install BioMarkovChains from the julia REPL. Press ] to enter pkg mode, and enter the following:

```julia
] add BioVossEncoder
```


## Create a Voss matrix from a DNA sequence

Once installed, you can use the `vossmatrix` function to generate a Voss matrix from a DNA sequence. Here is an example:

```julia
julia> using BioSequences, BioVossEncoder

julia> seq = dna"ACGT"
julia> vossmatrix(seq)
```

This will produce the following 4×4 BitMatrix:

```   
4×4 BitMatrix:
 1  0  0  0
 0  1  0  0
 0  0  1  0
 0  0  0  1
```