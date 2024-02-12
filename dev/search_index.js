var documenterSearchIndex = {"docs":
[{"location":"api/","page":"API","title":"API","text":"CurrentModule = BioVossEncoder\nDocTestSetup = quote\n    using BioVossEncoder\nend","category":"page"},{"location":"api/","page":"API","title":"API","text":"","category":"page"},{"location":"api/","page":"API","title":"API","text":"Modules = [BioVossEncoder]","category":"page"},{"location":"api/#BioVossEncoder.VossEncoder","page":"API","title":"BioVossEncoder.VossEncoder","text":"struct VossEncoder{A<:NucleicAcidAlphabet, B<:BitMatrix}\n\nThe VossEncoder struct represents a binary matrix encoding a sequence of nucleic acids. This is also called the Voss representation of a sequence.\n\nFields\n\nalphabet::A: The nucleic acid alphabet used for encoding.\nbitmatrix::B: The binary matrix representing the encoded sequence.\n\nConstructors\n\nVossEncoder(sequence::SeqOrView{A}): Constructs a VossEncoder from a sequence of nucleic acids.\n\nArguments\n\nsequence::SeqOrView{A}: The sequence of nucleic acids to be encoded.\n\n\n\n\n\n","category":"type"},{"location":"api/#BioVossEncoder.vossmatrix-Union{Tuple{VossEncoder{A, B}}, Tuple{B}, Tuple{A}} where {A<:BioSequences.NucleicAcidAlphabet, B<:BitMatrix}","page":"API","title":"BioVossEncoder.vossmatrix","text":"vossmatrix(VossEncoder::VossEncoder{A, B}) where {A <: NucleicAcidAlphabet, B <: BitMatrix}\nvossmatrix(sequence::NucleicSeqOrView{A}) where {A <: NucleicAcidAlphabet}\nvossmatrix(sequence::SeqOrView{AminoAcidAlphabet}) where {A <: AminoAcidAlphabet}\n\nCreate a binary sequence matrix from a given nucleic acid sequence.\n\nArguments\n\nsequence: A nucleic acid sequence.\n\nReturns\n\nThe binary sequence matrix.\n\nExamples\n\njulia> vossmatrix(aa\"IANRMWRDTIED\")\n\n    20×12 BitMatrix:\n    0  1  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  0  0  1  0  0  0  1\n    0  0  0  0  0  0  0  0  0  0  1  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    1  0  0  0  0  0  0  0  0  1  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  1  0  0  0  0  0  0  0\n    0  0  1  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  1  0  0  1  0  0  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  0  0  0  1  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n    0  0  0  0  0  1  0  0  0  0  0  0\n    0  0  0  0  0  0  0  0  0  0  0  0\n\n\n\n\n\n","category":"method"},{"location":"api/#BioVossEncoder.vossvector-Union{Tuple{T}, Tuple{A}, Tuple{Union{BioSequences.LongSequence{A}, BioSequences.LongSubSeq{A}}, T}} where {A<:BioSequences.NucleicAcidAlphabet, T<:BioSymbols.BioSymbol}","page":"API","title":"BioVossEncoder.vossvector","text":"vossvector(sequence::NucleicSeqOrView{A}, molecule::T) where {A <: NucleicAcidAlphabet, T <: BioSymbol}\nvossvector(sequence::SeqOrView{AminoAcidAlphabet}, molecule::T) where {T <: BioSymbol}\nvossvector(sequence::SeqOrView{A}, molecules::Tuple{Vararg{T}}) where {A <: Alphabet, T <: BioSymbol}\n\nConverts a sequence of nucleotides into a binary representation.\n\nArguments\n\nsequence::SeqOrView{A}: The input sequence of nucleotides.\nmolecule::BioSymbol: The nucleotide to be encoded as 1, while others are encoded as 0.\nmolecules::Tuple{Vararg{T}}: The nucleotides to be encoded as 1, while others are encoded as 0.\n\nReturns\n\nA BitVector representing the binary encoding of the input sequence, where 1 indicates the presence of the specified nucleotide and 0 indicates the absence in the ith position of the sequence.\n\nExamples\n\njulia> vossvector(dna\"ACGT\", DNA_A)\n\n    4-element view(::BitMatrix, 1, :) with eltype Bool:\n     1\n     0\n     0\n     0\n\n\n\n\n\n","category":"method"},{"location":"vossrepresentation/#Voss-representation","page":"Voss representation","title":"Voss representation","text":"","category":"section"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"A Voss representation of a biological sequence is a binary matrix that encodes the sequence. The Voss representation of a sequence is obtained by encoding the sequence into a binary matrix where each column of the matrix represents a position in the sequence and each row represents a symbol in the alphabet (Voss, 1992). Formally, given a sequence S of length n and an alphabet mathscrA of size m, the Voss matrix V of S is a m times n binary matrix V such that V_ij = 1 if the j^th position of the sequence S is equal to the i^th symbol of the alphabet mathscrA and V_ij = 0 otherwise:","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"v_ij = begincases \n      1  textif  sj = mathscrai \n      0  textif  sj neq mathscrai\nendcases","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"For example, the Voss matrix of the DNA sequence (i.e of mathscrA) == A C G T)  is the following matrix:","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"beginbmatrix\ntextA  1  0  0  0 \ntextC  0  1  0  0 \ntextG  0  0  1  0 \ntextT  0  0  0  1 \nendbmatrix","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"In this case the given alphabet is the DNA alphabet, but the same representation can be used for other alphabets.","category":"page"},{"location":"vossrepresentation/#Encoding-BioSequences","page":"Voss representation","title":"Encoding BioSequences","text":"","category":"section"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"This package provides a simple and fast way to encode biological sequences into Voss representations. The main struct provided by this package is VossEncoder which is a wrapper of BitMatrix that encodes a biological sequence into a bit matrix and its corresponding alphabet. The following example shows how to encode a DNA sequence into a Voss matrix.","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> using BioSequences, BioVossEncoder\n","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> seq = dna\"ACGT\"\n","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> VossEncoder(seq)","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"4×4 Voss Matrix of DNAAlphabet{4}():\n 1  0  0  0\n 0  1  0  0\n 0  0  1  0\n 0  0  0  1","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"For simplicity the VossEncoder struct provides a property bitmatrix that returns the BitMatrix representation of the sequence.","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> VossEncoder(seq).bitmatrix","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"4×4 BitMatrix:\n 1  0  0  0\n 0  1  0  0\n 0  0  1  0\n 0  0  0  1","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"Similarly another function that makes use of the VossEncoder structure is vossmatrix which returns the BitMatrix representation of a sequence directly.","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> vossmatrix(seq)","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"4×4 BitMatrix:\n 1  0  0  0\n 0  1  0  0\n 0  0  1  0\n 0  0  0  1","category":"page"},{"location":"vossrepresentation/#Creating-a-Voss-vector-of-a-sequence","page":"Voss representation","title":"Creating a Voss vector of a sequence","text":"","category":"section"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"Sometimes it proves to be useful to encode a sequence into a Voss vector representation (i.e a bit vector of the sequence from the corresponding molecule alphabet).","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"This package provides a function vossvector that returns Voss vector of a sequence given a BioSequence and the specific molecule (BioSymbol) that could be DNA or AA.","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> vossvector(seq, DNA_A)","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"4-element view(::BitMatrix, 1, :) with eltype Bool:\n 1\n 0\n 0\n 0","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"Note that the output is actually using behind the scenes a view of the BitMatrix representation of the sequence. This is done for performance reasons.","category":"page"},{"location":"vossrepresentation/#References","page":"Voss representation","title":"References","text":"","category":"section"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"Voss, R. F. Evolution of long-range fractal correlations and 1/ f noise in DNA base sequences. Phys. Rev. Lett. 68, 3805–3808 (1992).","category":"page"},{"location":"","page":"Home","title":"Home","text":"<p align=\"center\">\n  <img src=\"assets/logo.svg\" height=\"150\"><br/>\n  <i>Encoding biological sequences into Voss representations</i>\n</p>","category":"page"},{"location":"","page":"Home","title":"Home","text":"\n<div style=\"text-align: center;\">\n\n<a href=\"https://camilogarciabotero.github.io/BioVossEncoder.jl/dev/\"><img src=\"https://img.shields.io/badge/documentation-online-blue.svg?logo=Julia&logoColor=white\" alt=\"Documentation\"></a>\n<a href=\"https://github.com/camilogarciabotero/BioVossEncoder.jl/releases/latest\"><img src=\"https://img.shields.io/github/release/camilogarciabotero/BioVossEncoder.jl.svg\" alt=\"Latest Release\"></a>\n<a href=\"https://doi.org/10.5281/zenodo.10452378\"><img src=\"https://zenodo.org/badge/DOI/10.5281/zenodo.10452378.svg\" alt=\"DOI\"></a>\n\n<br/>\n<a href=\"https://github.com/camilogarciabotero/BioVossEncoder.jl/actions/workflows/CI.yml\"><img src=\"https://github.com/camilogarciabotero/BioVossEncoder.jl/actions/workflows/CI.yml/badge.svg\" alt=\"CI Workflow\"></a>\n<a href=\"https://github.com/camilogarciabotero/BioVossEncoder.jl/blob/main/LICENSE\"><img src=\"https://img.shields.io/badge/license-MIT-green.svg\" alt=\"License\"></a>\n<a href=\"https://www.repostatus.org/#wip\"><img src=\"https://www.repostatus.org/badges/latest/wip.svg\" alt=\"Work in Progress\"></a>\n<a href=\"https://pkgs.genieframework.com?packages=BioVossEncoder\"><img src=\"https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/BioVossEncoder&label=downloads\" alt=\"Downloads\"></a>\n<a href=\"https://github.com/JuliaTesting/Aqua.jl\">\n  <img src=\"https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg\" alt=\"Aqua QA\">\n</a>\n\n</div>\n","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Overview","page":"Home","title":"Overview","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This package aim to provide a simple and fast way to encode biological sequences into Voss representation.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"You can install BioVossEncoder from the julia REPL. Press ] to enter pkg mode, and enter the following:","category":"page"},{"location":"","page":"Home","title":"Home","text":"add BioVossEncoder","category":"page"},{"location":"","page":"Home","title":"Home","text":"If you are interested in the cutting edge of the development, please check out the master branch to try new features before release.","category":"page"}]
}
