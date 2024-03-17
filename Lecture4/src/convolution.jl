module Convolution
using Images

function convolution(image, kernel)
    height, width = size(image)
    kernel_height, kernel_width = size(kernel)
    chanels = channelview(image)

    kernelWidhMid = kernel_width ÷ 2
    kernelHeightMid = kernel_height ÷ 2

    result = zeros((3, height, width))
    for row in 1:height
        for col in 1:width
            for chanel in 1:3
                acumulator = 0
                
                for i in 1:kernel_height
                    for j in 1:kernel_width
                        x = col - kernelWidhMid + j
                        y = row - kernelHeightMid + i

                        if x > 0 && x <= width && y > 0 && y <= height
                            intensity = chanels[chanel, y, x]
                            acumulator += intensity * kernel[i, j]
                        end
                    end
                end

                result[chanel, row, col] = acumulator
            end
        end
    end

    return colorview(RGB, result)
end


edgedetection = [-1 -1 -1; -1 8 -1; -1 -1 -1]
boxBlur = 1/9 * [1 1 1; 1 1 1; 1 1 1]
gaussian3x3 = 1/16 * [1 2 1; 2 4 2; 1 2 1]
gaussian5x5 = 1/256 * [1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1]
sharpen = [0 -1 0; -1 5 -1; 0 -1 0]
unSharpMask = -1/256 * [1 4 6 4 1; 4 16 24 16 4; 6 24 -476 24 6; 4 16 24 16 4; 1 4 6 4 1]

export convolution, edgedetection, boxBlur, gaussian3x3, gaussian5x5, sharpen, unSharpMask
end