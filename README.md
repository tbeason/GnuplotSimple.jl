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


GnuplotSimple.jl provides a slightly more familiar way to make simple plots with [Gnuplot.jl](https://github.com/gcalderone/Gnuplot.jl), which is a wrapper around the mature [gnuplot](http://www.gnuplot.info/) software. The idea is that this recipe allows for a more familiar and perhaps more readable interface for the library when using it for only the barebones features. If you are making advanced plots, you should really learn how to use Gnuplot.jl directly. This is only meant to enhance the convenience of that more feature-rich package.



## Usage

The package only defines a plot recipe (called `plot`) and therefore **must** be used together with Gnuplot.jl.
```julia
using Gnuplot, GnuplotSimple
```

Further, note that the name `plot` here will conflict with most other plotting packages. Therefore you should not also load something like Plots.jl in the same session, or if you do you should expect to prefix the command (`GnuplotSimple.plot`).


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


## The Recipe

`plot(x,Y; kwargs...)`


Required: vector-like `x` and vector or matrix-like `Y`.

All keyword arguments are optional. I tried to stick to the `gnuplot` naming scheme for the most part. Here are all of them with defaults when set.
 - `title::String` Plot title
 - `xlab::String` Label for x-axis
 - `ylab::String` Label for y-axis
 - `key::String` Legend placement
 - `grid::Bool=true` show grid lines or not.
 - `scatter::Bool=false` set to `true` to use points instead of lines (for scatter plot or just because you hate lines).
 - `xr` range for x-axis
 - `yr` range for y-axis
 - `xlog::Bool=false` logscale x-axis
 - `ylog::Bool=false` logscale y-axis
 - `mono::Bool=false` produce monochrome plot
 - `labels` series labels (legend entries). Should be vector of strings (at least as many as columns in `Y`).
 - `linecolor` Vector of strings (at least as many as columns in `Y`) providing `rgb` colors (`"black"`,`"red"`,etc.).
 - `linewidth` Vector of numbers (at least as many as columns in `Y`) providing line widths.
 - `linetype` Vector of strings (at least as many as columns in `Y`) providing linetype commands. This allows for more flexibility than you probably deserve. Strings should contain the full linetype command as `gnuplot` would like it. The simplest forms would be `"dt 1"` for a solid line, `"dt 2"` for a dashed line, or `"dt 3"` for a dotted line, but you can also supply custom syntax like `"dt '..- '"`. See [here](http://gnuplot.sourceforge.net/demo/dashtypes.html) for visual examples of the styles. 
 
For the keyword arguments that are vector-valued, if you supply fewer values than the series that you are plotting then `gnuplot` will just pick the remaining items for you. No guarantees what you'll end up with. Also note that those arguments _do_ need to be vectors, so even if you are supplying a single label it must be wrapped, eg. `["my only label"]`.


There is only minimal input checking and processing before passing things off to Gnuplot.jl.

#### Hacker Note

Technically, you could also use `linetype` as a catch-all for the rest of the `labels`,`linecolor`, and `linewidth` arguments because `linetype` items are sent directly to `@gp`. As in, you could pass `"tit 'Expected' lw 3 lc rgb 'black' dt 2"` as a linetype if you wanted. If you find yourself doing this too much, you probably should just start using the regular `@gp` commands from Gnuplot.jl.


## Contributing

Any and all pull requests would be appreciated as long as it doesn't complicate the code too much. Would especially welcome any contributions that fix errors, bugs, or weird behaviors. 




