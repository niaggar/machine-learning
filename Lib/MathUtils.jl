module MathUtils

using Statistics

function reduceMatrix(matrix::Matrix{Float64}, newSize::Tuple{Int, Int})
    rows, cols = size(matrix)
    newRows, newCols = newSize

    blockRows = Int(floor(rows / newRows))
    blockCols = Int(floor(cols / newCols))
    newMatrix = zeros(newRows, newCols)

    for i in 1:newRows
        for j in 1:newCols
            # calculate the limits of the block
            rowStart = (i - 1) * blockRows + 1
            rowEnd = i * blockRows
            colStart = (j - 1) * blockCols + 1
            colEnd = j * blockCols

            # get the block
            block = matrix[rowStart:rowEnd, colStart:colEnd]

            # calculate the mean of the block
            newMatrix[i, j] = mean(block)
        end
    end

    return newMatrix
end

function vectorizeMatrix(matrix::Matrix{Float64})
    final = vec(matrix)
    return final
end

export reduceMatrix, vectorizeMatrix    
end