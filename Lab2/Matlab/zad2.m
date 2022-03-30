clear all
close all
clc

sourceImage = "..\Obrazy\Bayer\GT_sRGB\cienkopisy_srgb.png"
%sourceImage = "C:\Users\dawid\Desktop\testowe.png"
I = imread(sourceImage);


scale = 3.3;

I = double(I)./255;

%I = [1 0; .5 .2; 1 1]

tic
%I1 = imresize(I,scale,"bilinear");
I1 = imresize(I,scale,"nearest");
toc

tic 
%I2 = resize_bilinear(I,scale);
I2 = resize_nearest(I,scale);
toc

figure()
%imshow( imresize(I,100, "nearest"))
imshow(I)

figure()
%imshow( imresize(I1,50, "nearest"))
imshow(I1)

figure()
%imshow( imresize(I2,50, "nearest"))
imshow(I2)


max(I1 - I2,[], 'all')






