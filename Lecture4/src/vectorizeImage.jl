module VectorizeImage
using Images


function vectorize_image(img)
    chanels = channelview(img)
    pixelValues = float.(chanels)
    
    red = pixelValues[1, :, :]
    green = pixelValues[2, :, :]
    bluee = pixelValues[3, :, :]

    vectRed = vec(red)
    vectGreen = vec(green)
    vectBlue = vec(bluee)

    finalVect = hcat(vectRed, vectGreen, vectBlue)
    return finalVect
end

function vectorize_matrix(matrix)
    pixelValues = float.(matrix)
    vect = vec(pixelValues)

    return vect    
end

export vectorize_image
end