clear all;
close all;
clc


I = imread("..\Obrazy\lena_512x512.bmp");
I = double(I) / 255;
I = rgb2gray(I);
I = I(1:500, :);


I1 = filter_Mean(I, 3);


tiledlayout(1,2);
nexttile;
imshow(I);
nexttile;
imshow(I1);


