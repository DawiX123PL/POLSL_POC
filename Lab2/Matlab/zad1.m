clear all
close all
clc


inputFileNameCFA = "..\Obrazy\Bayer\CFA_sRGB\cienkopisy_srgb_CFA.png"
inputFileNameRGB = "..\Obrazy\Bayer\GT_sRGB\cienkopisy_srgb.png"

targetFolder = "..\zad1\img1"

mkdir(targetFolder)


I   = imread(inputFileNameCFA);
IGT = imread(inputFileNameRGB);
I1  = demosaic(I,'gbrg'); 
I2  = demosaic(I,'grbg'); 
I3  = demosaic(I,'bggr'); 
I4  = demosaic(I,'rggb'); 


cropImage = @(A) A(20:end-150,200:end-50,:);

I   = cropImage(I);
IGT = cropImage(IGT);

I1  = cropImage(I1);
I2  = cropImage(I2);
I3  = cropImage(I3);
I4  = cropImage(I4);



figure()
title("XD")
subplot(2,3,1);
    imshow(I);
subplot(2,3,4);
    imshow(IGT);

subplot(2,3,2);
    imshow(I1);
subplot(2,3,3);
    imshow(I2);
subplot(2,3,5);
    imshow(I3);
subplot(2,3,6);
    imshow(I4);


imwrite(I,    append(targetFolder, "\img1_raw_.png"))
imwrite(IGT,  append(targetFolder, "\img1_gt__.png"))

imwrite(I1,   append(targetFolder, "\img1_gbrg.png"))
imwrite(I2,   append(targetFolder, "\img1_grbg.png"))
imwrite(I3,   append(targetFolder, "\img1_bggr.png"))
imwrite(I4,   append(targetFolder, "\img1_rggb.png"))

