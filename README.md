# Expr2LaTeX

[![Build Status](https://travis-ci.org/oxinabox/Expr2LaTeX.jl.svg?branch=master)](https://travis-ci.org/oxinabox/Expr2LaTeX.jl)

[![Build status](https://ci.appveyor.com/api/projects/status/mi33drp57hjuiiua/branch/master?svg=true)](https://ci.appveyor.com/project/oxinabox/expr2latex-jl/branch/master)


[![Coverage Status](https://coveralls.io/repos/oxinabox/Expr2LaTeX.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/oxinabox/Expr2LaTeX.jl?branch=master)

[![codecov.io](http://codecov.io/github/oxinabox/Expr2LaTeX.jl/coverage.svg?branch=master)](http://codecov.io/github/oxinabox/Expr2LaTeX.jl?branch=master)

Checkout [the IJulia Notebook for the Demo](http://nbviewer.jupyter.org/github/oxinabox/Expr2LaTeX.jl/blob/master/demo.ipynb)
![Screenshot](screenshot.PNG)




### Use with SymEngine.jl

A particularly cool use of this is with [SymEngine.jl](https://github.com/symengine/SymEngine.jl).

`repr`ing  a SymEngine expression, outputs basically julia code.
You can `parse` this to get a julia expression,
and then you can use Expr2LaTeX to `render` it.


![SymEngine Screenshot](SymEngineDemo.png)


## See also
 
[Latexify.jl](https://github.com/korsbo/Latexify.jl),
same rough idea, but taken to the next level.
