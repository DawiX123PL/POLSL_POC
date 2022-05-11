clear all
close all
clc

source = "../Obrazy/kodim23_512x512.png"
I1 = imread(source);

imshow(rgb2gray(I1))

K1 = k1(I1)
K2 = k2(I1)
K3 = k3(I1)
K4 = k4(I1)

