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

export vectorize_image
end