export vossvector, vossmatrix, pfm

#                         A,    C,    G,    T
const dnauint8 = UInt8[0x41, 0x43, 0x47, 0x54]
#                         A,    C,    G,    U
const rnauint8 = UInt8[0x41, 0x43, 0x47, 0x55]

#                       A,    R,    N,    D,     C,    Q,   E,    G,    H,    I,    L,    K,    M,    F,    P,    S,    T,    W,    Y,    V
const aauint8 = UInt8[0x41, 0x52, 0x4E, 0x44, 0x43, 0x51, 0x45, 0x47, 0x48, 0x49, 0x4C, 0x4B, 0x4D, 0x46, 0x50, 0x53, 0x54, 0x57, 0x59, 0x56]



"""
    vossvector(seq::NucleicSeqOrView{A}, molecule::T) where {A <: NucleicAcidAlphabet, T <: BioSymbol}
    vossvector(seq::SeqOrView{AminoAcidAlphabet}, molecule::T) where {T <: BioSymbol}
    vossvector(seq::SeqOrView{A}, molecules::Tuple{Vararg{T}}) where {A <: Alphabet, T <: BioSymbol}

Converts a sequence of nucleotides into a binary representation.

# Arguments
- `seq::SeqOrView{A}`: The input sequence of nucleotides.
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
function vossvector(seq::NucleicSeqOrView{A}, molecule::T) where {A <: NucleicAcidAlphabet, T <: BioSymbol} # $dseq .=== DNA_A
    @assert typeof(molecule) == eltype(seq) "Input sequence and molecules must be of the same element type."
    
    if seq isa LongSubSeq
        @warn "The input sequence is a view, the return size of the matrix correspond to the view window."
    end

    convseq = if eltype(seq) == DNA
        seq isa LongDNA{4} ? seq : convert(LongDNA{4}, seq)
    else
        seq isa LongRNA{4} ? seq : convert(LongRNA{4}, seq)
    end

    bm = BitMatrix(undef, 4, length(convseq))
    copy!(bm.chunks, convseq.data)

    if molecule in ACGT
        return @view bm[findfirst(x -> x == molecule, ACGT), :]
    elseif molecule == RNA_U
        return @view bm[4, :]
    else
        error("Unsupported molecule type.")
    end
end

function vossvector(seq::SeqOrView{AminoAcidAlphabet}, molecule::T) where {T <: BioSymbol}
    @assert typeof(molecule) == eltype(seq) "Input sequence and molecules must be of the same element type."
    return seq .== molecule
end

# TODO: correct the fail of the argument bounds check from Aqua tests
function vossvector(seq::SeqOrView{A}, molecules::Tuple{Vararg{T}}) where {A <: Alphabet, T <: BioSymbol}
    @assert eltype(molecules) == eltype(seq) "Input sequence and molecules must be of the same element type."
    bv = BitVector(undef, length(seq))
    for molecule in molecules
        bv .|= vossvector(seq, molecule)
    end
    return bv
end

"""
    vossmatrix(VossEncoder::VossEncoder{A, B}) where {A <: NucleicAcidAlphabet, B <: BitMatrix}
    vossmatrix(seq::NucleicSeqOrView{A}) where {A <: NucleicAcidAlphabet}
    vossmatrix(seq::SeqOrView{AminoAcidAlphabet}) where {A <: AminoAcidAlphabet}

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
function vossmatrix(ve::VossEncoder{A}) where {A <: Alphabet}
    return ve.bitmatrix
end

function vossmatrix(seq::NucleicSeqOrView{A}) where {A <: NucleicAcidAlphabet}

    if seq isa LongSubSeq
        @warn "The input sequence is a view, the return size of the matrix correspond to the view window."
    end

    convseq = if eltype(seq) == DNA
        seq isa LongDNA{4} ? seq : convert(LongDNA{4}, seq)
    else
        seq isa LongRNA{4} ? seq : convert(LongRNA{4}, seq)
    end

    bm = BitMatrix(undef, 4, length(convseq))
    copy!(bm.chunks, convseq.data)

    return bm
end

function vossmatrix(seq::SeqOrView{AminoAcidAlphabet})
   bm = BitMatrix(undef, 20, length(seq))
   @inbounds for i in 1:20
       bm[i,:] = seq .== AA20[i]
   end
   return bm
end

# function vossmatrix(str::String)
#     return vossmatrix(bioseq(str))    
# end


#### -- String support -- ####

function vossvector(str::String, molecule::Char)::BitVector
    
    uintmol = UInt8(molecule)
    @assert uintmol in vcat(dnauint8, rnauint8, aauint8) "The molecule must be a valid nucleotide or amino acid."
    
    stralphabet = guess_alphabet(str)
    @assert stralphabet isa Alphabet "The input sequence must be in a DNA, RNA or Amino Acid alphabet."
    
    # molalphabettype = if uintmol in dnauint8
    #     DNA
    # elseif uintmol in rnauint8
    #     RNA
    # elseif uintmol in aauint8
    #     AminoAcid
    # else 
    #     error("Unsupported molecule type.")
    # end
    # @assert eltype(stralphabet) == molalphabettype "The molecule must be of the same type as the input sequence."

    return uintmol .== permutedims(codeunits(str), 1)

end


function vossmatrix(str::String)::BitMatrix

    # @warn "The input sequence is a string. Consider using a BioSequence type as the dispatched method is faster."

    guessedalphabet = guess_alphabet(str)

    onehot = if guessedalphabet == DNAAlphabet{2}() #|| guessedalphabet == DNAAlphabet{4}()
        dnauint8 .== permutedims(codeunits(str))
    elseif guessedalphabet == RNAAlphabet{2}() #|| guessedalphabet == RNAAlphabet{4}()
        rnauint8 .== permutedims(codeunits(str))
    elseif guessedalphabet == AminoAcidAlphabet()
        aauint8 .== permutedims(codeunits(str))
    else
        error("Unsupported alphabet type. Make sure the provided sequence don't present any ambiguous character.")
    end

    return onehot
end


#### ---- end of string support ---- ####

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

