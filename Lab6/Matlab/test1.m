clear all;
close all;
clc


I = imread("..\Obrazy\lena_512x512.bmp");
I = double(I) / 255;
I = rgb2gray(I);
I = I(1:500, :);



I1 = awgn(I, 20);


tic
I2 = filter_mean(I1, 1);
toc
tic
I3 = filter_Linear(I1, ones(3) / 9);
toc
tic
I4 = conv2(I1, ones(3) / 9, 'same');
toc

figure; imshow(I1);
figure; imshow(I2);
figure; imshow(I3);
figure; imshow(I4);

d23 = max(abs(I2(10:end-10, 10:end-10) - I3(10:end-10, 10:end-10)), [], "all");
d24 = max(abs(I2(10:end-10, 10:end-10) - I4(10:end-10, 10:end-10)), [], "all");

