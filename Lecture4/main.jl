# using Pkg
# Pkg.add("FileIO")
# Pkg.add("Images")
# Pkg.instantiate()

using FileIO
using Images

img = FileIO.load("numTest.jpg")
chanels = channelview(img)

newSize = (48, 48)
currentSize = size(img)

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

imgThumb = colorview(RGB, thumbnail)
save("thumb.jpg", imgThumb)

