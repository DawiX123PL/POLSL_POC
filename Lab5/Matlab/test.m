%clear all
close all
clc

source = "../Obrazy/baboon_512x512.bmp";
I1 = rgb2gray(imread(source));
I1 = double(I1) ./ 255;


I2 = HistogramStretch(I1,"NoCut");

figure; imshow(I1);
figure; imhist(I1);

figure; imshow(I2);
figure; imhist(I2);


K1 = k1(I1)
K2 = k2(I1)
K3 = k3(I1)
K4 = k4(I1)

