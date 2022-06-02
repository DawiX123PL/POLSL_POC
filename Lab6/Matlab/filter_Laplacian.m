function [I1, mask] = filter_Laplacian(I,windowSize, ro)

    w = [-windowSize:windowSize] .* ones(1 + windowSize * 2);
    x = w;
    y = w';



    tmp = (x.^2 + y.^2) / (2 * ro^2);
    mask = (-1/(pi*ro^4)) .* (1-tmp) .* exp(-tmp);

    I1 = filter_Linear(I,mask);


end
