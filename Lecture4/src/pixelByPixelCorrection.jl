module PixelByPixelCorrection
using Images
using Plots


function pixel_by_pixel(img, operation, operationProps::Dict)
    height, width = size(img)
    chanels = channelview(img)
    maxIntesities, minIntesities = min_max_matrix(chanels)

    operationProps["height"] = height
    operationProps["width"] = width

    correction_img = zeros((3, height, width))
    for row in 1:height
        for col in 1:width
            for chanel in 1:3
                operationProps["iMax"] = maxIntesities[chanel]
                operationProps["iMin"] = minIntesities[chanel]
                
                intensity = chanels[chanel, row, col]
                correction_img[chanel, row, col] = operation(intensity, operationProps)
            end
        end
    end

    return colorview(RGB, correction_img)
end

function min_max_matrix(chanels)
    maxIntensities = [maximum(chanels[i, :, :]) for i in 1:3]
    minIntensities = [minimum(chanels[i, :, :]) for i in 1:3]

    return maxIntensities, minIntensities
end

function transform_negative(i, props::Dict)
    j = 1 - i
    return j
end

function transform_gamma(i, props::Dict)
    gamma = props["gamma"]
    
    j = i^gamma
    return j
end

function transform_histogram(i, props::Dict)
    iMin = props["iMin"]
    iMax = props["iMax"]
    
    j = (i - iMin) / (iMax - iMin)
    return j
end

function transform_equalization(img)
    height, width = size(img)
    chanels = channelview(img)

    correction_img = zeros((3, height, width))
    for chanel in 1:3
        hist = zeros(256)
        for row in 1:height
            for col in 1:width
                intensity = chanels[chanel, row, col]
                intensity = round(Int, intensity * 255)
                hist[intensity + 1] += 1
            end
        end

        cdf = cumsum(hist)
        cdfmin = minimum(cdf)
        for row in 1:height
            for col in 1:width
                intensity = chanels[chanel, row, col]
                intensity = round(Int, intensity * 255)
                correction_img[chanel, row, col] = round((cdf[intensity + 1] - cdfmin) / (height * width - cdfmin) * 255) / 255
            end
        end
    end

    return colorview(RGB, correction_img)
end

function plot_histogram(image, title, filename)
    height, width = size(image)
    chanels = channelview(image)

    histRed = zeros(256)
    histGreen = zeros(256)
    histBlue = zeros(256)
    for row in 1:height
        for col in 1:width
            histRed[round(Int, chanels[1, row, col] * 255) + 1] += 1
            histGreen[round(Int, chanels[2, row, col] * 255) + 1] += 1
            histBlue[round(Int, chanels[3, row, col] * 255) + 1] += 1
        end
    end

    plot(0:255, histRed, label="Red", color="red", xlabel="Intensity", ylabel="Frequency", title=title)
    plot!(0:255, histGreen, label="Green", color="green")
    plot!(0:255, histBlue, label="Blue", color="blue")
    savefig(filename)
end

export pixel_by_pixel, transform_negative, transform_gamma, transform_histogram, transform_equalization, plot_histogram
end