function I1 = image_binarization(I1)
    if class(I1) == "double"
        I1 = I1 > 0.5;
        return;
    elseif class(I1) == "uint8"
        I1 = uint8((I1 > 127) * 255);
        return;
    end
end

