function I1 = HistogramStretch(I1, mode, CutAmount)
    
    a = 0;
    b = 1;
    A = 0;
    B = 1;
    
    if mode == "No Cut"
        [a, b] = NoCut(I1);
    elseif mode == "Auto"
        [a, b] = CutInsignificant([0.01 0.01], I1);
    elseif mode == "Cut Insignificant"
        [a, b] = CutInsignificant(CutAmount, I1);
    elseif mode == "Cut Manual"
        a = CutAmount(1);
        b = CutAmount(2);
    elseif mode == "Histeq"
        I1 = histeq(I1);
        return;
    elseif mode == "Adapthisteq"
        I1 = adapthisteq(I1);
        return;
    end

    I1 = (B-A) / (b-a) * (I1 - a) + A;
    I1 = min(I1, 1);
    I1 = max(I1, 0);

end





function [a, b] = NoCut(I1)
    a = min(I1, [], "all");
    b = max(I1, [], "all");
end


function [a, b] = CutInsignificant(CutAmount, I1)
    
    CuttNum = CutAmount * numel(I1);
    [counts,binLocations] = imhist(I1);
    
    sumEl = 0; 
    for i = 1:length(counts)
        if sumEl + counts(i) > CuttNum(1)
            break;
        end
        
        sumEl = sumEl + counts(i);
    end
    a = binLocations(i);
    
    sumEl = 0; 
    for i = length(counts):-1:1
        if sumEl + counts(i) > CuttNum(2)
            break;
        end
        
        sumEl = sumEl + counts(i);
    end
    b = binLocations(i);

end