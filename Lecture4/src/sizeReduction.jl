module SizeReduction
using Images

function reduce_image_size(img, percentage)
    chanels = channelview(img)
    currentSize = size(img)
    newSize = (round(Int, currentSize[1] * percentage), round(Int, currentSize[2] * percentage))
    numBlockVer = round(Int, currentSize[1] / newSize[1])
    numBlockHor = round(Int, currentSize[2] / newSize[2])
    N = numBlockHor * numBlockVer
    thumbnail = zeros((3, newSize[1], newSize[2]))
    
    for row in 1:newSize[1] 
        for col in 1:newSize[2]
            for chanel in 1:3
                acumulator = 0

                for subRow in 1:numBlockHor
                    for subCol in 1:numBlockVer
                        rowBigMatrix = subRow + (row - 1) * numBlockHor
                        colBigMatrix = subCol + (col - 1) * numBlockVer
                        acumulator += chanels[chanel, rowBigMatrix, colBigMatrix]
                    end
                end

                thumbnail[chanel, row, col] = acumulator / N
            end
        end
    end

    return colorview(RGB, thumbnail)        
end

function square(img)
    height, width = size(img)

    if height > width
        diff = height - width
        img = img[1:height - diff, :]
    elseif width > height
        diff = width - height
        img = img[:, 1:width - diff]
    end

    return img
end

export reduce_image_size, square
end
