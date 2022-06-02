function [I1, mask] = filter_Gausian(I,windowSize, ro)

    w = [-windowSize:windowSize] .* ones(1 + windowSize * 2);
    x = w;
    y = w';


    r = -(x.^2 + y.^2) / (2 * ro^2);
    mask = 1/(2*pi*ro^2) * exp(r);


    I1 = filter_Linear(I,mask);


end
