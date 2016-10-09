render(ast) = ast |> to_math |> to_latex |> latexstring |> display


"""
Renders the value of `v`
$(SIGNATURES)
"""
renderval(v) = v |> repr |> parse |> render


"Render an expression. Eg `@render x^(2/(y+1))`"
macro render(ast)
	:(render($(Meta.quot(ast))))
end



