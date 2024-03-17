include("src/sizeReduction.jl")
include("src/vectorizeImage.jl")
include("src/pixelByPixelCorrection.jl")
include("src/convolution.jl")

using .SizeReduction
using .VectorizeImage
using .PixelByPixelCorrection
using .Convolution
using FileIO

newSize = 0.5
resultRoute = "Lecture4/results/"


img = FileIO.load("Lecture4/numOne.jpeg")
squareImg = square(img)
imgThumb = reduce_image_size(squareImg, newSize)

println("Original Image Size: ", size(img))
println("Square Image Size: ", size(squareImg))
println("Reduced Image Size: ", size(imgThumb))


imgGamma = pixel_by_pixel(imgThumb, transform_gamma, Dict("gamma" => 0.5))
imgNegative = pixel_by_pixel(imgThumb, transform_negative, Dict())
imgHistogram = pixel_by_pixel(imgThumb, transform_histogram, Dict())
imgHistogramEqualization = transform_equalization(imgThumb)

plot_histogram(imgThumb, "Original Image", resultRoute * "originalHistogram.png")
plot_histogram(imgGamma, "Gamma Correction", resultRoute * "gammaHistogram.png")
plot_histogram(imgNegative, "Negative Correction", resultRoute * "negativeHistogram.png")
plot_histogram(imgHistogram, "Histogram Equalization", resultRoute * "histogramHistogram.png")
plot_histogram(imgHistogramEqualization, "Histogram Equalization", resultRoute * "histogramEqualizationHistogram.png")
save(resultRoute * "originalImage.jpg", imgThumb)
save(resultRoute * "gammaCorrection.jpg", imgGamma)
save(resultRoute * "negativeCorrection.jpg", imgNegative)
save(resultRoute * "histogramCorrection.jpg", imgHistogram)
save(resultRoute * "histogramEqualizationCorrection.jpg", imgHistogramEqualization)

imgEdgeDetection = convolution(imgThumb, edgedetection)
imgBoxBlur = convolution(imgThumb, boxBlur)
imgGaussian3x3 = convolution(imgThumb, gaussian3x3)
imgGaussian5x5 = convolution(imgThumb, gaussian5x5)
imgSharpen = convolution(imgThumb, sharpen)
imgUnSharpMask = convolution(imgThumb, unSharpMask)

save("Lecture4/edgeDetection.jpg", imgEdgeDetection)
save("Lecture4/boxBlur.jpg", imgBoxBlur)
save("Lecture4/gaussian3x3.jpg", imgGaussian3x3)
save("Lecture4/gaussian5x5.jpg", imgGaussian5x5)
save("Lecture4/sharpen.jpg", imgSharpen)
save("Lecture4/unSharpMask.jpg", imgUnSharpMask)

