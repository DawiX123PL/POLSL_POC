function I1 = filter_mean(I, maskSize)

    s = size(I);
    I1 = zeros(s);

    % add border to prevent indexing errors
    I = AddBorder(I, maskSize);

    Offset = maskSize*2;

    Ones1 = ones([1, 1 + Offset]);
    Ones2 = ones([1 + Offset, 1]) / (1+Offset)^2;

    for y = 1:s(1)
        for x = 1:s(2)
            
            %I1(y, x) = mean(I(y:y + Offset, x:x + Offset), "all");

            % for some reason this is 3 times faster than "mean()" function
            I1(y, x) = Ones1 * I(y:y + Offset, x:x + Offset) * Ones2;
        end
    end


end


%%

function I = AddBorder(I, borderSize)
    Lborder = RepeatVector(I(:,  1), borderSize);
    Rborder = RepeatVector(I(:,end), borderSize);
    
    I = [Lborder, I, Rborder];
    
    Tborder = RepeatVector(I(1,  :)', borderSize);
    Bborder = RepeatVector(I(end,:)', borderSize);
    
    I = [Tborder'; I; Bborder'];

end

%%

function mat = RepeatVector(vector, Count)
    if size(vector, 2) ~= 1
        error("something went wrong");
    end

    mat = zeros([length(vector), 0]);
    for i = 1:Count
        mat(:,i) = vector;
    end
end