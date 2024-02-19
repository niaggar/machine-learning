using Plots

function logisticMap(xn, r)
    xm = (1 - xn) * r * xn
    return xm  
end

N_total = 100
x = Array{Float64}(undef, N_total)
x[1] = 0.01
r = 4
i = 1

while i < N_total
    global i, r, x

    x_0 = x[i]
    x_1 = logisticMap(x_0, r)

    x[i + 1] = x_1
    i += 1
end


list1 = Array{Float64}(undef, N_total)
list2 = Array{Float64}(undef, N_total)
list3 = Array{Float64}(undef, N_total)
i = 1
while i < N_total - 2
    global i, x, list1, list2, list3

    x_0 = x[i]
    x_1 = x[i + 1]
    x_2 = x[i + 2]

    list1[i] = x_0
    list2[i] = x_1
    list3[i] = x_2

    i += 1
end


#scatter(list1, list2)
scatter3d(list1, list2, list3)
