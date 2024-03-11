include("src/functions.jl")
include("src/newtonMethod.jl")

import Pkg
if !haskey(Pkg.installed(), "Plots")
    Pkg.add("Plots")
end

using Plots
using Statistics
using .Functions
using .NewtonMethod

# Grafica la funcion exponential y su aproximacion de Taylor
x = -2:0.1:2
y = exponential.(x)
y_taylor_n1 = exponential_taylor.(x, 1)
y_taylor_n2 = exponential_taylor.(x, 2)
y_taylor_n3 = exponential_taylor.(x, 3)
y_taylor_n4 = exponential_taylor.(x, 4)
y_taylor_n6 = exponential_taylor.(x, 6)

plot(x, y, label="exp(x)", legend=:topleft, linewidth=5, linecolor=:red, linestyle=:dash)
plot!(x, y_taylor_n1, label="n=1")
plot!(x, y_taylor_n2, label="n=2")
plot!(x, y_taylor_n3, label="n=3")
plot!(x, y_taylor_n4, label="n=4")
plot!(x, y_taylor_n6, label="n=6")
plot!(size=(1000, 800))
savefig("exponential.png")

rel_error(y_true, y_approx) = mean(abs.((y_true .- y_approx) ./ y_true))
error_n1 = rel_error(y, y_taylor_n1)
error_n2 = rel_error(y, y_taylor_n2)
error_n3 = rel_error(y, y_taylor_n3)
error_n4 = rel_error(y, y_taylor_n4)
error_n6 = rel_error(y, y_taylor_n6)
println("Exponencial")
println("Error relativo para n=1: ", error_n1)
println("Error relativo para n=2: ", error_n2)
println("Error relativo para n=3: ", error_n3)
println("Error relativo para n=4: ", error_n4)
println("Error relativo para n=6: ", error_n6)


# Grafica la funcion logaritmo y su aproximacion de Taylor
x = -0.9:0.1:1
y = logarithm.(x)
y_taylor_n1 = logarithm_taylor.(x, 1)
y_taylor_n2 = logarithm_taylor.(x, 2)
y_taylor_n3 = logarithm_taylor.(x, 3)
y_taylor_n4 = logarithm_taylor.(x, 4)
y_taylor_n6 = logarithm_taylor.(x, 6)

plot(x, y, label="log(1+x)", legend=:topleft, linewidth=5, linecolor=:red, linestyle=:dash)
plot!(x, y_taylor_n1, label="n=1")
plot!(x, y_taylor_n2, label="n=2")
plot!(x, y_taylor_n3, label="n=3")
plot!(x, y_taylor_n4, label="n=4")
plot!(x, y_taylor_n6, label="n=6")
plot!(size=(1000, 800))
savefig("logarithm.png")

error_n1 = rel_error(y, y_taylor_n1)
error_n2 = rel_error(y, y_taylor_n2)
error_n3 = rel_error(y, y_taylor_n3)
error_n4 = rel_error(y, y_taylor_n4)
error_n6 = rel_error(y, y_taylor_n6)
println("Logaritmo")
println("Error relativo para n=1: ", error_n1)
println("Error relativo para n=2: ", error_n2)
println("Error relativo para n=3: ", error_n3)
println("Error relativo para n=4: ", error_n4)
println("Error relativo para n=6: ", error_n6)



# Encontrar raices

f1(x) = x^2 - 612
f1_prime(x) = 2x

x0 = 10
tolerance = 1e-10
max_iterations = 100
x = newton_method(f1, f1_prime, x0, tolerance, max_iterations)
println("Raiz de f1 - raiz cuadrada de 612: ", x)


f2(x) = cos(x) - x^3
f2_prime(x) = -sin(x) - 3x^2

x0 = 1
tolerance = 1e-10
max_iterations = 100
x = newton_method(f2, f2_prime, x0, tolerance, max_iterations)
println("Raiz de f2: ", x)


