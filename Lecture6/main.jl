push!(LOAD_PATH, "./Lib/")

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

X = hcat([image.vector for image in images]...)
imageX = ImageGray(X, vectorizeMatrix(X), "X", "X")
saveImageGray(imageX, "Lecture6/X.jpg")



desc = svd(X)

# U = desc.U
# S = desc.S
# Vt = desc.Vt

# newS = vcat(S[1:3], zeros(length(S) - 3))
# newUS = Diagonal(newS) * Vt

# Print information
println("Number of images: ", length(images))
println("U: ", size(desc.U))
println("S: ", size(desc.S))
println("Vt: ", size(desc.Vt))

# originalImage = desc.U * Diagonal(desc.S) * desc.Vt

# First 3 singular vectors to analyze PCA
Vt = desc.Vt[1:3, :]
xdata = Vt[1, :]
ydata = Vt[2, :]
zdata = Vt[3, :]
df = DataFrame(xdata = xdata, ydata = ydata, zdata = zdata, species = [image.specie for image in images])

plot(
	df,
	x = :xdata, y = :ydata, z = :zdata, color = :species,
	type = "scatter3d", mode = "markers",
    labels=Dict(
        :xdata => "PCA 1",
        :ydata => "PCA 2",
        :zdata => "PCA 3",
        :species => "Grupo de imágenes"
    ),
    Layout(title = "PCA 1 vs PCA 2 vs PCA 3")
)

plot(
	df,
	x = :xdata, y = :ydata, color = :species,
	type = "scatter", mode = "markers",
    labels=Dict(
        :xdata => "PCA 1",
        :ydata => "PCA 2",
        :zdata => "PCA 3",
        :species => "Grupo de imágenes"
    ),
    Layout(title = "PCA 1 vs PCA 2")
)

plot(
	df,
	x = :xdata, y = :zdata, color = :species,
	type = "scatter", mode = "markers",
    labels=Dict(
        :xdata => "PCA 1",
        :ydata => "PCA 2",
        :zdata => "PCA 3",
        :species => "Grupo de imágenes"
    ),
    Layout(title = "PCA 1 vs PCA 3")
)

plot(
    df,
    x = :ydata, y = :zdata, color = :species,
    type = "scatter", mode = "markers",
    labels=Dict(
        :xdata => "PCA 1",
        :ydata => "PCA 2",
        :zdata => "PCA 3",
        :species => "Grupo de imágenes"
    ),
    Layout(title = "PCA 2 vs PCA 3")
)
