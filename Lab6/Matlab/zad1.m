clear all;
close all;
clc

source = "..\Obrazy\lena_512x512.bmp";
destination = "..\zad1";

% load images and convert to gray scale
I = imread(source);
I = double(I) / 255;
I = rgb2gray(I);
I = I(1:500, :);

% process images
I1 = I;

Md = ones(3) / 9;
I2 = filter_Linear(I1, Md);

Mg = [0 -1  0; -1  4 -1; 0 -1  0];
I3 = filter_Linear(I1, Mg);

% display result
figure;
tiledlayout(1,3);

nexttile;
imshow(I1);

nexttile;
imshow(I2);

nexttile;
imshow(I3);

% saving images on disk
mkdir(destination);

imwrite(I1, destination + "/O1___.png");
imwrite(I2, destination + "/O1_Md.png");
imwrite(I3, destination + "/O1_Mg.png");
















