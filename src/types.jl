const AA20 = (AA_A, AA_C, AA_D, AA_E, AA_F, AA_G, AA_H, AA_I, AA_K, AA_L, AA_M, AA_N, AA_P, AA_Q, AA_R, AA_S, AA_T, AA_V, AA_W, AA_Y)

"""
    struct BinarySequenceMatrix{A<:NucleicAcidAlphabet, B<:BitMatrix}

The `BinarySequenceMatrix` struct represents a binary matrix encoding a sequence of nucleic acids. This is also called the Voss representation of a sequence.

# Fields
- `alphabet::A`: The nucleic acid alphabet used for encoding.
- `bsm::B`: The binary matrix representing the encoded sequence.

# Constructors
- `BinarySequenceMatrix(sequence::SeqOrView{A})`: Constructs a `BinarySequenceMatrix` from a sequence of nucleic acids.

## Arguments
- `sequence::SeqOrView{A}`: The sequence of nucleic acids to be encoded.

"""
struct BinarySequenceMatrix{A<:Alphabet, B<:BitMatrix}
    alphabet::A
    bsm::B

    function BinarySequenceMatrix(alphabet::A, bsm::B) where {A <: Alphabet, B <: BitMatrix}
        return new{NucleicAcidAlphabet, BitMatrix}(alphabet, bsm)
    end

    function BinarySequenceMatrix(sequence::SeqOrView{A}) where {A <: NucleicAcidAlphabet} # NucleicSeqOrView
        bsm = BitMatrix(undef, 4, length(sequence))
        seqtype = eltype(sequence)
        @inbounds for i in eachindex(sequence)
            nucleotide = sequence[i]
            bsm[1, i] = (nucleotide == DNA_A)
            bsm[2, i] = (nucleotide == DNA_C)
            bsm[3, i] = (nucleotide == DNA_G)
            bsm[4, i] = seqtype == DNA ? (nucleotide == DNA_T) : seqtype == RNA ? (nucleotide == RNA_U) : error("Unsupported sequence type")
        end
        return new{Alphabet, BitMatrix}(Alphabet(sequence), bsm)
    end

    function BinarySequenceMatrix(sequence::SeqOrView{AminoAcidAlphabet}) # AminoAcidSequence
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
        return new{Alphabet, BitMatrix}(Alphabet(sequence), bsm)
    end
end

const BSM = BinarySequenceMatrix