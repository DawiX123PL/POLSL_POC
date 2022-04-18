clear all
close all
clc

% test value from POC_LAB
TotalColors = 54712;


% load test image
I_rgb = imread("..\obrazy\cienkopisy_srgb.png");
I_rgbDouble = double(I_rgb)./256;
I_hsv = rgb2hsv(I_rgb);


%colors1 = count_rgb1(I);
%colors2 = count_rgb2(I);
%colors3 = count_rgb3(I);


colors2 = countBenchmark('   version 2', @count_rgb2, I_rgb, TotalColors);
colors3 = countBenchmark('   version 3', @count_rgb3, I_rgb, TotalColors);

colors2d = countBenchmark('   version 2 double', @count_rgb2, I_rgbDouble, TotalColors);
colors3d = countBenchmark('   version 3 double', @count_rgb3, I_rgbDouble, TotalColors);

colors2h = countBenchmark('   version 2 HSV', @count_rgb2, I_hsv, TotalColors);
colors3h = countBenchmark('   version 3 HSV', @count_rgb3, I_hsv, TotalColors);


colors4  = countBenchmark('   version 4',         @count_rgb4, I_rgb,       TotalColors);
colors4d = countBenchmark('   version 4 double ', @count_rgb4, I_rgbDouble, TotalColors);
colors4h = countBenchmark('   version 4 hsv',     @count_rgb4, I_hsv,       TotalColors);


function colors = countBenchmark(msg, func, I, TotalColors)

    [height, width, ~] = size(I);
    TotalPixels = height * width;

    disp(msg)
    tic
    colors = func(I);
    toc 

    countedPixels = sum(colors(:,4));
    disp ('Counted pixels : ' + string(countedPixels))
    if countedPixels ~= TotalPixels 
        warning( 'pixel count do not match : ' + string(countedPixels) + " should be " + string(TotalPixels) );
    end
    
    countedColors = size(colors,1);
    disp ('Counted Colors : ' + string(countedColors))
    if countedColors ~= TotalColors 
        warning( 'color count do not match : ' + string(countedColors) + " should be " + string(TotalColors) );
    end



end








