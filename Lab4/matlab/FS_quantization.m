


function I1 = FS_quantization(I1, divider)

    

    % quantization function select
    if class(divider) == "string" && divider == "bin"
        quantization = @(pix, divider) image_binarization(pix);
    else
        quantization = @(pix, divider) image_quantization(pix, divider);
    end

    tic
    %className = class(I1);
    [I1, className] = change_class(I1);
    
    % add border to image to prevent error with indexing
    I1 = [I1(:,1,:), I1, I1(:,end,:)];
    I1 = [I1(1,:,:); I1; I1(end,:,:)];


    % mask
    mask = [0 0 0; 0 0 7; 3 5 1] / 16;

    timeMeasure = [0, 0];



    for y = 2:size(I1,1)-1
        for x = 2:size(I1,2)-1

            tic;

            old = I1(y,x,:);
            new = quantization(old, divider);
            err = double(old) - double(new);

            timeMeasure(1) = timeMeasure(1) + toc;
            tic;
            I1(y,x,:) = new;
            % I1(y-1:y+1, x-1:x+1, :) = ...
            %     cast( ...
            %         double(I1(y-1:y+1, x-1:x+1, :)) + mask .* err, ...
            %         className ...
            %     );

            tmp = I1(y-1:y+1, x-1:x+1, :) + mask .* err;
            tmp = min(tmp, 1);
            tmp = max(tmp, 0);
            I1(y-1:y+1, x-1:x+1, :) = tmp;

            timeMeasure(2) = timeMeasure(2) + toc;
        end
    end

    timeMeasure
    I1 = I1(2:end-1, 2:end-1, :);

    I1 = revert_change(I1, className);

end





function [I, classname] = change_class(I)

    if isa(I,"double")
        classname = "double";
        return
    end

    if isa(I,"uint8")
        classname = "uint8";
        I = double(I)./ (2^8 - 1);
        return
    end

    if isa(I,"uint16")
        classname = "uint16";
        I = double(I)./ (2^16 - 1);
        return
    end

    if isa(I,"uint32")
        classname = "uint32";
        I = double(I)./ (2^32 - 1);
        return
    end
end


function I = revert_change(I, c)

    if c == "double"
        % do nothing
        return
    end
    if c == "uint8"
        I = uint8(I .* (2^8 - 1));
    end
    if c == "uint16"
        I = uint16(I .* (2^16 - 1));
    end
    if c == "uint32"
        I = uint32(I .* (2^32 - 1));
    end

end












