"""Note: Does not (currently) escape all of latex."""
function escape_latex(s::AbstractString)
    s #not actually escaping anything  infact
end

latex_brace(x::AbstractString) = "{" * x * "}"

to_latex(s::MathSymbolInner) = to_latex("$s") #Must define first so will be over writtern
#TODO: Special case Floats, to handle e
to_latex(s::AbstractString) = escape_latex(s)


to_latex(x::MathSymbol) = to_latex(x.sym)

function to_latex(x::MathSuperscript)
    to_latex(x.base) * "^" * latex_brace(to_latex(x.expo))
end

function to_latex(x::MathSubscript)
    to_latex(x.base) * "_" * latex_brace(to_latex(x.sub))
end


function to_latex(x::MathFrac)
    "\\frac" * latex_brace(to_latex(x.numer)) * latex_brace(to_latex(x.denom))
end

function to_latex(x::MathFunctionCall)
    name = x.fname |> string |> escape_latex
    if length(name) > 1
        name = "\\mathrm"*latex_brace(name) #Multicharacter names are typeset upright
    end
    name*to_latex(x.arg)
end

function to_latex(x::MathMatrix)
    desc = "c"^size(x.mat,1)
    rows = mapslices(y->join(y," & "), to_latex.(x.mat),2) |> vec
    latexmat = join(rows, "\\\\")

    """\\left[\\begin{array}{$desc}
    $latexmat
    \\end{array}\\right]"""
end

function to_latex(x::MathSequence)
    inner = join(to_latex.(x.fragments), " ")
    if length(x) == 1 && typeof(first(x.fragments))==MathSequence
       # skip outer-most brackets on Sequence that will be breackets internally anyway
       x.fragments |> first |> to_latex
    else
        "(" * join(to_latex.(x.fragments)," ") * ")"
    end
end

