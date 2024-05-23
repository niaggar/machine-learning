module KMeans

using StatsBase

mutable struct Point2D
    x::Float64
    y::Float64
    label::String
    centroid::String
    original::String
end

function createRandomCentroid(num, limitsX, limitsY)
    centroids = []
    for i in 1:num
        x = rand() * (limitsX[2] - limitsX[1]) + limitsX[1]
        y = rand() * (limitsY[2] - limitsY[1]) + limitsY[1]
        push!(centroids, Point2D(x, y, "C" * string(i), "C" * string(i), ""))
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
                point.centroid = "Item-" * centroid.centroid
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
            if point.centroid == "Item-" * centroid.centroid
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

function setOriginalLabelForCentroid(centroids, points)
    for centroid in centroids
        centroidName = centroid.centroid
        itemCentroidName = "Item-" * centroidName
        itemCentroid = filter(point -> point.centroid == itemCentroidName, points)

        if length(itemCentroid) > 0
            species = [point.original for point in itemCentroid]
            centroid.original = mode(species)
        end
    end
end

function kmeans(points, k, tolerance, maxIter=1000000)
    limitsX = extrema([point.x for point in points])
    limitsY = extrema([point.y for point in points])

    centroids = createRandomCentroid(k, limitsX, limitsY)
    passCentroids = deepcopy(centroids)

    currentDiff = [Inf for i in 1:k]
    for i in 1:maxIter
        assignPointsToCentroids(points, centroids)
        updateCentroids(points, centroids)

        diff = [euclideanDistance(centroids[i], passCentroids[i]) for i in 1:k]
        if all(diff .< tolerance)
            break
        end

        passCentroids = deepcopy(centroids)
    end

    setOriginalLabelForCentroid(centroids, points)
    return centroids
end

export Point2D, kmeans
end