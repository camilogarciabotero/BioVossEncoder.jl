module TestBioVossEncoderTests

using BioSequences
using BioVossEncoder

using Aqua
using Test
using TestItems
using TestItemRunner

include("aquatest.jl")

@run_package_tests

@testitem "VE" begin
    using BioSequences, BioVossEncoder
    # Simple test for small DNA sequence
    dseq01 = dna"ACGT"
    @test vossmatrix(dseq01) == Bool[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]
    @test vossvector(dseq01, DNA_A) == Bool[1, 0, 0, 0]
    @test vossvector(dseq01, ACGT) == Bool[1, 1, 1, 1]
    @test eltype(VossEncoder(dseq01)) == DNA
    
    # Test for larger DNA sequence
    dseq02 = dna"TACGCTAGTGCA"
    @test eltype(VossEncoder(dseq02)) == DNA
    
    # Test for ambiguous DNA sequence
    dseq03 = dna"TGNTKCTW-T" # ambiguous DNA sequence 
    vossmatrix(dseq03) == Bool[0 0 1 0 0 0 0 1 0 0; 0 0 1 0 0 1 0 0 0 0; 0 1 1 0 1 0 0 0 0 0; 1 0 1 1 1 0 1 1 0 1]

    # Tests for simple Amino Acid sequence
    aseq01 = aa"ACDEFGHIKLMNPQRSTVWY"
    @test vossmatrix(aseq01) == Bool[1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
    @test vossvector(aseq01, AA_A) == Bool[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @test vossvector(aseq01, AA20) == Bool[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    @test eltype(VossEncoder(aseq01)) == AminoAcid

end


@testitem "Code quality" begin
    using Aqua
    Aqua.test_all(
        BioVossEncoder; unbound_args=false, deps_compat=(check_extras=false,)
    )
end

@testitem "Code linting" begin
    using JET
    JET.test_package(BioVossEncoder; target_defined_modules=true)
end


end