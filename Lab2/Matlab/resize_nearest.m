function A1 = resize_nearest(A, scale)
    s = size(A,3);
    A1 = [];

    for i = [1:s]
        A_tmp = resize_nearest_color(A(:,:,i), scale);
        A1(:,:,i) = A_tmp;
    end

end


function A1 = resize_nearest_color(A, scale)

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

    
    x_IndexTab = round(x_IndexTab);
    y_IndexTab = round(y_IndexTab);


    for x_pos = 1:x_max
        for y_pos = 1:y_max

            A1(x_pos, y_pos) = A(x_IndexTab(x_pos), y_IndexTab(y_pos));

        end
    end



end