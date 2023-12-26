using Documenter
using BioVossEncoder

DocMeta.setdocmeta!(BioVossEncoder, :DocTestSetup, :(using BioVossEncoder); recursive = true)

makedocs(;
    modules = [BioVossEncoder],
    authors = "Camilo García",
    repo = "https://github.com/camilogarciabotero/BioVossEncoder.jl",
    sitename = "BioVossEncoder.jl",
    format = Documenter.HTML(
        mathengine=MathJax3(),
        prettyurls = get(ENV, "CI", "false") == "true",
        canonical="https://camilogarciabotero.github.io/BioVossEncoder.jl",
        assets=String[indigo],
    ),
    pages = [
        "Home" => "index.md",
    ],
)

deploydocs(; repo = "https://github.com/camilogarciabotero/BioVossEncoder.jl")
