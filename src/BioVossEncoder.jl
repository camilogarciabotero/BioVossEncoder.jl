module BioVossEncoder

using BioSequences:
    SeqOrView,

    NucleicAcidAlphabet,
    DNA,
    DNAAlphabet,
    RNA,
    RNAAlphabet,
    Alphabet

using PrecompileTools: @setup_workload, @compile_workload
using TestItemRunner: @testitem

include("types.jl")
export BinarySequenceMatrix, BSM, binary_sequence_matrix

@setup_workload begin
    # Putting some things in `@setup_workload` instead of `@compile_workload` can reduce the size of the
    # precompile file and potentiall y make loading faster.
    using BioSequences
    seq = randdnaseq(10^3)
    @compile_workload begin
        # all calls in this block will be precompiled, regardless of whether
        # they belong to your package or not (on Julia 1.8 and higher)
        BinarySequenceMatrix(seq)
    end
end

end # end module BioVossEncoder