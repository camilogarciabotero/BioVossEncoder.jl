
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

