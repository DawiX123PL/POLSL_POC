
function A1 = resize_bilinear(A, scale)

    s = size(A,3);
    A1 = [];

    for i = [1:s]
        A_tmp = resize_bilinear_color(A(:,:,i), scale);
        A1(:,:,i) = A_tmp;
    end

end


function A1 = resize_bilinear_color(A, scale)

    s = size(A);

    x_max = ceil( size(A,1) * scale );
    y_max = ceil( size(A,2) * scale );
    A1 = zeros(x_max, y_max);

    % this is added to prevent index overflow/underflow while reading value
    %A = [A(:,1), A, A(:,end)];
    %A = [A(1,:); A; A(end,:)];


    pixelOffset = (scale-1)/2;


    x_IndexTab = ([0:x_max-1]-pixelOffset)/scale;
    x_IndexTab = x_IndexTab + 1;

    x_IndexTab = min(s(1),x_IndexTab);
    x_IndexTab = max(1   ,x_IndexTab);

    y_IndexTab = ([0:y_max-1]-pixelOffset)/scale;
    y_IndexTab = y_IndexTab + 1;
    y_IndexTab = min(s(2),y_IndexTab);
    y_IndexTab = max(1   ,y_IndexTab);

    

    for pos_y = [1:y_max]
        for pos_x = [1:x_max]

            % szukanie najbliższych wartości 
            %   | a1 | a2 |
            %   |----|----|
            %   | a3 | a4 |
            left  = floor( x_IndexTab(pos_x) );
            right = ceil ( x_IndexTab(pos_x) );
            top   = floor( y_IndexTab(pos_y) );
            bot   = ceil ( y_IndexTab(pos_y) );

            x = x_IndexTab(pos_x) - left;
            y = y_IndexTab(pos_y) - top;

            a1 = A( left,  top );
            a2 = A( left,  bot );
            a3 = A( right, top );
            a4 = A( right, bot );

            t1 = [ 1-x, x ];
            t2 = [ 1-y; y ];
            %a = [a1, a2; a3, a4];
            a = [a1, a2; a3, a4];

            val = t1 * a * t2;
            %val = t2' * a * t1';

            A1(pos_x, pos_y) = val;

        end
    end


    %{
    for pos_y = [0:y_max-1]
        for pos_x = [0:x_max-1]
            
            % szukanie najbliższych wartości 
            %   | a1 | a2 |
            %   |----|----|
            %   | a3 | a4 |
            
            left  = floor( pos_x / scale );
            right = left + 1;
            top   = floor( pos_y / scale );
            bot   = top + 1;

            x = (pos_x) / scale - left;
            y = (pos_y) / scale - top;
            


         


            a1 = A( top + 1, left  + 1 );
            a2 = A( top + 1, right + 1 );
            a3 = A( bot + 1, left  + 1 );
            a4 = A( bot + 1, right + 1 );

            t1 = [ 1-x, x ];
            t2 = [ 1-y; y ];
            a = [a1, a2; a3, a4];

            %val = t1 * a' * t2;
            val = t2' * a * t1';

            A1(pos_y + 1, pos_x + 1) = val;

        end
    end
    %}

end


