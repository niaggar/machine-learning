module Utils
using Plots
using Statistics
using StatsBase

function createListsToGraph(x, N_total)
    list1 = Array{Float64}(undef, N_total)
    list2 = Array{Float64}(undef, N_total)
    list3 = Array{Float64}(undef, N_total)
    
    i = 1
    while i < N_total - 2
        x_0 = x[i]
        x_1 = x[i + 1]
        x_2 = x[i + 2]

        list1[i] = x_0
        list2[i] = x_1
        list3[i] = x_2

        i += 1
    end

    return list1, list2, list3    
end

function saveScatterGraph(list1, list2, fileName)
    scatter(list1, list2, xlabel="Xn", ylabel="Xn+1", title="Scatter", legend=false)
    savefig(fileName)
end

function saveScatter3DGraph(list1, list2, list3, fileName)
    scatter3d(list1, list2, list3, xlabel="Xn", ylabel="Xn+1", zlabel="Xn+2", title="Scatter 3D", legend=false)
    savefig(fileName)
end

function saveHistogramGraph(list, fileName)
    histogram(list, bins=:20, xlabel="Valor", ylabel="Frecuencia", seriestype=:bars, title="Histograma de Frecuencias", normalize=true, legend=false)
    savefig(fileName)
end

function saveStats(list, fileName)
    media = mean(list)
    varianza = var(list)
    asimetria = skewness(list)
    curtosis = kurtosis(list)

    open(fileName, "w") do f
        write(f, "Media: $media\n")
        write(f, "Varianza: $varianza\n")
        write(f, "Asimetría: $asimetria\n")
        write(f, "Curtosis: $curtosis\n")
    end
end

export createListsToGraph, saveScatterGraph, saveScatter3DGraph, saveHistogramGraph, saveStats    
end