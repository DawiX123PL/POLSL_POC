

% wariant 3
function [colorList] = count_rgb4(I)

    s_x = size(I,1);
    s_y = size(I,2);
    s_z = size(I,3);

    shape =  [s_x * s_y, 1, s_z ];
    linImg = reshape( I, shape );
    linImg = [linImg(:,:,1), linImg(:,:,2), linImg(:,:,3) ];
    

    sortedPixels = sortrows(linImg, [1 2 3]);

    colorList = [0 0 0 0];
    i = 1;

    for c = sortedPixels'

        if isequal(c', colorList(i,1:3))
            colorList(i, 4) = colorList(i, 4) + 1;
        else
            i = i + 1;
            colorList(i,:) = [ c', 1 ];
        end
    
    end

    if isequal( colorList(1,:), [0 0 0 0] )
        colorList = colorList(2:end,:);
    end


end

