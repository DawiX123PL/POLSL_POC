function val = k2(I1)
    I = changeClass(I1);

    Lsr = mean(I,"all");

    val = (max(I,[],"all") - min(I,[],"all")) / Lsr;


end


function I1 = changeClass(I1)

    if isa(I1,"uint8")
        I1 = double(I1) / 255;
    elseif isa(I1,"uint16")
        I1 = double(I1) / (2^16-1);
    end


    if size(I1,3) == 3
        I1 = rgb2gray(I1);
    end
end