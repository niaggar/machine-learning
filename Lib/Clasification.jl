module Clasification
using KMeans

LEARNING_RATE = 0.1

mutable struct LineProps
    a::Float64
    b::Float64
    c::Float64
    equals::Float64
end

function getXYPoints(line::LineProps, x0, xf)
    x = range(x0, stop=xf, length=100)
    y = ((line.equals - line.c) / line.b) .- (line.a / line.b) .* x
    return x, y    
end

function validateLine(point::Point2D, line::LineProps, groups::Array{String, 1})
    val = line.a * point.x + line.b * point.y + line.c
    if val > line.equals
        return groups[1]
    else
        return groups[2]
    end
end

function Perceptron(points::Vector{Point2D}, groups::Vector{String}, maxIter::Int64)
    divisionLine = LineProps(1.0, 100, 1.0, 0.0)

    for i in 1:maxIter
        for point in points
            group = validateLine(point, divisionLine, groups)
        
            if group != point.centroid
                if group == groups[1]
                    divisionLine.a -= LEARNING_RATE * point.x
                    divisionLine.b -= LEARNING_RATE * point.y
                    divisionLine.c -= LEARNING_RATE
                else
                    divisionLine.a += LEARNING_RATE * point.x
                    divisionLine.b += LEARNING_RATE * point.y
                    divisionLine.c += LEARNING_RATE
                end
            end
        end
    end

    return divisionLine
end

function SVC()
    
end

export LineProps, Perceptron, getXYPoints, validateLine
end