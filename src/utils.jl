"""
    binaryseq(sequence::SeqOrView{A}, molecule::Union{DNA,RNA}) where {A <: Alphabet}
    binaryseq(sequence::SeqOrView{A}, molecule::Tuple{T}) where {A <: Alphabet, T <: BioSymbol}


Converts a sequence of nucleotides into a binary representation.

# Arguments
- `sequence::SeqOrView{A}`: The input sequence of nucleotides.
- `molecule::BioSymbol: The nucleotide to be encoded as 1, while others are encoded as 0.
- `molecules::Tuple{Vararg{T}}`: The nucleotides to be encoded as 1, while others are encoded as 0.

# Returns
A `BitVector` representing the binary encoding of the input sequence, where 1 indicates the presence of the specified nucleotide and 0 indicates the absence.

"""
function binaryseq(sequence::SeqOrView{A}, molecule::T) where {A <: Alphabet, T <: BioSymbol}
    @assert typeof(molecule) == eltype(sequence) "Input sequence and molecules must be of the same element type."
    bv = BitVector(undef, length(sequence))
    @inbounds for i in eachindex(sequence)
        bv[i] = (sequence[i] == molecule)
    end
    return bv
end

function binaryseq(sequence::SeqOrView{A}, molecules::Tuple{Vararg{T}}) where {A <: Alphabet, T <: BioSymbol}
    @assert eltype(molecules) == eltype(sequence) "Input sequence and molecules must be of the same element type."
    bv = BitVector(undef, length(sequence))
    @inbounds for molecule in molecules
        bv .|= binaryseq(sequence, molecule)
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
function binary_sequence_matrix(sequence::SeqOrView{A}) where {A <: Alphabet}
    return BSM(sequence).bsm
end

function binary_sequence_matrix(sequence::SeqOrView{A}) where {A <: NucleicAcidAlphabet}
    seqtype = eltype(sequence)
    bsm = BitMatrix(undef, 4, length(sequence))
    @inbounds for i in eachindex(sequence)
        nucleotide = sequence[i]
        bsm[1, i] = (nucleotide == DNA_A)
        bsm[2, i] = (nucleotide == DNA_C)
        bsm[3, i] = (nucleotide == DNA_G)
        bsm[4, i] = seqtype == DNA ? (nucleotide == DNA_T) : seqtype == RNA ? (nucleotide == RNA_U) : error("Unsupported sequence type")
    end
    return bsm
end

function binary_sequence_matrix(sequence::SeqOrView{AminoAcidAlphabet})
    bsm = BitMatrix(undef, 20, length(sequence))
    @inbounds for i in eachindex(sequence)
        aminoacid = sequence[i]
        # aminoacid = sequence[i] in AA20 ? sequence[i] : error("Unknown amino acid in position $(findall(sequence[i], sequence)).")
        # aminoacid ∉ AA20 error("Unknown amino acid in position $(findall(aminoacid, sequence)).")
        @assert aminoacid != AA_Term "Stop codons in position $(findall(AA_Term, sequence)). Stop codons are not supported."
        @assert aminoacid != AA_Gap "Gap in position $(findall(AA_Gap, sequence)). Gaps are not supported."
        @inbounds for j in 1:20
            bsm[j, i] = (aminoacid == AA20[j])
        end
    end
    return bsm
end

# function binaryseqmatrix(sequence::SeqOrView{A}) where {A <: Alphabet}
#     seqtype = eltype(sequence)
#     if seqtype == DNA || seqtype == RNA
#         bsm = BitMatrix(undef, 4, length(sequence))
#         @inbounds for i in eachindex(ACGT)
#             bsm[i, :] = binaryseq(sequence, ACGT[i])
#         end
#     end
#     return bsm 
# end