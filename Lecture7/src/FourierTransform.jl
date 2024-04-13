module FourierTransform

function discreteFourierTransform(data::Vector{Float64})
    numberOfDataPoints = length(data)
    numberOfOmegaPoints = numberOfDataPoints
    fourierTransform = zeros(Complex{Float64}, numberOfDataPoints)

    for u in 1:numberOfOmegaPoints
        fourierTransform[u] = 0.0
        omega = 2.0 * π * (u - 1) / numberOfDataPoints

        for k in 1:numberOfDataPoints
            fourierTransform[u] += data[k] * exp(-1im * omega * (k - 1))
        end
    end

    return fourierTransform
end

export discreteFourierTransform
end