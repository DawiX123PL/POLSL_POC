

% wariant 2
function [colorMap] = count_rgb2(I)

    % just to prevent stupid bug with +1 
    I = uint32(I);

    x_max = size(I,1);
    y_max = size(I,2);

    %colors(reg, green, blue) = count
    colors = uint32(zeros(256,256,256));


    for x = 1:x_max
        for y = 1:y_max
            r = I(x, y, 1);
            g = I(x, y, 2);
            b = I(x, y, 3);
            
            colors(r+1, g+1, b+1) = colors(r+1, g+1, b+1) + 1;

        end
    end



    %colorMap = [reg, green, blue, count]
    colorMap  = uint32([]);

    for r = 1:256
        for g = 1:256
            for b = 1:256
       
                if colors(r,g,b) ~= 0
                    colorMap = [colorMap; r-1, g-1, b-1, colors(r,g,b) ];
                end

            end
        end
    end



end

