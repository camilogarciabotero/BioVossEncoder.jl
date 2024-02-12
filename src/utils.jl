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

"""
function vossmatrix(VE::VossEncoder{A, B}) where {A <: NucleicAcidAlphabet, B <: BitMatrix}
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