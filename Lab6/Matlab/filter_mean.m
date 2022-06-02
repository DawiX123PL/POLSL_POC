function [I1, mask] = filter_Mean(I, maskSize)

    s = 1+maskSize*2;
    mask = ones(s) / s^2;
    I1 = filter_Linear(I, mask);

end
