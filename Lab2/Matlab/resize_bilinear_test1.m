
function A_all = resize_bilinear_test1(A_XD, scale)

    %A_XD = [A_XD, A_XD(:,end)]
    %A_XD = [A_XD; A_XD(end,:)]

    A = [];


    for rgbColor = [1: size(A_XD,3)]
        A = A_XD(:,:,rgbColor);

        A = [A, A(:,end)]
        A = [A; A(end,:)]

        A = [ A(:,1), A]
        A = [ A(1,:); A]


    A1 = zeros(size(A) * scale);

    pos_x = 1;
    pos_y = 1;
    
    for pos_x = 1:size(A,1)-1
        for pos_y = 1:size(A,2)-1
    
            small_A = A(pos_x:pos_x+1, pos_y:pos_y+1);

            for x = 1:scale+1
                for y = 1:scale+1
        
                    t1 = [scale-x+1, x-1] / scale;
                    t2 = [scale-y+1; y-1] / scale;
        
                    A1((pos_x-1) * scale + x,(pos_y-1) * scale + y) = t1 * small_A * t2;
        
                end
            end
        end
    end

        A_all(:,:,rgbColor) = A1;
    end
    
    A_all = A_all(scale:end-scale-1, scale:end-scale-1, : );


end