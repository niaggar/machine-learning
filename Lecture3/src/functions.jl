module Functions

function exponential(x::Float64)
    return exp(x)
end

function exponential_taylor(x::Float64, n::Int)
    result = 0.0
    for i in 0:n
        result += x^i / factorial(i)
    end
    return result
end


function logarithm(x::Float64)
    return log(1+x)
end

function logarithm_taylor(x::Float64, n::Int)
    result = 0.0
    for i in 0:n
        result += (-1)^(i) * x^(i+1) / (i+1)
    end
    return result
end


export exponential, exponential_taylor, logarithm, logarithm_taylor
end