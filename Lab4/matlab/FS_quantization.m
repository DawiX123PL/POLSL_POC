


function I1 = FS_quantization(I1, divider)

    % quantization function select
    if class(divider) == "string" && divider == "bin"
        quantization = @(pix, divider) image_binarization(pix);
    else
        quantization = @(pix, divider) image_quantization(pix, divider);
    end

    tic
    className = class(I1);
    
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
            I1(y-1:y+1, x-1:x+1, :) = ...
                cast( ...
                    double(I1(y-1:y+1, x-1:x+1, :)) + mask .* err, ...
                    className ...
                );

            timeMeasure(2) = timeMeasure(2) + toc;
        end
    end

    timeMeasure
    I1 = I1(2:end-1, 2:end-1, :);

end
















