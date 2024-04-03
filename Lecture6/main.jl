include("../Lecture4/src/pixelByPixelCorrection.jl")
include("../Lecture4/src/sizeReduction.jl")
include("../Lecture4/src/vectorizeImage.jl")

using .SizeReduction
using .VectorizeImage
using .PixelByPixelCorrection
using FileIO
using Plots
using Images

struct ImageReduced
    img::Matrix{Float64}
    vector::Array{Float64}
    label::String
end

function imgOneName(i)
    return string("1-", i, ".jpg")
end

function imgZeroName(i)
    return string("0-", i, ".jpg")
end



ImgPath = "DATA-01/"
NumberOfNumbers = 4

function loadImages(num)
    global ImgPath

    zeros = []
    ones = []

    for i in 1:num        
        zeroRoute = string(ImgPath, imgZeroName(i))
        oneRoute = string(ImgPath, imgOneName(i))

        zero = FileIO.load(zeroRoute)
        one = FileIO.load(oneRoute)

        

        zeros = push!(zeros, zero)
        ones = push!(ones, one)
    end
    
    return (zeros, ones)
end

function reduce(imgs)
    global NumberOfNumbers
    global SizeReduction

    reduced = []
    test = true
    for i in 1:NumberOfNumbers
        zero = imgs[1][i]
        one = imgs[2][i]

        reducedZero = SizeReduction.reduce_image_size_value(zero, (50, 50))
        reducedOne = SizeReduction.reduce_image_size_value(one, (50, 50))

        

        treshZeroRGB = PixelByPixelCorrection.pixel_by_pixel(imgThumb, transform_tresholding, Dict("treshold" => 0.5))

        zeroBlackWhite = PixelByPixelCorrection.transform_black_and_white(reducedZero)
        oneBlackWhite = PixelByPixelCorrection.transform_black_and_white(reducedOne)

        treshZero = PixelByPixelCorrection.transform_tresholding_matrix(zeroBlackWhite, 0.5)
        treshOne = PixelByPixelCorrection.transform_tresholding_matrix(oneBlackWhite, 0.5)


        # Plot the images
        heatmap(treshZero, color = :greys, colorbar = false, yflip = true, aspect_ratio=:equal)
        savefig(string("Lecture6/", "zero-", i, ".png"))


        zeroVector = VectorizeImage.vectorize_matrix(zeroBlackWhite)
        oneVector = VectorizeImage.vectorize_matrix(oneBlackWhite)

        println("Zero vector size: ", size(zeroVector))

        zeroReduced = ImageReduced(zeroBlackWhite, zeroVector, imgZeroName(i))
        oneReduced = ImageReduced(oneBlackWhite, oneVector, imgOneName(i))

        reduced = push!(reduced, zeroReduced)
        reduced = push!(reduced, oneReduced)
    end

    return reduced    
end

# images = loadImages(NumberOfNumbers)
# imgesReduced = reduce(images)
# println("Images loaded")



imagen = FileIO.load("DATA-01/1-1.jpg")
ChannelView = channelview(imagen)

heatmap(ChannelView[3, :, :], color = :greys, colorbar = true, yflip = true, aspect_ratio=:equal)
savefig(string("Lecture6/", "azul.png"))

heatmap(ChannelView[2, :, :], color = :greys, colorbar = true, yflip = true, aspect_ratio=:equal)
savefig(string("Lecture6/", "verde.png"))

heatmap(ChannelView[1, :, :], color = :greys, colorbar = true, yflip = true, aspect_ratio=:equal)
savefig(string("Lecture6/", "rojo.png"))

resta = ChannelView[3, :, :] - ChannelView[1, :, :]
heatmap(resta, color = :greys, colorbar = true, yflip = true, aspect_ratio=:equal)
savefig(string("Lecture6/", "resta.png"))






