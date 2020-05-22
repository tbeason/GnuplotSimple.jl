using Documenter, GnuplotSimple

makedocs(
    modules = [GnuplotSimple],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Tyler Beason",
    sitename = "GnuplotSimple.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/tbeason/GnuplotSimple.jl.git",
    push_preview = true
)
