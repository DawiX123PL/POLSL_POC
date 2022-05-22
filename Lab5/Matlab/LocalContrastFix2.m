

function I2 = LocalContrastFix2(I1, divideSteps)
    %divideSteps = 1;
    subIms = [];

    I2 = contrastFixRecurse(I1, divideSteps);
    %I2(:,:,1) = HistogramStretch(I1, "Cut Insignificant", [0.002 0.002]);

    dz = 1*2.^[0:size(I2,3)-1]  .^(-3);

    dz = reshape(dz, [1 1 size(I2,3)])
    
    I2 = sum(I2 .* dz,3) ./ sum(dz);

end


function subIms = contrastFixRecurse(I1, divideSteps)
    
    if(divideSteps) == 0
        subIms = [];
        return;
    end

    subIms = HistogramStretch(I1, "Auto");

    div = round(size(I1) ./ 2);
    subIms1 = zeros([size(I1),divideSteps-1]);



    if(divideSteps) > 1
        subIms1(1:div(1),   1:div(2)  ,:) = contrastFixRecurse(I1(1:div(1),   1:div(2)  ), divideSteps-1);
        subIms1(div(1):end, 1:div(2)  ,:) = contrastFixRecurse(I1(div(1):end, 1:div(2)  ), divideSteps-1);
        subIms1(1:div(1),   div(2):end,:) = contrastFixRecurse(I1(1:div(1),   div(2):end), divideSteps-1);
        subIms1(div(1):end, div(2):end,:) = contrastFixRecurse(I1(div(1):end, div(2):end), divideSteps-1);
        
        subIms = cat(3,subIms,subIms1);
    end

end
