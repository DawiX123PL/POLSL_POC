function A1 = demosaic_bilinear(A, color)

    color = "bggr";

    s = size(A);

    A = [ A(1:2 ,:); A; A(end-1:end ,:) ];
    A = [ A(: ,1:2), A, A(: ,end-1:end) ];

    A_r = zeros(s);
    A_g = zeros(s);
    A_b = zeros(s);


    % red 
    indexOffset = 2;
    for x = 1:2:s(1)
        for y = 1:2:s(2)

            %  a1 | X |a2 
            % -X--|-X-| X
            %  a3 | X |a4
            
            a1 = A( x-1 + indexOffset, y-1 + indexOffset );
            a2 = A( x+1 + indexOffset, y-1 + indexOffset );
            a3 = A( x-1 + indexOffset, y+1 + indexOffset );
            a4 = A( x+1 + indexOffset, y+1 + indexOffset );
            
            A_r(x  ,y  ) =  1/4 * (a1 + a2 + a3 + a4);
            A_r(x+1,y  ) =  1/2 * (a2 + a4);
            A_r(x  ,y+1) =  1/2 * (a3 + a4);
            A_r(x+1,y+1) =  1   * (a4);

        end
    end
    

    % blue
    indexOffset = 3;
    for x = 1:2:s(1)
        for y = 1:2:s(2)

            %  a1 | a2 
            % ----|----
            %  a3 | a4
            
            a1 = A( x-1 + indexOffset, y-1 + indexOffset );
            a2 = A( x+1 + indexOffset, y-1 + indexOffset );
            a3 = A( x-1 + indexOffset, y+1 + indexOffset );
            a4 = A( x+1 + indexOffset, y+1 + indexOffset );
            
            A_b(x  ,y  ) =  1   * (a1);
            A_b(x+1,y  ) =  1/2 * (a1 + a2);
            A_b(x  ,y+1) =  1/2 * (a1 + a3);
            A_b(x+1,y+1) =  1/4 * (a1 + a2 + a3 + a4);

        end
    end

    % green
    indexOffset = 2;
    indexOffset2 = 2;
    for x = 1:2:s(1)
        for y = 1:2:s(2)

            %     | a1 |
            %  a2 | XX | a3
            %     | a4 | YY | a5
            %     |    | a6
            
            a1 = A( x   + indexOffset, y-1 + indexOffset );
            a2 = A( x-1 + indexOffset, y   + indexOffset );
            a3 = A( x+1 + indexOffset, y   + indexOffset );
            a4 = A( x   + indexOffset, y+1 + indexOffset );

            a5 = A( x+2 + indexOffset, y+1 + indexOffset );
            a6 = A( x+1 + indexOffset, y+2 + indexOffset );
            
            A_g(x  ,y  ) =  1/4 * (a1 + a2 + a3 + a4);
            A_g(x+1,y  ) =  1   * (a3);
            A_g(x  ,y+1) =  1   * (a4);
            A_g(x+1,y+1) =  1/4 * (a3 + a4 + a5 + a6);

        end
    end


    A1 = zeros([s , 3]);
    A1(:,:,1) = A_r;
    A1(:,:,3) = A_b;
    A1(:,:,2) = A_g;

end











