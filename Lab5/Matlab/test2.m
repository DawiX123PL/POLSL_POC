clear all
close all
clc

source = "../ObrazySzare/Ex1.png";
I1 = imread(source);
I1 = double(I1) ./ 255;



divideSteps = 7;

I2 = HistogramStretch(I1, "Auto");
I3 = LocalContrastFix2(I1, divideSteps);
I4 = adapthisteq(I1);

figure; imshow(I1)
figure; imshow(I2)
figure; imshow(I3)

figure; imhist(I1)
figure; imhist(I2)
figure; imhist(I3)






