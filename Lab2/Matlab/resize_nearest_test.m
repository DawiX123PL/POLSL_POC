function A1 = resize_nearest_test(A, scale)
    
    % resize verticaly
    s = [size(A,1), size(A,2)];
    
    A_h = [];
    for i = 1:s(1)
        for a = 1:scale
            A_h = [A_h; A(i,:,:)];
        end
    end

    A_v = [];
    for i = 1:s(2)
        for a = 1:scale
            A_v = [A_v, A_h(:,i,:)];
        end
    end

    A1 = A_v;

end


