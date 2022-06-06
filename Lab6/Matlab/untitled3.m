source = "../Obrazy/lena_512x512.bmp"

I = imread(source);
I = double(I) / 255;
I = rgb2gray(I);
I = I(1:500, :);


LOGSweep = [0.6:0.01:0.8];
gaussSweep = [0.1:0.02:1];


I1 = I; % "clean" image
I2 = awgn(I1, 20);


RESULT = zeros([length(LOGSweep), length(gaussSweep)])


parfor i = 1:length(gaussSweep);
    gaussVal = gaussSweep(i)


    resTmp = [];
    for LogVal = LOGSweep

        disp("gauss: " + string(gaussVal) + " Log: " + string(LogVal))
    
        [I3, maskMd] = filter_Gausian(I2, 5, gaussVal); % low-pass filter
        I4 = I2 - I3;
        [I5, maskMg] = filter_LOG(I3,5,LogVal); % hi-pass filter
        I6 = I2 + I5;
    
        resTmp = [resTmp, psnr(I6,I1)];
        
    end

    RESULT(:,i) = resTmp;
end

RESULT = RESULT';

close all
[X,Y] = meshgrid(LOGSweep,gaussSweep);
Z = sin(X) + cos(Y);
surf(X,Y,RESULT)

xlabel xLOGSweep
ylabel ygaussSweep




