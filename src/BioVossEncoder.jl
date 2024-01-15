module BioVossEncoder

using BioSymbols: BioSymbol, compatbits

using BioSequences:
    SeqOrView,
    LongSequence,
    NucSeq,
    LongSequence,

    Alphabet,
    NucleicAcidAlphabet,
    DNA,
    DNAAlphabet,
    RNA,
    RNAAlphabet,
    AminoAcidAlphabet,
    AminoAcid,
    AA_A, AA_C, AA_D, AA_E, AA_F, AA_G, AA_H, AA_I, AA_K, AA_L, AA_M, AA_N, AA_P, AA_Q, AA_R, AA_S, AA_T, AA_V, AA_W, AA_Y, AA_Term, AA_Gap,
    randdnaseq,
    DNA_A,
    DNA_C,
    DNA_G,
    DNA_T,
    RNA_U,
    ACGT

using PrecompileTools: @setup_workload, @compile_workload

include("types.jl")
export BinarySequenceMatrix, BSM, AA20

include("utils.jl")
export binaryseq, binary_sequence_matrix

include("extended.jl")

@setup_workload begin
    # Putting some things in `@setup_workload` instead of `@compile_workload` can reduce the size of the
    # precompile file and potentiall y make loading faster.
    seq = randdnaseq(10)
    @compile_workload begin
        # all calls in this block will be precompiled, regardless of whether
        # they belong to your package or not (on Julia 1.8 and higher)
        BinarySequenceMatrix(seq)
    end
end

end # end module BioVossEncoder