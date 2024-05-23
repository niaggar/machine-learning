push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture11/src/")

using KMeans

using LinearAlgebra
using Plots
using Statistics
using CSV
using DataFrames

fileRoute = "/Users/niaggar/Developer/Training/numbers-standardized/principal_components.csv"

struct PCAPoint
    label::String
    specie::String
    pca1::Float64
    pca2::Float64
    pca3::Float64
    pca4::Float64
end

function readCSV(fileRoute)
    df = CSV.read(fileRoute, DataFrame)
    return [PCAPoint(string(row.Label), row.Species, row.PCA1, row.PCA2, row.PCA3, row.PCA4) for row in eachrow(df)]
end

function pcaToPoints(points, field1, field2)
    return [Point2D(getfield(point, field1), getfield(point, field2), point.label, "", point.specie) for point in points]
end

points = readCSV(fileRoute)
pointsPCA1PCA2 = pcaToPoints(points, :pca1, :pca2)
centroids = kmeans(pointsPCA1PCA2, 2, 0.1)


# Clasifica los puntos en los clusters
oneColor = "red"
zeroColor = "blue"

pointsCluster1 = [point for point in pointsPCA1PCA2 if point.centroid == "Item-" * string(centroids[1].centroid)]
pointsCluster2 = [point for point in pointsPCA1PCA2 if point.centroid == "Item-" * string(centroids[2].centroid)]
pointsOnes = [point for point in pointsPCA1PCA2 if point.original == "One"]
pointsZeros = [point for point in pointsPCA1PCA2 if point.original == "Zero"]

plot(
    title="K-means clustering",
    xlabel="PCA1",
    ylabel="PCA2",
    label="Ones",
    size=(800, 800),
    dpi=300,
)

scatter!([point.x for point in pointsOnes], [point.y for point in pointsOnes], label="Ones", color=oneColor, markersize=10, alpha=0.2)
scatter!([point.x for point in pointsZeros], [point.y for point in pointsZeros], label="Zeros", color=zeroColor, markersize=10, alpha=0.2)
scatter!([point.x for point in pointsCluster1], [point.y for point in pointsCluster1], label="Cluster 1", color=if (centroids[1].original == "One") oneColor else zeroColor end)
scatter!([point.x for point in pointsCluster2], [point.y for point in pointsCluster2], label="Cluster 2", color=if (centroids[2].original == "One") oneColor else zeroColor end)


# Save the kmeans result
kmeansDf = DataFrame(
    xdata = [point.x for point in centroids],
    ydata = [point.y for point in centroids],
    centroid = [point.centroid for point in centroids],
    original = [point.original for point in centroids],
    label = [point.label for point in centroids],
    isCentroid = [true for point in centroids]
)

pointsDf = DataFrame(
    xdata = [point.x for point in pointsPCA1PCA2],
    ydata = [point.y for point in pointsPCA1PCA2],
    centroid = [point.centroid for point in pointsPCA1PCA2],
    original = [point.original for point in pointsPCA1PCA2],
    label = [point.label for point in pointsPCA1PCA2],
    isCentroid = [false for point in pointsPCA1PCA2]
)

# Concatenate the dataframes
finalDdata = vcat(kmeansDf, pointsDf)
CSV.write("kmeans_result.csv", finalDdata)