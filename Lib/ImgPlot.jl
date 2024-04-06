module ImgPlot

using ImgStr
using Images, Plots

function pltColorImage(img::ImageStruct, saveRoute::String)
	red = img.imgRGB[1, :, :]
	green = img.imgRGB[2, :, :]
	blue = img.imgRGB[3, :, :]

    clims = (0, 1)
    p1 = heatmap(red, color=:greys, yflip=true, colorbar=false, title="Red", showaxis=false)
    p2 = heatmap(green, color=:greys, yflip=true, colorbar=false, title="Green", showaxis=false)
    p3 = heatmap(blue, color=:greys, yflip=true, colorbar=false, title="Blue", showaxis=false)
    b = scatter([0], [0], zcolor=[NaN], clims=clims, xlims=(1,1.1), label="", c=:grays, framestyle=:none)
    
    l = @layout [a b c d{0.1w}]
    fig = plot(p1, p2, p3, b, layout=l, size=(2000, 500), legend=false)

    savefig(fig, saveRoute)
end

function pltGrayImage(img::ImageGray, saveRoute::String)
    p1 = heatmap(img.imgGray, color=:greys, yflip=true, colorbar=false, title="Gray", showaxis=false)
    b = scatter([0], [0], zcolor=[NaN], clims=(0, 1), xlims=(1,1.1), label="", c=:grays, framestyle=:none)
    
    l = @layout [a b{0.1w}]
    fig = plot(p1, b, layout=l, size=(700, 500), legend=false)

    savefig(fig, saveRoute)
end

export pltColorImage, pltGrayImage
end
