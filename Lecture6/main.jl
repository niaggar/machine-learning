push!(LOAD_PATH, "./Lib/")

using ImgFormat
using ImgUtils
using ImgPlot
using LinearAlgebra


folderImages = "DATA-01/standardized/"
numberOfImages = 30

images = []
for i in 1:numberOfImages
    currentnum = string(i)
    if length(currentnum) == 1
        currentnum = "0"*currentnum
    end

    imageOne = loadImageGray(folderImages * "1-" * currentnum * ".jpg", "1-" * currentnum)
    imageZero = loadImageGray(folderImages * "0-" * currentnum * ".jpg", "0-" * currentnum)

    push!(images, imageOne)
    push!(images, imageZero)
end

println("Number of images: ", length(images))

X = hcat([image.vector for image in images]...)
desc = svd(X)


# Print the sizes of the matrices
println("U: ", size(desc.U))
println("S: ", size(desc.S))
println("Vt: ", size(desc.Vt))

# Reconstruct the matrix
# X_reconstructed = desc.U * diagm(desc.S) * desc.Vt


# get the 3 firtst vectors of Vt
Vt = desc.Vt[1:3, :]


# Graph the 3 first vectors of Vt in 3D
using PlotlyJS
using DataFrames

x = Vt[1, :]
y = Vt[2, :]
z = Vt[3, :]

df = DataFrame(x=x, y=y, z=z, species=[image.label for image in images])
plot(
    df,
    x=:sepal_length, y=:sepal_width, z=:petal_width, color=:species,
    type="scatter3d", mode="markers"
)
