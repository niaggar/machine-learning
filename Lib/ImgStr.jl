module ImgStr

struct ImageStruct
    imgRGB::Array{Float64, 3}
    label::String
end

struct ImageGray
    imgGray::Matrix{Float64}
    vector::Array{Float64}
    label::String 
end

export ImageStruct, ImageGray    
end