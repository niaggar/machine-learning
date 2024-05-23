module ImgUtils

using MathUtils
using ImgStr
using Images, FileIO

function loadImage(route::String, label::String, specie::String)
    img = FileIO.load(route)
    imgRGB = channelview(img)
    imgFloat = Float64.(imgRGB)
    return ImageStruct(imgFloat, label, specie)
end

function loadImageGray(route::String, label::String, specie::String)
    img = FileIO.load(route)
    imgGray = Float64.(img)
    vector = vectorizeMatrix(imgGray)
    
    return ImageGray(imgGray, vector, label, specie)
end

function loadImageOnlyGray(route::String, label::String, specie::String)
    img = FileIO.load(route)
    imgRGB = channelview(img)
    imgFloat = Float64.(imgRGB)

    if ndims(imgFloat) == 3
        imgGray = 0.2989*imgFloat[1, :, :] + 0.5870*imgFloat[2, :, :] + 0.1140*imgFloat[3, :, :]
        imgGray = clampPrivate.(imgGray)
        imgGray = convert(Matrix{Int}, imgGray)
    else
        imgGray = clampPrivate.(imgFloat)
    end

    vector = vectorizeMatrixInt(imgGray)
    return ImageGray(imgGray, vector, label, specie)
end

function clampPrivate(value::Float64)
    if value < 0.8
        return 0
    elseif value >= 0.8
        return 1
    end
end

function createImageGray(image::ImageStruct)
    imgGray = 0.2989*image.imgRGB[1, :, :] + 0.5870*image.imgRGB[2, :, :] + 0.1140*image.imgRGB[3, :, :]
    imgGray = clamp.(imgGray, 0, 1)
    imgGray = convert(Matrix{Float64}, imgGray)
    vector = vectorizeMatrix(imgGray)
    
    return ImageGray(imgGray, vector, image.label, image.specie)
end

function saveImageGray(image::ImageGray, route::String)
    img = Gray.(image.imgGray)
    save(route, img)    
end

export vectorizeImage, loadImage, loadImageGray, createImageGray, saveImageGray, loadImageOnlyGray
end