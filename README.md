# GnuplotSimple.jl

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.com/tbeason/GnuplotSimple.jl.svg?branch=master)](https://travis-ci.com/tbeason/GnuplotSimple.jl)
[![codecov.io](http://codecov.io/github/tbeason/GnuplotSimple.jl/coverage.svg?branch=master)](http://codecov.io/github/tbeason/GnuplotSimple.jl?branch=master)
<!--
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://tbeason.github.io/GnuplotSimple.jl/stable)
[![Documentation](https://img.shields.io/badge/docs-master-blue.svg)](https://tbeason.github.io/GnuplotSimple.jl/dev)
-->


GnuplotSimple.jl just provides the functionality to make _extremely_ simple plots with [Gnuplot.jl](https://github.com/gcalderone/Gnuplot.jl), which is a wrapper around the mature [gnuplot](http://www.gnuplot.info/) software.

It does only minimal input checking and processing before passing things off to Gnuplot.jl. 

## Usage

The package only defines a plot recipe (called `plot`) and therefore **must** be used together with Gnuplot.jl.
```julia
using Gnuplot, GnuplotSimple
```





## Example
Setup:
```julia
using Gnuplot, GnuplotSimple
x = 0:0.05:2
y = x.^(1:3)'
```

Using `@gp` directly:
```julia
@gp "set grid"
@gp :- tit="The Example" xlab="My x" ylab="The y value" xr=[0,1]
@gp :- x y[:,1] "w l tit 'y1'"
@gp :- x y[:,2] "w l tit 'y2'"
@gp :- x y[:,3] "w l tit 'y3'"
```

With this package:
```julia
@gp plot(x,y; title="The Example",xlab="My x",ylab="The y value",xr=[0,1],labels=["y1","y2","y3"])
```
Everything after the `;` in the function call is a keyword and can be omitted if you like.

The plotting terminal stays active, so you can amend the plot or save it just as you would using Gnuplot.jl.



