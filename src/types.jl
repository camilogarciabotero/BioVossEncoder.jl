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
struct BinarySequenceMatrix{A<:NucleicAcidAlphabet, B<:BitMatrix}
    alphabet::A
    bsm::B
    function BinarySequenceMatrix(sequence::SeqOrView{A}) where {A <: NucleicAcidAlphabet} # NucleicSeqOrView
        bsm = BitMatrix(undef, 4, length(sequence))
        @inbounds for i in eachindex(sequence)
            nucleotide = sequence[i]
            bsm[1, i] = (nucleotide == DNA_A)
            bsm[2, i] = (nucleotide == DNA_C)
            bsm[3, i] = (nucleotide == DNA_G)
            bsm[4, i] = eltype(sequence) == DNA ? (nucleotide == DNA_T) : eltype(sequence) == RNA ? (nucleotide == RNA_U) : error("Unsupported sequence type")
        end
        return new{NucleicAcidAlphabet, BitMatrix}(Alphabet(sequence), bsm)
    end
end

const BSM = BinarySequenceMatrix

@testitem "BSM" begin
    using BioSequences, BioVossEncoder

    seq01 = dna"TACGCTAGTGCA"

    bsm = BinarySequenceMatrix(seq01)
    bsm.alphabet == DNA
    @test bsm.bsm == Bool[0 1 0 0 0 0 1 0 0 0 0 1; 0 0 1 0 1 0 0 0 0 0 1 0; 0 0 0 1 0 0 0 1 0 1 0 0; 1 0 0 0 0 1 0 0 1 0 0 0]
end