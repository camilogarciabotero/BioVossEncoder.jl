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
        return new{Alphabet, BitMatrix}(alphabet, bsm)
    end

    function BinarySequenceMatrix(sequence::NucleicSeqOrView{A}) where {A <: NucleicAcidAlphabet} # NucleicSeqOrView
        return new{Alphabet, BitMatrix}(Alphabet(sequence), binary_sequence_matrix(sequence))
    end

    function BinarySequenceMatrix(sequence::SeqOrView{AminoAcidAlphabet}) # AminoAcidSequence
        return new{Alphabet, BitMatrix}(Alphabet(sequence), binary_sequence_matrix(sequence))
    end
end

const BSM = BinarySequenceMatrix