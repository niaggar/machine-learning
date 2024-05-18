push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture8/src/")

using ImgFormat
using ImgUtils
using ImgPlot
using ImgStr
using MathUtils
using LinearAlgebra
using PlotlyJS
using DataFrames
using CSV


a = 2
b = 3
f(x) = a * x + b

function lineWithNoise(func, x0, xf)
    x = range(x0, stop=xf, length=100)
    y = [func(xi) + randn() for xi in x]
    
    return x, y
end

x, y = lineWithNoise(f, 0, 10)
df = DataFrame(
    xdata = x,
    ydata = y
)

plot(
    df,
    x = :xdata, y = :ydata,
    mode = "markers",
    type = "scatter", 
    labels=Dict(
        :xdata => "X",
        :ydata => "Y"
    ),
    Layout(title = "Line")
)





