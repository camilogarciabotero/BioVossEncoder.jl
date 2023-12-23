using Documenter
using BioBinarySeq
using DocThemeIndigo

indigo = DocThemeIndigo.install(Configurations)

makedocs(;
    modules = [BioBinarySeq],
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        canonical="https://Camilo García.github.io/BioBinarySeq.jl",
        assets=String[indigo],
    ),
    pages = [
        "Home" => "index.md",
    ],
    repo = "https://github.com/Camilo García/BioBinarySeq.jl",
    sitename = "BioBinarySeq.jl",
)

deploydocs(; repo = "https://github.com/Camilo García/BioBinarySeq.jl")
