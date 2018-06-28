################
# Trans-parsing  Julia AST to Math AST


const binops_renames =Dict( :(<=) => "\\le",
                            :(>=) => "\\ge",
                            :in   => "\\in",
                            :±  => "\\pm")
const binops = [Symbol.(split("+ - < > ∈ ≈ *"))..., keys(binops_renames)...]


val_or_expr(x::Expr) = x
val_or_expr(x) = Val{x}()


function MathSequence(v_vs, binop)
    dlm = to_math(binop)
    vs = to_math.(collect(v_vs))
    
    frags = Vector{MathExpressionFragment}()
    sizehint!(frags, 2*length(vs)-1)
    for v in vs[1:end-1]
        push!(frags,v)
        push!(frags,dlm)
    end
    push!(frags, vs[end])
    MathSequence(frags)
end



to_math(::Val{sym}) where {sym}= to_math(sym)
to_math(sym::Number) = MathSymbol(sym)
function to_math(sym::Symbol)
    if haskey(binops_renames, sym)
        return MathSymbol(binops_renames[sym])
    end

    sym_str = String(sym)
    frags = split(String(sym), "_")
    if length(frags) == 1
        MathSymbol(sym)
    else
        base = Symbol(frags[1])
        sub = Symbol(join(frags[2:end], ","))
        MathSubscript(base, sub)
    end
end

function to_math(::Val{:call}, v_binop::Union{(Val{binop} for binop in binops)...}, vs...)
    #Binary Operators: the julia paster rolls `1+2+3` into (+,(1,2,3))
    length(vs) < 2 && warn("attempting to parse for $(v_binop) with less than 2 args: $(vs)")
    MathSequence(vs, v_binop)
end


# Uniary minux
function to_math(::Val{:call}, ::Val{:-}, v)
    # HACK: say it is a function call
    MathFunctionCall(:-, MathSequence([to_math(v)]))
end

function to_math(::Val{:call}, ::Val{:^}, v_base, v_expo)
    MathSuperscript(to_math(v_base), to_math(v_expo))
end

function to_math(::Val{:call}, ::Val{:/}, v_base, v_expo)
    MathFrac(to_math(v_base), to_math(v_expo))
end

function to_math(::Val{:call}, v_func::Val{func}, v_args...) where func
    MathFunctionCall(func, MathSequence(v_args, Symbol(", ")))
end


function to_math(ast::Expr)
    to_math(Val{ast.head}(), val_or_expr.(ast.args)... )
end

# Matrixes and Vectors

to_math(::Val{:vect},vs...) = to_math_vector(vs)
function to_math_vector(col)
    math_col = MathExpressionFragment[to_math(c) for c in col] 
    MathMatrix(math_col[:,:]) #A vector is a column matrix
end

to_math(::Val{:hcat},row...) = to_math_matrix(row)
function to_math_matrix(rows...)
	function math_row(row)
		row_vec = MathExpressionFragment[to_math(r) for r in row.args]
		permutedims(row_vec[:,:], (2,1))	 
	end
    MathMatrix(vcat(map(math_row, rows)...))
end


function to_math(::Val{:vcat},vs...)
    if typeof(vs[1])<:Expr && vs[1].head == :row
        to_math_matrix(vs...)
    else
        to_math_vector(vs)
    end
end

