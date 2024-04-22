module Fourier

using FFTW
using ImgFormat
using ImgUtils
using ImgPlot
using ImgStr
using MathUtils

function fftwImage(img::ImageGray)
    fftImg = fft(img.imgGray)
    fftImgShift = fftshift(fftImg)

    amplitude = abs.(fftImgShift)
    phase = angle.(fftImgShift)
    vector = vectorizeMatrix(amplitude)

    return ImageFourier(phase, amplitude, vector, img.label, img.specie)
end

function ifftwImage(img::ImageFourier)
    tempFft = img.amplitude .* exp.(im * img.phase)

    tempImg = ifft(ifftshift(tempFft))
    tempImg = abs.(tempImg)
    vector = vectorizeMatrix(tempImg)

    return ImageGray(tempImg, vector, img.label, img.specie)
end

function gaussianFilter(img::ImageFourier, gaussMatrix::Matrix{Float64})
    amplitude = img.amplitude .* gaussMatrix
    vector = vectorizeMatrix(amplitude)

    return ImageFourier(img.phase, amplitude, vector, img.label, img.specie)
end

function getGaussianMatrix(size::Tuple{Int, Int}, sigma::Float64)
    x = 1:size[1]
    y = 1:size[2]

    x = x .- size[1] / 2
    y = y .- size[2] / 2

    x = x .^ 2
    y = y .^ 2

    x = x .+ y'

    return exp.(-x / (2 * sigma ^ 2))
end



export fftwImage, ifftwImage, gaussianFilter, getGaussianMatrix
end