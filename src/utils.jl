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