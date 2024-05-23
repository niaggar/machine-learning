push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture11/src/")

using KMeans

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



# Get the points that are labeled as 0
groupZero = [
    point 
    for point in pointsItems 
    if point.label == "0"
]

# Get the points that are labeled as 1
groupOne = [
    point 
    for point in pointsItems 
    if point.label == "1"
]




