push!(LOAD_PATH, "./Lib/")

using ImgFormat
using ImgUtils
using ImgPlot


folderImages = "/Users/niaggar/Developer/Training/numbers-standardized/"
folderOutput = "/Users/niaggar/Developer/Training/numbers-standardized2/"

numberOfImagesOnes = 30
numberOfImagesZeros = 30

treshold = 0.51

for i in 1:numberOfImagesOnes
    imgName = "Ones-" * string(i)

    image = loadImage(folderImages * imgName * ".jpg", imgName, "One") 
    grayImage = createImageGray(image)
    reducedImage = reduceImageGray(grayImage, (50, 50))
    tresholdImage = transformTreshold(reducedImage, treshold)
    saveImageGray(tresholdImage, folderOutput * imgName * ".jpg")
end

for i in 1:numberOfImagesZeros
    imgName = "Zeros-" * string(i)

    image = loadImage(folderImages * imgName * ".jpg", imgName, "Zero")
    grayImage = createImageGray(image)
    reducedImage = reduceImageGray(grayImage, (50, 50))
    tresholdImage = transformTreshold(reducedImage, treshold)
    saveImageGray(tresholdImage, folderOutput * imgName * ".jpg")
end