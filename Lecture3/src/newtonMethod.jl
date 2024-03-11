module NewtonMethod

function newton_method(f, f_prime, x0, tolerance, max_iterations)
    x = x0
    for i in 1:max_iterations
        x -= f(x) / f_prime(x)
        if abs(f(x)) < tolerance
            return x
        end
    end
    error("Maximum number of iterations reached")
end

export newton_method
end