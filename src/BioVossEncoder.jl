module BioVossEncoder

using BioSequences:
    SeqOrView,

    NucleicAcidAlphabet,
    DNA,
    DNAAlphabet,
    RNA,
    RNAAlphabet,
    Alphabet,
    randdnaseq,
    DNA_A,
    DNA_C,
    DNA_G,
    DNA_T,
    RNA_U

using PrecompileTools: @setup_workload, @compile_workload

include("types.jl")
export BinarySequenceMatrix, BSM

include("utils.jl")
export binary_sequence_matrix, sequence_binarizer

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