include("src/logMap.jl")
include("src/tentMap.jl")
include("src/utils.jl")

using .LogMap
using .TentMap
using .Utils


N_total = 100000
N0 = 0.023


r = 3.99
logX = generateRandomLogisticMap(N_total, N0, r)
list1Log, list2Log, list3Log = createListsToGraph(logX, N_total)
saveScatterGraph(list1Log, list2Log, "logMap/scatterLogMap.png")
saveScatter3DGraph(list1Log, list2Log, list3Log, "logMap/scatter3DLogMap.png")
saveHistogramGraph(logX, "logMap/histogramLogMap.png")
saveStats(logX, "logMap/statsLogMap.txt")


mu = 1.99
tentX = generateRandomTentMap(N_total, N0, mu)
list1Tent, list2Tent, list3Tent = createListsToGraph(tentX, N_total)
saveScatterGraph(list1Tent, list2Tent, "tentMap/scatterTentMap.png")
saveScatter3DGraph(list1Tent, list2Tent, list3Tent, "tentMap/scatter3DTentMap.png")
saveHistogramGraph(tentX, "tentMap/histogramTentMap.png")
saveStats(tentX, "tentMap/statsTentMap.txt")
