function [I1, mask] = filter_Unsharp(I,windowSize, k, ro)

    
    [I_filtered, mask] = filter_Gausian(I, windowSize, ro);
    
    I_edges = I - I_filtered;

    I1 = I + k * I_edges;

end
