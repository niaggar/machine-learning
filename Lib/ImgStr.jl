module ImgStr

struct ImageStruct
    imgRGB::Array{Float64, 3}
    label::String
    specie::String
end

struct ImageGray
    imgGray::Matrix{Float64}
    vector::Array{Float64}
    label::String
    specie::String
end

struct ImageFourier
    phase::Matrix{Float64}
    amplitude::Matrix{Float64}
    vector::Array{Float64}
    label::String
    specie::String
end

export ImageStruct, ImageGray, ImageFourier
end