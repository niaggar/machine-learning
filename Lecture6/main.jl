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

    imageOne = loadImageGray(folderImages * "1-" * currentnum * ".jpg", "1-" * currentnum, "1")
    imageZero = loadImageGray(folderImages * "0-" * currentnum * ".jpg", "0-" * currentnum, "0")

    push!(images, imageOne)
    push!(images, imageZero)
end

println("Number of images: ", length(images))
println("Size of the vector: ", length(images[1].vector))

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
using CSV

x = Vt[1, :]
y = Vt[2, :]
z = Vt[3, :]

df = DataFrame(x=x, y=y, z=z, species=[image.specie for image in images])
plot(
    df,
    x=:x, y=:y, z=:z, color=:species,
    type="scatter3d", mode="markers"
)

# Graph x vs y
plot(
    df,
    x=:x, y=:y, color=:species,
    type="scatter", mode="markers"
)

# Graph x vs z
plot(
    df,
    x=:x, y=:z, color=:species,
    type="scatter", mode="markers"
)

# Graph y vs z
plot(
    df,
    x=:y, y=:z, color=:species,
    type="scatter", mode="markers"
)


