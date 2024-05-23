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
            rowStart = (i - 1) * blockRows + 1
            rowEnd = i * blockRows
            colStart = (j - 1) * blockCols + 1
            colEnd = j * blockCols

            block = matrix[rowStart:rowEnd, colStart:colEnd]
            newMatrix[i, j] = mean(block)
        end
    end

    return newMatrix
end

function vectorizeMatrix(matrix::Matrix{Float64})
    final = vec(matrix)
    return final
end

function vectorizeMatrixInt(matrix::Matrix{Int})
    final = vec(matrix)
    return final
    
end

export reduceMatrix, vectorizeMatrix, vectorizeMatrixInt
end