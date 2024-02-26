module LogMap

function logisticMap(xn, r)
    xm = (1 - xn) * r * xn
    return xm  
end

function generateRandomLogisticMap(NTotal, N0, r)
    list = Array{Float64}(undef, NTotal)
    list[1] = N0

    for i in 2:NTotal
        list[i] = logisticMap(list[i - 1], r)
    end

    return list
end

export generateRandomLogisticMap
end