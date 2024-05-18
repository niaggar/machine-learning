push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture8/src/")

using ImgFormat
using ImgUtils
using ImgPlot
using ImgStr
using MathUtils

using LinearAlgebra
using PlotlyJS
using DataFrames
using CSV


folderImages = "DATA-01/standardized/"
numberOfImages = 30

images = []
for i in 1:numberOfImages
	currentnum = string(i)
	if length(currentnum) == 1
		currentnum = "0" * currentnum
	end

	imageOne = loadImageGray(folderImages * "1-" * currentnum * ".jpg", "1-" * currentnum, "1")
	imageZero = loadImageGray(folderImages * "0-" * currentnum * ".jpg", "0-" * currentnum, "0")

	push!(images, imageOne)
	push!(images, imageZero)
end

img = images[1]
X = hcat([image.vector for image in images]...)
desc = svd(X)


Vt = desc.Vt[1:3, :]
pca1 = Vt[1, :]
pca2 = Vt[2, :]
pca3 = Vt[3, :]

mutable struct Point2D
    x::Float64
    y::Float64
    label::String
    centroid::String
    original::String
end

function graphIteration(points, centroids, name, iteration)
    pointsAndCentroids = deepcopy(points)
    for centroid in centroids
        push!(pointsAndCentroids, Point2D(centroid.x, centroid.y, centroid.label, centroid.label, ""))
    end

    newdf = DataFrame(
        xdata = [point.x for point in pointsAndCentroids],
        ydata = [point.y for point in pointsAndCentroids],
        species = [point.centroid for point in pointsAndCentroids],
        label = [point.label for point in pointsAndCentroids]
    )

    p = plot(
        newdf,
        x = :xdata, y = :ydata, color = :species,
        type = "scatter", mode = "markers", text = :label,
        labels=Dict(
            :xdata => "PCA 2",
            :ydata => "PCA 3",
            :species => "Grupo de imágenes"
        ),
        Layout(title = "KMeans")
    )

    savefig(p, name * "-" * string(iteration) * ".png")
end

function createRandomCentroid(num, limitsX, limitsY)
    centroids = []
    for i in 1:num
        x = rand() * (limitsX[2] - limitsX[1]) + limitsX[1]
        y = rand() * (limitsY[2] - limitsY[1]) + limitsY[1]
        push!(centroids, Point2D(x, y, "C" * string(i), "CG" * string(i), ""))
    end
    return centroids
end

function euclideanDistance(p1::Point2D, p2::Point2D)
    return sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
end

function assignPointsToCentroids(points, centroids)
    for point in points
        minDist = Inf
        for centroid in centroids
            dist = euclideanDistance(point, centroid)
            if dist < minDist
                minDist = dist
                point.centroid = centroid.centroid
            end
        end
    end
end

function updateCentroids(points, centroids)
    for centroid in centroids
        x = 0.0
        y = 0.0
        count = 0

        for point in points
            if point.centroid == centroid.centroid
                x += point.x
                y += point.y
                count += 1
            end
        end

        if count > 0
            centroid.x = x / count
            centroid.y = y / count
        end
    end
end

function kmeans(points, k, maxIter, name="KMeans")
    limitsX = extrema([point.x for point in points])
    limitsY = extrema([point.y for point in points])
    centroids = createRandomCentroid(k, limitsX, limitsY)

    for i in 1:maxIter
        graphIteration(points, centroids, name, i)
        assignPointsToCentroids(points, centroids)
        updateCentroids(points, centroids)
    end

    return centroids
end

# Validate the results

points = []
numberOfClusters = 2
for i in 1:length(pca1)
    x = pca1[i]
    y = pca2[i]
    originalLabel = images[i].specie
    point = Point2D(x, y, "Def", "Def", originalLabel)

    push!(points, point)    
end

c = kmeans(points, numberOfClusters, 10, "KMeans-2")



# Agrup points by cluster
totalCeros = length([point for point in points if point.original == "0"])
totalUnos = length([point for point in points if point.original == "1"])

for k in 1:numberOfClusters
    clusterPoints = [point for point in points if point.centroid == "CG" * string(k)]

    # Number of Ones and Zeros
    ones = length([point for point in clusterPoints if point.original == "1"])
    zeros = length([point for point in clusterPoints if point.original == "0"])

    
    println("Cluster $k")
    println("Total de unos: $ones")
    println("Total de ceros: $zeros")

    println("Proporción de unos: $(ones / totalUnos)")
    println("Proporción de ceros: $(zeros / totalCeros)")
end

