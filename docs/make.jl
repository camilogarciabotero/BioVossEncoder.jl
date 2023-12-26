using Documenter
using BioVossEncoder
using DocThemeIndigo

indigo = DocThemeIndigo.install(Configurations)

makedocs(;
    modules = [BioVossEncoder],
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        canonical="https://Camilo García.github.io/BioVossEncoder.jl",
        assets=String[indigo],
    ),
    pages = [
        "Home" => "index.md",
    ],
    repo = "https://github.com/Camilo García/BioVossEncoder.jl",
    sitename = "BioVossEncoder.jl",
)

deploydocs(; repo = "https://github.com/camilogarciabotero/BioVossEncoder.jl")
