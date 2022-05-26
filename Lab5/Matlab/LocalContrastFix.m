

function I2 = LocalContrastFix(I1, divider,CutVal)
    
    if exist('divider','var') ~= 1
        divider = [8 8];
    end
    if exist('CutVal','var') ~= 1
        CutVal = 0.001;
    end

    steps   = [16 16];
    
    subImWidth = size(I1) ./ divider;
    
    
    xOffsets = round( [0:steps(2)-1] / steps(2) * subImWidth(2) );
    yOffsets = round( [0:steps(1)-1] / steps(1) * subImWidth(1) );
    
    
    subIms = [];
    i = 1;
    
    for yOffset = yOffsets
        for xOffset = xOffsets
            subIms(:,:,i) = CreateSubImage(divider, I1, xOffset, yOffset, [1 1] * CutVal);
            i = i + 1;
        end
    end
    
    
    
    I2 = mean(subIms, 3);
end



function subIm1 = CreateSubImage(divider, I1, xOffset, yOffset, cutVal)
    
    posRangeX = [0:divider(1)+1] ./ divider(1) * size(I1,2);
    posRangeX = [posRangeX(1:end-1); posRangeX(2:end)];
    posRangeX = round(posRangeX);
    
    
    posRangeY = [0:divider(2)+1] ./ divider(2) * size(I1,1);
    posRangeY = [posRangeY(1:end-1); posRangeY(2:end)];
    posRangeY = round(posRangeY);
    
    
    subIm1 = zeros(size(I1));
    
    for yRange = posRangeY
        for xRange = posRangeX
            
            x = xRange - xOffset;
            x = max(x,1);
            x = min(x,size(I1,2));
            
            y = yRange - yOffset;
            y = max(y,1);
            y = min(y,size(I1,1));
            
            subIm1(y(1):y(2), x(1):x(2)) = ...
                HistogramStretch(I1(y(1):y(2), x(1):x(2)), "Cut Insignificant", cutVal);
            
        end
    end
end