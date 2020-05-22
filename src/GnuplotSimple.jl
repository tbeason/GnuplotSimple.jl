module GnuplotSimple

using Gnuplot
import Gnuplot: PlotElement, DatasetText

export plot

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
                plotstr = string(plotstr," lt $thislt")
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
