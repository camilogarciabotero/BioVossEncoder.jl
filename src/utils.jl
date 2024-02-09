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

# function vossvector(sequence::SeqOrView{A}, molecule::T) where {A <: AminoAcidAlphabet, T <: BioSymbol} # $dseq .=== DNA_A
#     @assert typeof(molecule) == eltype(sequence) "Input sequence and molecules must be of the same element type."
#     bm = BitMatrix(undef, 20, length(sequence))
#     copy!(bm.chunks, sequence.data)
#     if molecule in AA20
#         return @view bm[findfirst(x -> x == molecule, AA20), :]
#     else
#         error("Unsupported molecule type.")
#     end
# end

# function vossvector(sequence::SeqOrView{A}, molecule::T) where {A <: Alphabet, T <: BioSymbol} # $dseq .=== DNA_A
#     @assert typeof(molecule) == eltype(sequence) "Input sequence and molecules must be of the same element type."
#     seqlen = length(sequence)
#     bv = BitVector(undef, seqlen)
#     # acc = zero(UInt64)
#     # bv .= (sequence .== molecule)
#     @inbounds for i in 1:seqlen
#         bv[i] = (sequence[i] == molecule)
#         # acc = (acc << 1) | (sequence[i] == molecule)
#     end
#     return bv
# end

# function vossvector(s::SeqOrView{A}) where {A <: NucleicAcidAlphabet}
#     M = BitMatrix(undef, 4, length(s))
#     copy!(M.chunks, s.data)
#     return M
# end

# function vossvector(s::SeqOrView{A}) where {A <: AminoAcidAlphabet}
#     M = BitMatrix(undef, 20, length(s))
#     copy!(M.chunks, s.data)
#     return M
# end

# function vossvector(s::NucSeq)
#     M = falses(4, length(s))
#     for (i, s) in enumerate(s)
#         bits = compatbits(s)
#         while !iszero(bits)
#             M[trailing_zeros(bits) + 1, i] = true
#             bits &= bits - one(bits)
#         end
#     end
#     M
# end

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

# function vossmatrix(sequence::SeqOrView{AminoAcidAlphabet})
#     bm = BitMatrix(undef, 20, length(sequence))
#     copy!(bm.chunks, sequence.data)
#     return bm
# end

# function vossmatrix(sequence::SeqOrView{A}) where {A <: NucleicAcidAlphabet}
#     seqtype = eltype(sequence)
#     seqlen = length(sequence)
#     VE = BitMatrix(undef, 4, seqlen)
#     @inbounds for i in 1:seqlen
#         nucleotide = sequence[i]
#         VE[1, i] = (nucleotide == DNA_A)
#         VE[2, i] = (nucleotide == DNA_C)
#         VE[3, i] = (nucleotide == DNA_G)
#         VE[4, i] = seqtype == DNA ? (nucleotide == DNA_T) : seqtype == RNA ? (nucleotide == RNA_U) : error("Unsupported sequence type")
#     end
#     return VE
# end

# function vossmatrix(sequence::SeqOrView{AminoAcidAlphabet})
#     seqlen = length(sequence)
#     VE = BitMatrix(undef, 20, length(sequence))
#     @inbounds for i in i:seqlen
#         aminoacid = sequence[i]
#         # aminoacid = sequence[i] in AA20 ? sequence[i] : error("Unknown amino acid in position $(findall(sequence[i], sequence)).")
#         # aminoacid ∉ AA20 error("Unknown amino acid in position $(findall(aminoacid, sequence)).")
#         @assert aminoacid != AA_Term "Stop codons in position $(findall(AA_Term, sequence)). Stop codons are not supported."
#         @assert aminoacid != AA_Gap "Gap in position $(findall(AA_Gap, sequence)). Gaps are not supported."
#         @inbounds for j in 1:20
#             VE[j, i] = (aminoacid == AA20[j])
#         end
#     end
#     return VE
# end

# function vossvectormatrix(sequence::SeqOrView{A}) where {A <: Alphabet}
#     seqtype = eltype(sequence)
#     if seqtype == DNA || seqtype == RNA
#         VE = BitMatrix(undef, 4, length(sequence))
#         @inbounds for i in eachindex(ACGT)
#             VE[i, :] = vossvector(sequence, ACGT[i])
#         end
#     end
#     return VE 
# end