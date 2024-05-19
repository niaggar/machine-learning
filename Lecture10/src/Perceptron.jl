using Clasification
using DataFrames
using CSV
using KMeans
using PlotlyJS


descVt = CSV.read("DATA-01/standardized/pca.csv", DataFrame, header=true)
labels = descVt[:, 1]
pca1 = descVt[:, 2]
pca2 = descVt[:, 3]
pca3 = descVt[:, 4]


# Crea los puntos2d
points = Array{Point2D}(undef, 0)
for i in 1:length(labels)
    labelsAsString = string(labels[i])
    push!(points, Point2D(pca1[i], pca2[i], labelsAsString, "", ""))
end

centroids = Array{Point2D}(kmeans(points, 2, 10000))

centroidDf = DataFrame(
    xdata = [point.x for point in centroids],
    ydata = [point.y for point in centroids],
    species = [point.centroid for point in centroids]
)
pointsDf = DataFrame(
    xdata = [point.x for point in points],
    ydata = [point.y for point in points],
    species = [point.centroid for point in points],
    label = [point.label for point in points]
)

grupsNames = unique([point.centroid for point in points])
divLine = Perceptron(points, grupsNames, 10000)
maxX = maximum(pointsDf.xdata)
minX = minimum(pointsDf.xdata)

pointsLine = getXYPoints(divLine, minX, maxX)
groupzero = pointsDf[pointsDf.species .== "Item-CG2", :]
groupone = pointsDf[pointsDf.species .== "Item-CG1", :]

numberOfOnesOnGroupOne = nrow(groupone[groupone.label .== "1", :])
numberOfZerosOnGroupOne = nrow(groupone[groupone.label .== "0", :])
isGroupOneOnes = numberOfOnesOnGroupOne > numberOfZerosOnGroupOne

groupOneOriginal = pointsDf[pointsDf.label .== "1", :]
groupZeroOriginal = pointsDf[pointsDf.label .== "0", :]



lineScatter = PlotlyJS.scatter(
    x=pointsLine[1],
    y=pointsLine[2],
    mode="lines",
    name="Line"
)

groupOneScatter = PlotlyJS.scatter(
    x=groupone.xdata,
    y=groupone.ydata,
    mode="markers",
    name="Group 1",
    marker_color=if (isGroupOneOnes) "red" else "blue" end
)

groupZeroScatter = PlotlyJS.scatter(
    x=groupzero.xdata,
    y=groupzero.ydata,
    mode="markers",
    name="Group 0",
    marker_color=if (isGroupOneOnes) "blue" else "red" end
)

centroidsScatter = PlotlyJS.scatter(
    x=centroidDf.xdata,
    y=centroidDf.ydata,
    mode="markers",
    name="Centroids",
    marker_color="black",
    marker_size=20
)

originalGroupOne = PlotlyJS.scatter(
    x=groupOneOriginal.xdata,
    y=groupOneOriginal.ydata,
    mode="markers",
    marker=attr(size=20, sizeref=20 / (20^2), sizemode="area"),
    name="1's",
    marker_color="red",
    opacity=0.1,
)

originalGroupZero = PlotlyJS.scatter(
    x=groupZeroOriginal.xdata,
    y=groupZeroOriginal.ydata,
    mode="markers",
    marker=attr(size=20, sizeref=20 / (20^2), sizemode="area"),
    name="0's",
    marker_color="blue",
    opacity=0.1
)
println("The line equation is: y = $((divLine.equals - divLine.c) / (divLine.b)) - $(divLine.a / divLine.b) * x")

PlotlyJS.plot(
    [originalGroupOne, originalGroupZero, lineScatter, groupOneScatter, groupZeroScatter, centroidsScatter],
    Layout(title="SVM", plot_bgcolor="#f0f0f0"),
)

# y = ((line.equals - line.c) / line.b) .- (line.a / line.b) .* x


