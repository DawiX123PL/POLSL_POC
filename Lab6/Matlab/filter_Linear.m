function I1 = filter_Linear(I, Kernel)

    s = size(I);
    I1 = zeros(s);

    % add border to prevent indexing errors
    borderSize = (size(Kernel) - 1) ./ 2;
    I = AddBorder(I, [floor(borderSize(1)), ceil(borderSize(2)), ceil(borderSize(1)), floor(borderSize(2))] );
    clear borderSize;


    Offset1 = size(Kernel, 1) - 1;
    Offset2 = size(Kernel, 2) - 1;
    Ones1 = ones([1, 1 + Offset1]);
    Ones2 = ones([1 + Offset2, 1]);

    

   % I1 = I1(floor(borderSize(1)):end-ceil(borderSize(1)), floor(borderSize(2)):end-ceil(borderSize(2)) );

    for y = 1:s(1)
        for x = 1:s(2)
            
            %I1(y, x) = sum(I(y:y + Offset, x:x + Offset), "all");

            % for some reason this is 3 times faster than "sum()" function
            I1(y, x) = Ones1 * (I(y:y + Offset1, x:x + Offset2) .* Kernel) * Ones2;
        end
    end

end


%%


% borderSize 
%       1
%    ------
%  4 |    | 2
%    ------
%       3
function I = AddBorder(I, borderSize)

    Lborder = RepeatVector(I(:,  1), borderSize(4));
    Rborder = RepeatVector(I(:,end), borderSize(2));
    
    I = [Lborder, I, Rborder];
    
    Tborder = RepeatVector(I(1,  :)', borderSize(1));
    Bborder = RepeatVector(I(end,:)', borderSize(3));
    
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