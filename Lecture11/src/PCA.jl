push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture11/src/")

using ImgFormat
using ImgUtils
using ImgPlot
using MathUtils
using LinearAlgebra
using Plots
using Statistics
using CSV
using DataFrames

folderImages = "/Users/niaggar/Developer/Training/numbers-standardized/"
numberOfImages = 30
images = []
for i in 1:numberOfImages
    imgOneName = "Ones-" * string(i)
    imageOne = loadImageOnlyGray(folderImages * imgOneName * ".jpg", string(i), "One")

    imgZeroName = "Zeros-" * string(i)
    imageZero = loadImageOnlyGray(folderImages * imgZeroName * ".jpg", string(i), "Zero")

    push!(images, imageOne)
    push!(images, imageZero)
end


X = hcat([image.vector for image in images]...)
X_centered = X .- mean(X, dims=2)
desc = svd(X_centered)

principal_components = desc.U[:, 1:4]
projected_images = principal_components' * X_centered

principalComponentsDf = DataFrame(
    Label = [image.label for image in images],
    Species = [image.specie for image in images],
    PCA1 = projected_images[1, :],
    PCA2 = projected_images[2, :],
    PCA3 = projected_images[3, :],
    PCA4 = projected_images[4, :]
)

CSV.write("principal_components.csv", principalComponentsDf)



# Separar los datos según el label
species = [image.specie for image in images]
labels = [image.label for image in images]
ones_indices = findall(x -> x == "One", species)
zeros_indices = findall(x -> x == "Zero", species)

# Graficar PCA1 vs PCA2
pca1_ones = projected_images[1, ones_indices]
pca2_ones = projected_images[2, ones_indices]
labels_ones = labels[ones_indices]
pca1_zeros = projected_images[1, zeros_indices]
pca2_zeros = projected_images[2, zeros_indices]
labels_zeros = labels[zeros_indices]

plot(
    title="PCA1 vs PCA2",
    xlabel="PCA1",
    ylabel="PCA2",
    label="Ones",
    size=(900, 900),
    dpi=300
)

scatter!(pca1_ones, pca2_ones, label="Ones", color=:blue)
scatter!(pca1_zeros, pca2_zeros, label="Zeros", color=:red)

annotate!(pca1_ones, pca2_ones .+ 0.25, text.(labels_ones, :blue, 8))
annotate!(pca1_zeros, pca2_zeros .+ 0.25, text.(labels_zeros, :red, 8))



# Graficar PCA2 vs PCA3
pca2_ones = projected_images[2, ones_indices]
pca3_ones = projected_images[3, ones_indices]
pca2_zeros = projected_images[2, zeros_indices]
pca3_zeros = projected_images[3, zeros_indices]

plot(
    title="PCA2 vs PCA3",
    xlabel="PCA2",
    ylabel="PCA3",
    label="Ones",
    size=(900, 900),
    dpi=300
)

scatter!(pca2_ones, pca3_ones, label="Ones", color=:blue)
scatter!(pca2_zeros, pca3_zeros, label="Zeros", color=:red)

annotate!(pca2_ones, pca3_ones .+ 0.25, text.(labels_ones, :blue, 8))
annotate!(pca2_zeros, pca3_zeros .+ 0.25, text.(labels_zeros, :red, 8))




# Graficar PCA3 vs PCA1
pca1_ones = projected_images[1, ones_indices]
pca3_ones = projected_images[3, ones_indices]
pca1_zeros = projected_images[1, zeros_indices]
pca3_zeros = projected_images[3, zeros_indices]

plot(
    title="PCA1 vs PCA3",
    xlabel="PCA1",
    ylabel="PCA3",
    label="Ones",
    size=(900, 900),
    dpi=300
)

scatter!(pca1_ones, pca3_ones, label="Ones", color=:blue)
scatter!(pca1_zeros, pca3_zeros, label="Zeros", color=:red)

annotate!(pca1_ones, pca3_ones .+ 0.25, text.(labels_ones, :blue, 8))
annotate!(pca1_zeros, pca3_zeros .+ 0.25, text.(labels_zeros, :red, 8))