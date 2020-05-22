module GnuplotSimple

using Gnuplot
import Gnuplot: PlotElement, DatasetText

export plot




"""
`plot(x,Y; grid, scatter, title, xlab, ylab, key, labels, xr, yr, linetype, linewidth, linecolor, xlog, ylog)`

A simple plot recipe for `Gnuplot.jl`.

Required: vector-like `x` and vector or matrix-like `Y`.

All keyword arguments are optional.

`title`, `xlab`, `ylab`, `key` should be strings.

`grid`, `scatter`, `xlog`, `ylog` are boolean.

`xr` and `yr` are like `[0,1]`. Use `NaN` for unbounded.

`labels`, `linecolor`, `linetype` should be vectors of strings (at least as many as columns in `Y`).

`linewidth` should be a vector of numbers.


```julia
using Gnuplot, GnuplotSimple
x = 0:0.05:2
y = x.^(1:3)'
@gp plot(x,y; title="My Title",xlab="My x",ylab="My y",xr=[0,1],labels=["y1","y2","y3"])
```
"""
function plot(x,Y; grid::Bool=true, scatter::Bool=false, title=nothing, xlab=nothing, ylab=nothing, key=nothing, labels=nothing, xr=[NaN,NaN], yr=[NaN,NaN],
        linetype=nothing, linewidth=nothing, linecolor=nothing, xlog::Bool=false, ylog::Bool=false)
    # assertions and input processing
    @assert !isempty(x)
    @assert !isempty(Y)
    Lx = length(x)
    Ly, Ny = size(Y)
    dimsx = length(size(x))
    dimsY = length(size(Y))
    @assert dimsx == 1 "x must be 1D"
    @assert dimsY <= 2 "Y must be 1D or 2D"
    @assert Lx == Ly "x and Y (or its columns) must have equal number of observations"
    
    ptype = ifelse(scatter,"p","l")
    
    # plot setup
    out = Vector{Gnuplot.PlotElement}()
    grid && push!(out,PlotElement(cmds=["set grid"]))
    !isnothing(title) && push!(out, PlotElement(;tit=title))
    !isnothing(xlab) && push!(out, PlotElement(;xlabel=xlab))
    !isnothing(ylab) && push!(out, PlotElement(;ylabel=ylab))
    !isnothing(key) && push!(out, PlotElement(;key=key))
    !isnothing(xr) && push!(out, PlotElement(;xrange=xr))
    !isnothing(yr) && push!(out, PlotElement(;yrange=yr))
    push!(out, PlotElement(;xlog=xlog,ylog=ylog))

    # do plotting
    for i in 1:Ny
        plotstr = "w $ptype"
        if !isnothing(labels)
            if length(labels) >= i
                thislab = labels[i]
                plotstr = string(plotstr," t '$thislab'")
            end
        end
        if !isnothing(linetype)
            if length(linetype) >= i
                thislt = linetype[i]
                plotstr = string(plotstr," $thislt")
            end
        end
        if !isnothing(linewidth)
            if length(linewidth) >= i
                thislw = linewidth[i]
                plotstr = string(plotstr," lw $thislw")
            end
        end
        if !isnothing(linecolor)
            if length(linecolor) >= i
                thiscolor = linecolor[i]
                plotstr = string(plotstr," lc rgb '$thiscolor'")
            end
        end
        
        push!(out, PlotElement(data=DatasetText(x, Y[:,i]), plot=plotstr))
    end
    return out
end




end # module
