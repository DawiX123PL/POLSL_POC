function A1 = demosaic_nearest(A, color)

    color = convertStringsToChars(color)
    colorGrid = [ color(1), color(2); color(3), color(4) ]

    colorGrid_r = colorGrid == 'r' | colorGrid == 'R';
    colorGrid_g = colorGrid == 'g' | colorGrid == 'G';
    colorGrid_b = colorGrid == 'b' | colorGrid == 'B';

    A1 = []
    A1(:,:,1) = demosaic_nearest_color(A, colorGrid_r);
    A1(:,:,2) = demosaic_nearest_color(A, colorGrid_g);
    A1(:,:,3) = demosaic_nearest_color(A, colorGrid_b);


end


function A1 = demosaic_nearest_color(A, colorGrid)

    A1 = zeros(size(A));

    for pos_x = 1:2:size(A,1)
        for pos_y = 1:2:size(A,2)

            if sum(colorGrid, 'all') == 1 
                val = colorGrid .* A(pos_x:pos_x+1, pos_y:pos_y+1);
                A1(pos_x:pos_x+1, pos_y:pos_y+1) = [1 1; 1 1] * max(val,[], 'all');
            end
            if sum(colorGrid, 'all') == 2
                val = colorGrid .* A(pos_x:pos_x+1, pos_y:pos_y+1);
                A1(pos_x:pos_x+1, pos_y:pos_y+1) = val + flip(val,2);
            end
        end
    end

end











