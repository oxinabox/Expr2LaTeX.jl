
@testset "julia2latex" begin
    @test to_latex(to_math(:(2))) == "2"
    @test to_latex(to_math(:(20^30))) == "20^{30}"
    @test to_latex(to_math(:(1+1))) == "(1 + 1)"
    @test to_latex(to_math(:(1 <= 2))) == "(1 \\le 2)"
    @test to_latex(to_math(:(1 ± 4))) == "(1 \\pm 4)"
    @test to_latex(to_math(:(1*1*3))) == "(1 * 1 * 3)"
    @test to_latex(to_math(:(2^(1+1)))) == "2^{(1 + 1)}"
    @test to_latex(to_math(:(1+(2+3)))) == "(1 + (2 + 3))"
    @test to_latex(to_math(:(1/2))) == "\\frac{1}{2}"
    @test to_latex(to_math(:(1/(2+3)))) == "\\frac{1}{(2 + 3)}"
    @test to_latex(to_math(:(f(x)))) == "f(x)"
    @test to_latex(to_math(:(f(x,y)))) == "f(x ,  y)" #Not sure on the spacing here
    @test to_latex(to_math(:(sin(x)))) == "\\mathrm{sin}(x)"
    
    @test to_latex(to_math(:(a_b))) == "a_{b}"
    @test to_latex(to_math(:(a_bc))) == "a_{bc}"
    @test to_latex(to_math(:(a_b_c))) == "a_{b,c}"
    
    @test to_latex(to_math(:([1,2,3]))) == "\\left[\\begin{array}{ccc}\n1\\\\2\\\\3\n\\end{array}\\right]"
    @test to_latex(to_math(:([1;2;3]))) == "\\left[\\begin{array}{ccc}\n1\\\\2\\\\3\n\\end{array}\\right]"
    @test to_latex(to_math(:([1 10 100;2 20 200])))  == "\\left[\\begin{array}{cc}\n1 & 10 & 100\\\\2 & 20 & 200\n\\end{array}\\right]"
    #@test to_latex(to_math(:())) == ""

    @test to_latex(to_math(:(exp(a+b)))) == "\\mathrm{exp}(a + b)"
    
    @test to_latex(to_math(:(-(a+b)))) == "-(a + b)"
end
