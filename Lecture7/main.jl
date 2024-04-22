push!(LOAD_PATH, "./Lib/")
push!(LOAD_PATH, "./Lecture7/src/")

using FFTW
using LinearAlgebra
using PlotlyJS
using Plots
using DataFrames
using CSV
using ImgFormat
using ImgUtils
using ImgPlot
using ImgStr
using Fourier


# Fourier transform, Gaussian filter and inverse Fourier transform
imageOne = loadImage("Lecture7/rick.jpg", "Rick", "Rick")
imageOneGray = createImageGray(imageOne)
pltGrayImage(imageOneGray, "Lecture7/results/rickGray.png")

imageOneFourier = fftwImage(imageOneGray)
pltFourier(imageOneFourier, "Lecture7/results/rickFourier.png")

sigma = 50.0
gaussMatrix = getGaussianMatrix(size(imageOneFourier.amplitude), sigma)
gaussMatrixImage = ImageGray(gaussMatrix, [], "Gauss", "Gauss")
pltGrayImage(gaussMatrixImage, "Lecture7/results/gaussMatrix.png")

imageOneFourierGauss = gaussianFilter(imageOneFourier, gaussMatrix)
pltFourier(imageOneFourierGauss, "Lecture7/results/rickFourierGauss.png")

imageOneGauss = ifftwImage(imageOneFourierGauss)
pltGrayImage(imageOneGauss, "Lecture7/results/rickGauss.png")

inverseGaussMatrix = 1 .- gaussMatrix
inverseGaussMatrixImage = ImageGray(inverseGaussMatrix, [], "Inverse Gauss", "Inverse Gauss")
pltGrayImage(inverseGaussMatrixImage, "Lecture7/results/inverseGaussMatrix.png")

imageOneFourierInverseGauss = gaussianFilter(imageOneFourier, inverseGaussMatrix)
pltFourier(imageOneFourierInverseGauss, "Lecture7/results/rickFourierInverseGauss.png")

imageOneInverseGauss = ifftwImage(imageOneFourierInverseGauss)
pltGrayImage(imageOneInverseGauss, "Lecture7/results/rickInverseGauss.png")









# PCA with images and Fourier transform
image = loadImage("DATA-01/0-01.jpg", "0-01", "0")
imgGray = createImageGray(image)
imgFourier = fftwImage(imgGray)
pltFourierN(imgFourier)

folderImages = "DATA-01/"
numberOfImages = 30
images = []
for i in 1:numberOfImages
    currentnum = string(i)
    if length(currentnum) == 1
        currentnum = "0" * currentnum
    end

    imageOne = loadImage(folderImages * "1-" * currentnum * ".jpg", "1-" * currentnum, "1")
    imageOneGray = createImageGray(imageOne)
    imageOneFourier = fftwImage(imageOneGray)

    imageZero = loadImage(folderImages * "0-" * currentnum * ".jpg", "0-" * currentnum, "0")
    imageZeroGray = createImageGray(imageZero)
    imageZeroFourier = fftwImage(imageZeroGray)

    push!(images, imageOneFourier)
    push!(images, imageZeroFourier)
end

X = hcat([image.vector for image in images]...)
desc = svd(X)

println("Number of images: ", length(images))
println("U: ", size(desc.U))
println("S: ", size(desc.S))
println("Vt: ", size(desc.Vt))


Vt = desc.Vt[1:3, :]
xdata = Vt[1, :]
ydata = Vt[2, :]
zdata = Vt[3, :]
df = DataFrame(
    xdata = xdata,
    ydata = ydata,
    zdata = zdata,
    species = [image.specie for image in images],
    label = [image.label for image in images]
)

PlotlyJS.plot(
    df,
    x = :xdata, y = :ydata, z = :zdata, color = :species,
    type = "scatter3d", mode = "markers", text = :label,
    labels=Dict(
        :xdata => "PCA 1",
        :ydata => "PCA 2",
        :zdata => "PCA 3",
        :species => "Grupo de imágenes"
    ),
    Layout(title = "PCA 1 vs PCA 2 vs PCA 3")
)

PlotlyJS.plot(
    df,
    x = :xdata, y = :ydata, color = :species,
    type = "scatter", mode = "markers", text = :label,
    labels=Dict(
        :xdata => "PCA 1",
        :ydata => "PCA 2",
        :zdata => "PCA 3",
        :species => "Grupo de imágenes"
    ),
    Layout(title = "PCA 1 vs PCA 2")
)

PlotlyJS.plot(
    df,
    x = :xdata, y = :zdata, color = :species,
    type = "scatter", mode = "markers", text = :label,
    labels=Dict(
        :xdata => "PCA 1",
        :ydata => "PCA 2",
        :zdata => "PCA 3",
        :species => "Grupo de imágenes"
    ),
    Layout(title = "PCA 1 vs PCA 3")
)

PlotlyJS.plot(
    df,
    x = :ydata, y = :zdata, color = :species,
    type = "scatter", mode = "markers", text = :label,
    labels=Dict(
        :xdata => "PCA 1",
        :ydata => "PCA 2",
        :zdata => "PCA 3",
        :species => "Grupo de imágenes"
    ),
    Layout(title = "PCA 2 vs PCA 3")
)


