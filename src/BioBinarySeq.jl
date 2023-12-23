module BioBinarySeq

module BioMarkovChains

using BioSequences:
    SeqOrView,
    NucleicSeqOrView,

    NucleicAcidAlphabet,
    DNA,
    DNAAlphabet


using PrecompileTools: @setup_workload, @compile_workload
using TestItems: @testitem


# exampleseq = dna"TACGCTAGTGCA"

# xm = BinarySequenceMatrix(exampleseq)
# xv = _sequence_binarizer(exampleseq, DNA_A)

# wt = wavelet(WT.haar) # db2, db4, haar, coif1, bior1.3, sym2, rbio1.3

# xt = dwt(xm.bsm, wt)
# xt = dwt(xv, wt)


end # BioBinarySeq