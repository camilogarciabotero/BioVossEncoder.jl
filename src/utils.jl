"""
    sequence_binarizer(sequence::SeqOrView{A}, nucleotide::Union{DNA,RNA}) where {A <: NucleicAcidAlphabet}

Converts a sequence of nucleotides into a binary representation.

# Arguments
- `sequence::SeqOrView{A}`: The input sequence of nucleotides.
- `nucleotide::Union{DNA,RNA}`: The nucleotide to be encoded as 1, while others are encoded as 0.

# Returns
A `BitVector` representing the binary encoding of the input sequence, where 1 indicates the presence of the specified nucleotide and 0 indicates the absence.

"""
@inline function sequence_binarizer(sequence::SeqOrView{A}, nucleotide::Union{DNA,RNA}) where {A <: NucleicAcidAlphabet}
    bv = BitVector(undef, length(sequence))
    @inbounds for i in eachindex(sequence)
        bv[i] = (sequence[i] == nucleotide)
    end
    return bv
end

"""
    binary_sequence_matrix(sequence::SeqOrView{A}) where {A <: NucleicAcidAlphabet}

Create a binary sequence matrix from a given nucleic acid sequence.

# Arguments
- `sequence`: A nucleic acid sequence.

# Returns
The binary sequence matrix.

"""
function binary_sequence_matrix(sequence::SeqOrView{A}) where {A <: NucleicAcidAlphabet}
    return BSM(sequence).bsm
end