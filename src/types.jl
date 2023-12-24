"""
    struct BinarySequenceMatrix{A<:NucleicAcidAlphabet, B<:BitMatrix}

The `BinarySequenceMatrix` struct represents a binary matrix encoding a sequence of nucleic acids.

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
            if eltype(sequence) == DNA
                bsm[4, i] = (nucleotide == DNA_T)
            elseif eltype(sequence) == RNA
                bsm[4, i] = (nucleotide == RNA_U)
            else
                error("Unsupported sequence type")
            end
        end
        return new{NucleicAcidAlphabet, BitMatrix}(Alphabet(sequence), bsm)
    end
end

const BSM = BinarySequenceMatrix
@testitem "BSM" begin
    using BioSequences

    seq01 = dna"TACGCTAGTGCA"

    bsm = BinarySequenceMatrix(seq01)
    bsm.alphabet == DNA
    @test bsm.bsm == Bool[0 1 0 0 0 0 1 0 0 0 0 1; 0 0 1 0 1 0 0 0 0 0 1 0; 0 0 0 1 0 0 0 1 0 1 0 0; 1 0 0 0 0 1 0 0 1 0 0 0]
end