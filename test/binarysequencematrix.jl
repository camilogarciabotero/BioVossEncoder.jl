@testset "BSM" begin
    seq01 = dna"TACGCTAGTGCA"
    bsm = BinarySequenceMatrix(seq01)
    
    @test bsm.alphabet == DNAAlphabet{4}()
    @test bsm.bsm == Bool[0 1 0 0 0 0 1 0 0 0 0 1; 0 0 1 0 1 0 0 0 0 0 1 0; 0 0 0 1 0 0 0 1 0 1 0 0; 1 0 0 0 0 1 0 0 1 0 0 0]
end