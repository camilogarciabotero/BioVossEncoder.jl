export vossvector, vossmatrix, pfm

"""
    vossvector(sequence::NucleicSeqOrView{A}, molecule::T) where {A <: NucleicAcidAlphabet, T <: BioSymbol}
    vossvector(sequence::SeqOrView{AminoAcidAlphabet}, molecule::T) where {T <: BioSymbol}
    vossvector(sequence::SeqOrView{A}, molecules::Tuple{Vararg{T}}) where {A <: Alphabet, T <: BioSymbol}

Converts a sequence of nucleotides into a binary representation.

# Arguments
- `sequence::SeqOrView{A}`: The input sequence of nucleotides.
- `molecule::BioSymbol`: The nucleotide to be encoded as 1, while others are encoded as 0.
- `molecules::Tuple{Vararg{T}}`: The nucleotides to be encoded as 1, while others are encoded as 0.

# Returns
A `BitVector` representing the binary encoding of the input sequence, where 1 indicates the presence of the specified nucleotide and 0 indicates the absence in the ith position of the sequence.


# Examples

```julia
julia> vossvector(dna"ACGT", DNA_A)

    4-element view(::BitMatrix, 1, :) with eltype Bool:
     1
     0
     0
     0
```
"""
function vossvector(sequence::NucleicSeqOrView{A}, molecule::T) where {A <: NucleicAcidAlphabet, T <: BioSymbol} # $dseq .=== DNA_A
    @assert typeof(molecule) == eltype(sequence) "Input sequence and molecules must be of the same element type."
    bm = BitMatrix(undef, 4, length(sequence))
    copy!(bm.chunks, sequence.data)
    if molecule in ACGT
        return @view bm[findfirst(x -> x == molecule, ACGT), :]
    elseif molecule == RNA_U
        return @view bm[4, :]
    else
        error("Unsupported molecule type.")
    end
end

function vossvector(sequence::SeqOrView{AminoAcidAlphabet}, molecule::T) where {T <: BioSymbol}
    @assert typeof(molecule) == eltype(sequence) "Input sequence and molecules must be of the same element type."
    return sequence .== molecule
end

# TODO: correct the fail of the argument bounds check from Aqua tests
function vossvector(sequence::SeqOrView{A}, molecules::Tuple{Vararg{T}}) where {A <: Alphabet, T <: BioSymbol}
    @assert eltype(molecules) == eltype(sequence) "Input sequence and molecules must be of the same element type."
    bv = BitVector(undef, length(sequence))
    for molecule in molecules
        bv .|= vossvector(sequence, molecule)
    end
    return bv
end

"""
    vossmatrix(VossEncoder::VossEncoder{A, B}) where {A <: NucleicAcidAlphabet, B <: BitMatrix}
    vossmatrix(sequence::NucleicSeqOrView{A}) where {A <: NucleicAcidAlphabet}
    vossmatrix(sequence::SeqOrView{AminoAcidAlphabet}) where {A <: AminoAcidAlphabet}

Create a binary sequence matrix from a given nucleic acid sequence.

# Arguments
- `sequence`: A nucleic acid sequence.

# Returns
The binary sequence matrix.

# Examples

```julia
julia> vossmatrix(aa"IANRMWRDTIED")

    20×12 BitMatrix:
    0  1  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  1  0  0  0  1
    0  0  0  0  0  0  0  0  0  0  1  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    1  0  0  0  0  0  0  0  0  1  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  1  0  0  0  0  0  0  0
    0  0  1  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  1  0  0  1  0  0  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  1  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  1  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  0  0  0  0
```
"""
function vossmatrix(VE::VossEncoder{A}) where {A <: NucleicAcidAlphabet}
    return VossEncoder(VE).bitmatrix
end

function vossmatrix(sequence::NucleicSeqOrView{A}) where {A <: NucleicAcidAlphabet}
    bm = BitMatrix(undef, 4, length(sequence))
    copy!(bm.chunks, sequence.data)
    return bm
end

function vossmatrix(sequence::SeqOrView{AminoAcidAlphabet})
   bm = BitMatrix(undef, 20, length(sequence))
   for i in 1:20
       bm[i,:] = sequence .== AA20[i]
   end
   return bm
end

"""
    pfm(v::Vector{T}) where {T <: SeqOrView{<:Alphabet}}

Calculate the position frequency matrix (PFM) for a given vector of sequences or sequence views.

# Arguments
- `v::Vector{T}`: A vector of sequences or sequence views, where each element is of type `T` which is a subtype of `SeqOrView` parameterized by an `Alphabet`.

# Returns
- A matrix representing the position frequency matrix (PFM) of the input sequences.

# Details
- The function first creates a copy of the input vector `v`.
- It then determines the sequence with the maximum length (`vmax`) and removes it from the vector.
- The function computes the Voss matrix for each sequence in the vector.
- Finally, it sums the Voss matrices and returns the result as the position frequency matrix.

"""
function pfm(v::Vector{T}) where {T <: SeqOrView{<:Alphabet}}
    vc = copy(v)
    vmax =  all(i -> length(i) == length(vc[1]), vc) ? popat!(vc, 1) : popat!(vc, findmax(length, v)[2])
    vs = vossmatrix.(v)
    return map!(+, Int64.(vossmatrix(vmax)), vs...) # m
end