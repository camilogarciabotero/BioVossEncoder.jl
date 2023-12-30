var documenterSearchIndex = {"docs":
[{"location":"api/","page":"API","title":"API","text":"CurrentModule = BioVossEncoder\nDocTestSetup = quote\n    using BioVossEncoder\nend","category":"page"},{"location":"api/","page":"API","title":"API","text":"","category":"page"},{"location":"api/","page":"API","title":"API","text":"Modules = [BioVossEncoder]","category":"page"},{"location":"api/#BioVossEncoder.BinarySequenceMatrix","page":"API","title":"BioVossEncoder.BinarySequenceMatrix","text":"struct BinarySequenceMatrix{A<:NucleicAcidAlphabet, B<:BitMatrix}\n\nThe BinarySequenceMatrix struct represents a binary matrix encoding a sequence of nucleic acids. This is also called the Voss representation of a sequence.\n\nFields\n\nalphabet::A: The nucleic acid alphabet used for encoding.\nbsm::B: The binary matrix representing the encoded sequence.\n\nConstructors\n\nBinarySequenceMatrix(sequence::SeqOrView{A}): Constructs a BinarySequenceMatrix from a sequence of nucleic acids.\n\nArguments\n\nsequence::SeqOrView{A}: The sequence of nucleic acids to be encoded.\n\n\n\n\n\n","category":"type"},{"location":"api/#BioVossEncoder.binary_sequence_matrix-Union{Tuple{Union{BioSequences.LongSequence{A}, BioSequences.LongSubSeq{A}}}, Tuple{A}} where A<:BioSequences.NucleicAcidAlphabet","page":"API","title":"BioVossEncoder.binary_sequence_matrix","text":"binary_sequence_matrix(sequence::SeqOrView{A}) where {A <: NucleicAcidAlphabet}\n\nCreate a binary sequence matrix from a given nucleic acid sequence.\n\nArguments\n\nsequence: A nucleic acid sequence.\n\nReturns\n\nThe binary sequence matrix.\n\n\n\n\n\n","category":"method"},{"location":"api/#BioVossEncoder.sequence_binarizer-Union{Tuple{A}, Tuple{Union{BioSequences.LongSequence{A}, BioSequences.LongSubSeq{A}}, Union{BioSymbols.DNA, BioSymbols.RNA}}} where A<:BioSequences.NucleicAcidAlphabet","page":"API","title":"BioVossEncoder.sequence_binarizer","text":"sequence_binarizer(sequence::SeqOrView{A}, nucleotide::Union{DNA,RNA}) where {A <: NucleicAcidAlphabet}\n\nConverts a sequence of nucleotides into a binary representation.\n\nArguments\n\nsequence::SeqOrView{A}: The input sequence of nucleotides.\nnucleotide::Union{DNA,RNA}: The nucleotide to be encoded as 1, while others are encoded as 0.\n\nReturns\n\nA BitVector representing the binary encoding of the input sequence, where 1 indicates the presence of the specified nucleotide and 0 indicates the absence.\n\n\n\n\n\n","category":"method"},{"location":"vossrepresentation/#Voss-representation","page":"Voss representation","title":"Voss representation","text":"","category":"section"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"A Voss representation of a biological sequence is a binary matrix that encodes the sequence. The Voss representation of a sequence is obtained by encoding the sequence into a binary matrix where each column of the matrix represents a position in the sequence and each row represents a symbol in the alphabet.","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"For example, the Voss representation of the sequence ACGT is the following matrix:","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"beginbmatrix\ntextA  1  0  0  0 \ntextC  0  1  0  0 \ntextG  0  0  1  0 \ntextT  0  0  0  1 \nendbmatrix","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"In this case the alphabet chosen is the DNA alphabet, but the same representation can be used for any alphabet. In this package we focused on the DNA and RNA alphabets.","category":"page"},{"location":"vossrepresentation/#Encoding-BioSequences","page":"Voss representation","title":"Encoding BioSequences","text":"","category":"section"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"This package provides a simple and fast way to encode biological sequences into Voss representation. The main struct provided by this package is BinarySequenceMatrix which is a wrapper of BitMatrix that encodes a biological sequence into a binary matrix. The following example shows how to encode a DNA sequence into a binary matrix.","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> using BioSequences, BioVossEncoder\n","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> seq = dna\"ACGT\"\n","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> BinarySequenceMatrix(seq)","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"BinarySequenceMatrix{NucleicAcidAlphabet, BitMatrix}(DNAAlphabet{4}(), Bool[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1])","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"For simplicity the BinarySequenceMatrix struct provides a property bsm that returns the BitMatrix representation of the sequence.","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> BinarySequenceMatrix(seq).bsm","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"4×4 BitMatrix:\n 1  0  0  0\n 0  1  0  0\n 0  0  1  0\n 0  0  0  1","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"Similarly another function that makes use of the BinarySequenceMatrix struct is binary_sequence_matrix which returns the BitMatrix representation of a sequence directly.","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"julia> binary_sequence_matrix(seq)","category":"page"},{"location":"vossrepresentation/","page":"Voss representation","title":"Voss representation","text":"4×4 BitMatrix:\n 1  0  0  0\n 0  1  0  0\n 0  0  1  0\n 0  0  0  1","category":"page"},{"location":"","page":"Home","title":"Home","text":"<p align=\"center\">\n  <img src=\"assets/logo.svg\" height=\"150\"><br/>\n  <i>Encoding biological sequences into Voss representation</i>\n</p>","category":"page"},{"location":"","page":"Home","title":"Home","text":"\n<div style=\"text-align: center;\">\n\n<a href=\"https://camilogarciabotero.github.io/BioVossEncoder.jl/dev/\"><img src=\"https://img.shields.io/badge/documentation-online-blue.svg?logo=Julia&logoColor=white\" alt=\"Documentation\"></a>\n<a href=\"https://github.com/camilogarciabotero/BioVossEncoder.jl/releases/latest\"><img src=\"https://img.shields.io/github/release/camilogarciabotero/BioVossEncoder.jl.svg\" alt=\"Latest Release\"></a>\n<a href=\"https://zenodo.org/badge/latestdoi/665161607\"><img src=\"https://zenodo.org/badge/665161607.svg\" alt=\"DOI\"></a>\n<br/>\n<a href=\"https://github.com/camilogarciabotero/BioVossEncoder.jl/actions/workflows/CI.yml\"><img src=\"https://github.com/camilogarciabotero/BioVossEncoder.jl/actions/workflows/CI.yml/badge.svg\" alt=\"CI Workflow\"></a>\n<a href=\"https://github.com/camilogarciabotero/BioVossEncoder.jl/blob/main/LICENSE\"><img src=\"https://img.shields.io/badge/license-MIT-green.svg\" alt=\"License\"></a>\n<a href=\"https://www.repostatus.org/#wip\"><img src=\"https://www.repostatus.org/badges/latest/wip.svg\" alt=\"Work in Progress\"></a>\n<a href=\"https://pkgs.genieframework.com?packages=BioVossEncoder\"><img src=\"https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/BioVossEncoder&label=downloads\" alt=\"Downloads\"></a>\n\n</div>\n","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Overview","page":"Home","title":"Overview","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This package aim to provide a simple and fast way to encode biological sequences into Voss representation.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"You can install BioVossEncoder from the julia REPL. Press ] to enter pkg mode, and enter the following:","category":"page"},{"location":"","page":"Home","title":"Home","text":"add BioVossEncoder","category":"page"},{"location":"","page":"Home","title":"Home","text":"If you are interested in the cutting edge of the development, please check out the master branch to try new features before release.","category":"page"}]
}
