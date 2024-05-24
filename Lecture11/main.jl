push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture11/src/")

using KMeans
using Clasification

using LinearAlgebra
using Plots
using Statistics
using CSV
using DataFrames


kmeansResult = CSV.read("kmeans_result.csv", DataFrame)

pointsItems = [
    Point2D(row.xdata, row.ydata, string(row.label), row.centroid, row.original) 
    for row in eachrow(kmeansResult) 
    if row[:isCentroid] == false
]

pointsCentroids = [
    Point2D(row.xdata, row.ydata, string(row.label), row.centroid, row.original) 
    for row in eachrow(kmeansResult) 
    if row[:isCentroid] == true
]

grupsNames = unique([point.centroid for point in pointsItems])
divLine = Perceptron(pointsItems, grupsNames, 1000)
maxX = maximum([point.x for point in pointsItems])
minX = minimum([point.x for point in pointsItems])

pointsLine = getXYPoints(divLine, minX, maxX)
groupOne = [
    point 
    for point in pointsItems 
    if point.centroid == "Item-C1"
]
groupTwo = [
    point 
    for point in pointsItems 
    if point.centroid == "Item-C2"
]


 

plot(
    title="SVC",
    xlabel="PCA1",
    ylabel="PCA2",
    label="Ones",
    size=(900, 900),
    dpi=300
)

scatter!([point.x for point in groupOne], [point.y for point in groupOne], label="Group One")
scatter!([point.x for point in groupTwo], [point.y for point in groupTwo], label="Group Two")
scatter!([point.x for point in pointsCentroids], [point.y for point in pointsCentroids], label="Centroids", markercolor="black", markersize=10)
plot!(pointsLine[1], pointsLine[2], label="Line", linewidth=2)
