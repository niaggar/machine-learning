module ImgPlot

using ImgStr
using Fourier
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

function pltColorImageN(img::ImageStruct)
	red = img.imgRGB[1, :, :]
	green = img.imgRGB[2, :, :]
	blue = img.imgRGB[3, :, :]

    clims = (0, 1)
    p1 = heatmap(red, color=:greys, yflip=true, colorbar=false, title="Red", showaxis=false)
    p2 = heatmap(green, color=:greys, yflip=true, colorbar=false, title="Green", showaxis=false)
    p3 = heatmap(blue, color=:greys, yflip=true, colorbar=false, title="Blue", showaxis=false)
    b = scatter([0], [0], zcolor=[NaN], clims=clims, xlims=(1,1.1), label="", c=:grays, framestyle=:none)
    
    l = @layout [a b c d{0.1w}]
    plot(p1, p2, p3, b, layout=l, size=(2000, 500), legend=false)
end

function pltGrayImage(img::ImageGray, saveRoute::String)
    p1 = heatmap(img.imgGray, color=:greys, yflip=true, colorbar=false, title="Gray", showaxis=false)
    b = scatter([0], [0], zcolor=[NaN], clims=(0, 1), xlims=(1,1.1), label="", c=:grays, framestyle=:none)

    l = @layout [a b{0.1w}]
    fig = plot(p1, b, layout=l, size=(700, 500), legend=false)

    savefig(fig, saveRoute)
end

function pltGrayImageN(img::ImageGray)
    p1 = heatmap(img.imgGray, color=:greys, yflip=true, colorbar=false, title="Gray", showaxis=false)
    b = scatter([0], [0], zcolor=[NaN], clims=(0, 1), xlims=(1,1.1), label="", c=:grays, framestyle=:none)
    
    l = @layout [a b{0.1w}]
    plot(p1, b, layout=l, size=(700, 500), legend=false)
end


function pltFourier(fourier::ImageFourier, saveRoute::String)
    p1 = heatmap(fourier.phase, color=:grays, yflip=true, colorbar=false, title="Phase", showaxis=false)
    ampLog = log.(fourier.amplitude .+ 1)
    p2 = heatmap(ampLog, color=:grays, yflip=true, colorbar=false, title="Amplitude (ln)", showaxis=false)
    b = scatter([0], [0], zcolor=[NaN], clims=(0, 1), xlims=(1,1.1), label="", c=:grays, framestyle=:none)
    
    l = @layout [a b{0.1w} c]
    fig = plot(p1, b, p2, layout=l, size=(1000, 500), legend=false)

    savefig(fig, saveRoute)
end

function pltFourierN(fourier::ImageFourier)
    p1 = heatmap(fourier.phase, color=:grays, yflip=true, colorbar=false, title="Phase", showaxis=false)
    ampLog = log.(fourier.amplitude .+ 1)
    p2 = heatmap(ampLog, color=:grays, yflip=true, colorbar=false, title="Amplitude (ln)", showaxis=false)
    b = scatter([0], [0], zcolor=[NaN], clims=(0, 1), xlims=(1,1.1), label="", c=:grays, framestyle=:none)
    
    l = @layout [a b{0.1w} c]
    plot(p1, b, p2, layout=l, size=(1000, 500), legend=false) 
end

export pltColorImage, pltGrayImage, pltGrayImageN, pltColorImageN, pltFourier, pltFourierN
end
