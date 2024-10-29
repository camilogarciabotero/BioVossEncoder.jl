using Documenter
using BioVossEncoder
using DocumenterVitepress

DocMeta.setdocmeta!(BioVossEncoder, :DocTestSetup, :(using BioVossEncoder); recursive = true)

# makedocs(;
#     modules = [BioVossEncoder],
#     authors = "Camilo García",
#     repo = "https://github.com/camilogarciabotero/BioVossEncoder.jl/blob/{commit}{path}#{line}",
#     sitename = "BioVossEncoder.jl",
#     format = Documenter.HTML(
#         mathengine=MathJax3(),
#         prettyurls = get(ENV, "CI", "false") == "true",
#         canonical="https://camilogarciabotero.github.io/BioVossEncoder.jl",
#         repolink = "https://github.com/camilogarciabotero/BioVossEncoder.jl",
#     ),
#     pages = [
#         "Home" => "index.md",
#         "Voss representation" => "vossrepresentation.md",
#         "API" => "api.md",
#     ],
# )

# deploydocs(; repo = "https://github.com/camilogarciabotero/BioVossEncoder.jl")

fmt = DocumenterVitepress.MarkdownVitepress(
    repo = "https://github.com/camilogarciabotero/BioVossEncoder.jl",
    devbranch = "main",
)

pgs = [
    "Home" => "index.md",
    "Get started" => "getstarted.md",
    "Voss Representation" => "vossrepresentation.md",
    "API" => "api.md"
]

makedocs(;
    modules = [BioVossEncoder],
    authors = "Camilo García-Botero",
    repo = Remotes.GitHub("camilogarciabotero", "BioVossEncoder.jl"),
    sitename = "BioVossEncoder.jl",
    format = fmt,
    pages = pgs,
    warnonly = true,
)

deploydocs(; 
    repo = "https://github.com/camilogarciabotero/BioVossEncoder.jl",
    devbranch = "main",
    target = "build", # this is where Vitepress stores its output
    branch = "gh-pages",
    push_preview = true
)