function [I1, mask] = filter_Laplacian(I)


    mask = [-1 -1 -1; -1 8 -1; -1 -1 -1];
    %mask = [0 -1 0; -1 4 -1; 0 -1 0];

    I1 = filter_Linear(I,mask);


end
