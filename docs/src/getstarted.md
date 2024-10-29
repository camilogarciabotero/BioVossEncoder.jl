
## Installation


To get started with BioVossEncoder, you need to install it first. You can do this using Julia's package manager. Open Julia's REPL and run the following command:

```julia
using Pkg
Pkg.add("BioVossEncoder")
```

Once installed, you can use the `vossmatrix` function to generate a Voss matrix from a DNA sequence. Here is an example:

```julia
julia> using BioVossEncoder

julia> seq = "ACGT"
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
