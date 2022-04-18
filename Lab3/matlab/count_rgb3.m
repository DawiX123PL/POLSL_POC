

% wariant 3
function [colorList] = count_rgb3(I)

    % convert double to uint32
    if class(I) == "double"
        I = uint32(I * 255);
    end


    % just to prevent stupid bug with +1 
    if class(I) == "uint8"
        I = uint32(I);
    end

    s_x = size(I,1);
    s_y = size(I,2);
    s_z = size(I,3);

    shape =  [s_x * s_y, 1, s_z ];
    linImg = uint32(reshape( I, shape ));


    
    map = linImg(:,1).*(256*256) + linImg(:,2).*(256) + linImg(:,3); 
    sortedMap = sort(map);


    %colorMap = [{red+green+blue}, count]
    colorMap  = uint32([0 0]);
    i = 1;

    for c = sortedMap'
        if c == colorMap(i,1)
            colorMap(i,2) = colorMap(i,2) + 1;
        else
            i = i+1;
            colorMap(i,:) = [c, 1];
        end
    end
    

    if colorMap(1, 2) == 0
        colorMap = colorMap(2:end, :);
    end


    r = bitand( bitsra( colorMap(:,1), 16 ), uint32(255) );
    g = bitand( bitsra( colorMap(:,1), 8  ), uint32(255) );
    b = bitand(         colorMap(:,1)      , uint32(255) );
    count = colorMap(:,2);

    colorList = [r, g, b, count ];


end

