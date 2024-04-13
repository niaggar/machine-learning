push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture7/src/")

using FFTW
using Plots
using FourierTransform


f(x, w) = sin(w * x)

periodo = 1/2
frecuency = 2*pi / periodo 
xPoints = 0:0.001:pi
testData = [f(x, frecuency) for x in xPoints]
plot(xPoints, testData, label="f(x)", marker=:circle)


implementatio = FourierTransform.discreteFourierTransform(testData)
omegas = [2.0 * π * (u - 1) / length(testData) for u in 1:length(testData)]
println(omegas)
plot(omegas .- pi, abs.(implementatio), label="My Fourier transform", marker=:circle)
