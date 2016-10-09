
#######################
# MathAST Definitions 

abstract MathExpressionFragment

immutable MathSequence <:MathExpressionFragment
    fragments::Vector{MathExpressionFragment}
end


typealias MathSymbolInner Union{Base.BitInteger.types..., Float16, Float32, Float64, Symbol} 
immutable MathSymbol{T<:MathSymbolInner} <: MathExpressionFragment
    sym::T
end

immutable MathFrac <: MathExpressionFragment
    numer::MathExpressionFragment
    denom::MathExpressionFragment
end

immutable MathSuperscript <: MathExpressionFragment
    base::MathExpressionFragment
    expo::MathExpressionFragment
end

immutable MathFunctionCall <: MathExpressionFragment
    fname::Symbol
    #args::Vector{MathExpressionFragment}
    arg::MathSequence
end

immutable MathMatrix <: MathExpressionFragment
    mat::Matrix{MathExpressionFragment}
end

