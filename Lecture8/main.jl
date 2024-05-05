push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture8/src/")

using PlotlyJS

A = 10
B = -1
func1(x) = A*x*exp(B*x)

x = 0.1:0.1:10
y = func1.(x)


using FunctionNoise

noise_level = 0.1
noise(x) = randn()

f = add_noise(func1, noise, noise_level)
y_noisy = f.(x)



plot(scatter(xb=x, y=y_noisy, mode="markers", name="f(x) = Ax*exp(Bx)"))


yx_noisy = y_noisy ./ x
yx_noisy = yx_noisy .+ abs(minimum(yx_noisy))
ln_yx_noisy = log.(abs.(yx_noisy))

plot(scatter(x=x, y=ln_yx_noisy, mode="markers", name="ln(f(x)/x)"))

# Aply linear regression to noisy data
using LinearRegression

X = hcat(ones(length(x)), x)

linreg = LinearRegression.linregress(x, ln_yx_noisy)

slope = coef(linreg)[2]
intercept = coef(linreg)[1]




plot(scatter(x=x, y=ln_yx_noisy, mode="markers", name="ln(f(x)/x)"))
plot!(scatter(x=x, y=coef(linreg)'*X', mode="lines", name="Linear regression"))





