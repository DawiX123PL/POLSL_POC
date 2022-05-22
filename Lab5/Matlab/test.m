clear all
close all
clc

%source = "../Obrazy/baboon_512x512.bmp";

source = "../ObrazySzare/Ex1.png";
I1 = imread(source);
I1 = double(I1) ./ 255;


I2 = HistogramStretch(I1,"No Cut");
I3 = HistogramStretch(I1,"Auto");
I4 = histeq(I1);


%figure; imshow(I1);
figure; imhist(I1);

%figure; imshow(I2);
figure; imhist(I2);

%figure; imshow(I3);
figure; imhist(I3);

%figure; imshow(I4);
figure; imhist(I4);


K1 = k1(I1)
K2 = k2(I1)
K3 = k3(I1)
K4 = k4(I1)

min(I1,[],"all")
max(I1,[],"all")