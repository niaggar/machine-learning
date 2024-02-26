module TentMap

limit = 1/2
function tentMap(xn, mu)
    global limit
    xm = 0.0f0

    if xn < limit
        xm = mu * xn
    else
        xm = (1 - xn) * mu
    end
    
    return xm  
end

function generateRandomTentMap(NTotal, N0, mu)
    list = Array{Float64}(undef, NTotal)
    list[1] = N0

    for i in 2:NTotal
        list[i] = tentMap(list[i - 1], mu)
    end

    return list    
end

export generateRandomTentMap
end