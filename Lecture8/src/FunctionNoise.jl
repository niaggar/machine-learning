module FunctionNoise

using Random

function add_noise(f::Function, noise::Function, noise_level::Float64)
    return x -> f(x) + noise(x) * noise_level
end

export add_noise
end