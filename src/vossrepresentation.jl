using BioSequences
using BenchmarkTools
using Wavelets

struct BinarySequenceMatrix{A<:NucleicAcidAlphabet, B<:BitMatrix}
    alphabet::A
    bsm::B
    function BinarySequenceMatrix(sequence::SeqOrView{A}) where {A <: NucleicAcidAlphabet}
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

@inline function _sequence_binarizer(sequence::SeqOrView{A}, nucleotide::Union{DNA,RNA}) where {A <: NucleicAcidAlphabet}
    bv = BitVector(undef, length(sequence))
    @inbounds for i in eachindex(sequence)
        bv[i] = (sequence[i] == nucleotide)
    end
    return bv
end
    
@inline function _CG_binarizer(sequence::SeqOrView{DNAAlphabet{4}})
    return _sequence_binarizer(sequence, DNA_C) .| _sequence_binarizer(sequence, DNA_G) # .| is bitwise or
end

seq1 = dna"ATCTTCGATCAC"
seq2 = dna"ATCTTCGATCAA"
seq3 = dna"ATCTTCGATCAG"
seq4 = rna"AUCUUCGAUCAU"
exampleseq = dna"TACGCTAGTGCA"
dseq = randdnaseq(10^8)
rseq = randrnaseq(10^8)

xm = BinarySequenceMatrix(dseq)
xv = _sequence_binarizer(dseq, DNA_A)

@btime BinarySequenceMatrix($rseq)
@btime _sequence_binarizer(dseq, DNA_A)

wt = wavelet(WT.haar) # db2, db4, haar, coif1, bior1.3, sym2, rbio1.3

xt = dwt(xm.bsm, wt)
xt = dwt(xv, wt)

@btime dwt($xv, $wt)