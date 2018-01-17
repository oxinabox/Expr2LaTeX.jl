
#######################
# MathAST Definitions 

abstract type MathExpressionFragment end



struct MathSequence <:MathExpressionFragment
    fragments::Vector{MathExpressionFragment}
end
Base.length(ms::MathSequence) = length(ms.fragments)

const MathSymbolInner = Union{Number, Symbol}
struct MathSymbol{T<:MathSymbolInner} <: MathExpressionFragment
    sym::T
end
MathSymbol(s::AbstractString) = MathSymbol(Symbol(s))

struct MathFrac <: MathExpressionFragment
    numer::MathExpressionFragment
    denom::MathExpressionFragment
end

struct MathSuperscript <: MathExpressionFragment
    base::MathExpressionFragment
    expo::MathExpressionFragment
end

struct MathSubscript <: MathExpressionFragment
    base::Symbol
    sub::Symbol
end

struct MathFunctionCall <: MathExpressionFragment
    fname::Symbol
    arg::MathSequence
end

struct MathMatrix <: MathExpressionFragment
    mat::Matrix{MathExpressionFragment}
end

