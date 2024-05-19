using Random
using PlotlyJS

function add_noise(f::Function, noise::Function, noise_level::Float64)
    return x -> f(x) + noise(x) * noise_level
end

function lineWithNoise(func, x0, xf)
    x = range(x0, stop=xf, length=100)
    y = [func(xi) + randn() for xi in x]
    
    return x, y
end

a = 2
b = 3


f(x) = a * x + b
x, y = lineWithNoise(f, 0, 10)

leastSquareMA = zeros(2, 2)
leastSquareVB = zeros(2)
leastSquareMA[1, 1] = sum(x .^ 2)
leastSquareMA[1, 2] = sum(x)
leastSquareMA[2, 1] = sum(x)
leastSquareMA[2, 2] = length(x)
leastSquareVB[1] = sum(x .* y)
leastSquareVB[2] = sum(y)
leastSquareM = inv(leastSquareMA) * leastSquareVB

fLineal(x) = leastSquareM[1] * x + leastSquareM[2]



points = PlotlyJS.scatter(x=x, y=y, mode="markers", name="Original")
line = PlotlyJS.scatter(x=x, y=fLineal.(x), mode="lines", name="Least Square")
PlotlyJS.plot(
    [points, line],
    Layout(title="Least Square", xaxis_title="x", yaxis_title="y", plot_bgcolor="#f0f0f0"))
