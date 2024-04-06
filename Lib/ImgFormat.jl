module ImgFormat

using ImgStr
using MathUtils
using Images, FileIO

function reduceImage(img::ImageStruct, newSize::Tuple{Int, Int})
    imgRGB = img.imgRGB

    red = reduceMatrix(imgRGB[1, :, :], newSize)
    green = reduceMatrix(imgRGB[2, :, :], newSize)
    blue = reduceMatrix(imgRGB[3, :, :], newSize)
    imgFloat = cat(red, green, blue, dims=1)
    
    return ImageStruct(imgFloat, img.label)    
end

function reduceImageGray(img::ImageGray, newSize::Tuple{Int, Int})
    imgGray = img.imgGray

    newGray = reduceMatrix(imgGray, newSize)
    newVector = vectorizeMatrix(newGray)

    return ImageGray(newGray, newVector, img.label)
end

function transformTreshold(img::ImageGray, treshold::Float64)
    imgGray = img.imgGray

    for i in eachindex(imgGray)
        imgGray[i] = imgGray[i] > treshold ? 1 : 0
    end

    vector = vectorizeMatrix(imgGray)
    return ImageGray(imgGray, vector, img.label)
end


export reduceImage, reduceImageGray, transformTreshold    
end