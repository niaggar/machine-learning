using LinearAlgebra
using Plots
using Images
using FileIO


img = load("Lecture5/rick.jpg")
chanels = channelview(img)
println("Tamaño de imagen original:", size(img))


iRed = chanels[1, :, :]
iGreen = chanels[2, :, :]
iBlue = chanels[3, :, :]


descompRed = svd(iRed)
descompGreen = svd(iGreen)
descompBlue = svd(iBlue)

println("Incert the percentage of final quality (1-100):")
percentage = parse(Float64, readline())
nValues = round(Int, size(descompRed.S)[1] * percentage / 100)
if nValues == 0
    nValues = 1
end

vectorOfSingularValueNred = zeros(size(descompRed.S)[1])
vectorOfSingularValueNgreen = zeros(size(descompGreen.S)[1])
vectorOfSingularValueNBlue = zeros(size(descompBlue.S)[1])

for i in 1:nValues
    vectorOfSingularValueNred[i] = descompRed.S[i]
    vectorOfSingularValueNgreen[i] = descompGreen.S[i]
    vectorOfSingularValueNBlue[i] = descompBlue.S[i]
end

finalImageRed = descompRed.U * Diagonal(vectorOfSingularValueNred) * descompRed.Vt
finalImageGreen = descompGreen.U * Diagonal(vectorOfSingularValueNgreen) * descompGreen.Vt
finalImageBlue = descompBlue.U * Diagonal(vectorOfSingularValueNBlue) * descompBlue.Vt

finalImg = colorview(RGB, finalImageRed, finalImageGreen, finalImageBlue)
save("Lecture5/result.jpg", finalImg)






