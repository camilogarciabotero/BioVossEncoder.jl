# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and this project adheres to Semantic Versioning.

## [UNRELEASED](https://github.com/camilogarciabotero/BioVossEncoder.jl/compare/v0.2.0...main)

## [0.2.0]

- Amino acid sequences are now encoded as well method.
- The `BinarySequenceMatrix` methods are now way faster by exploiting internals this is an implementation suggested by @jakani. For a more safe implementation see the [recipe](https://biojulia.dev/BioSequences.jl/dev/recipes/) in the [BioSequence.jl](https://biojulia.dev/BioSequences.jl/dev/recipes/) package.
- The `BinarySequenceMatrix` is now beautifully displayed in the REPL.
- A new convinient method `binaryseq(seq::BioSeq, molecule::BioSymbol)` is now exported to create one-hot vecotor of a sequence and a given `BioSymbol` molecule.

## [0.1.0]

- This is the first release of the BioVossEncoder.jl package.