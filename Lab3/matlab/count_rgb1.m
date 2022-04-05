

% wariant 1
function [colorMap] = count_rgb1(I)

    
    x_max = size(I,1);
    y_max = size(I,2);

    %colorMap = [reg, green, blue, count]
    colorMap  = [];


    found = false;

    for x = 1:x_max
        disp( string(x) + "," + string(x_max))
        for y = 1:y_max


            found = false;
            ci = [I(x,y,1), I(x,y,2), I(x,y,3)];


            for i = 1:size(colorMap,1)
                c = colorMap(i, 1:3);
                if isequal(c, ci)
                    found = true;
                    colorMap(i, 4) = colorMap(i, 4) + 1;
                end
            end

            if found == false
                colorMap = [colorMap; ci, 1 ];
            end


        end
    end


end


