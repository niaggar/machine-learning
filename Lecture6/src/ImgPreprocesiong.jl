push!(LOAD_PATH, "./Lib/")

using ImgFormat
using ImgUtils
using ImgPlot


folderImages = "DATA-01/"
folderOutput = "DATA-01/standardized/"
numberOfImages = 30
treshold = 0.48

for i in 1:numberOfImages
    currentnum = string(i)
    if length(currentnum) == 1
        currentnum = "0"*currentnum
    end

    image = loadImage(folderImages * "1-" * currentnum * ".jpg", "1-" * currentnum)
    grayImage = createImageGray(image)
    reducedImage = reduceImageGray(grayImage, (50, 50))
    tresholdImage = transformTreshold(reducedImage, treshold)
    saveImageGray(tresholdImage, folderOutput * "1-" * currentnum * ".jpg")
end

for i in 1:numberOfImages
    currentnum = string(i)
    if length(currentnum) == 1
        currentnum = "0"*currentnum
    end

    image = loadImage(folderImages * "0-" * currentnum * ".jpg", "0-" * currentnum)
    grayImage = createImageGray(image)
    reducedImage = reduceImageGray(grayImage, (50, 50))
    tresholdImage = transformTreshold(reducedImage, treshold)
    saveImageGray(tresholdImage, folderOutput * "0-" * currentnum * ".jpg")
end