
%                       image, [2 3 4]
function I1 = image_quantization(I, divider)

    [I, classname] = change_class(I);



    I_rh = floor(I(:,:,1) * divider(1)) + 0.5;
    I_gs = floor(I(:,:,2) * divider(2)) + 0.5;
    I_bv = floor(I(:,:,3) * divider(3)) + 0.5;
    if 4 == size(divider,2)
        I_w = floor(I(:,:,3) * divider(4)) + 0.5;
    end


    overflow_rh = I_rh > divider(1);
    overflow_gs = I_gs > divider(2);
    overflow_bv = I_bv > divider(3);
    if 4 == size(divider,2)
        overflow_w = I_w > divider(4);
    end


    I_rh = (~overflow_rh) .* I_rh  + (overflow_rh) * (divider(1)-0.5) ;
    I_gs = (~overflow_gs) .* I_gs  + (overflow_gs) * (divider(2)-0.5) ;
    I_bv = (~overflow_bv) .* I_bv  + (overflow_bv) * (divider(3)-0.5) ;
    if 4 == size(divider,2)
        I_w = (~overflow_w) .* I_w  + (overflow_w) * (divider(4)-0.5) ;
    end



    I1 = [];
    I1(:,:,1) = I_rh ./ divider(1);
    I1(:,:,2) = I_gs ./ divider(2);
    I1(:,:,3) = I_bv ./ divider(3);

    if 4 == size(divider,2)
        iswhite = I(:,:,2) == 0; % saturation == 0
        I1(:,:,3) = (~iswhite .* I_bv ./ divider(3)) + ...
                    ( iswhite .* I_w  ./ divider(4));
    end


    %I1 = revert_change(I1, classname);

end




function [I, classname] = change_class(I)

    if isa(I,"double")
        classname = "double";
        return
    end

    if isa(I,"uint8")
        classname = "uint8";
        I = double(I)./ (2^8 - 1);
        return
    end

    if isa(I,"uint16")
        classname = "uint16";
        I = double(I)./ (2^16 - 1);
        return
    end

    if isa(I,"uint32")
        classname = "uint32";
        I = double(I)./ (2^32 - 1);
        return
    end
end


function I = revert_change(I, c)

    if c == "double"
        % do nothing
        return
    end
    if c == "uint8"
        I = uint8(I .* (2^8 - 1));
    end
    if c == "uint16"
        I = uint16(I .* (2^16 - 1));
    end
    if c == "uint32"
        I = uint32(I .* (2^32 - 1));
    end

end