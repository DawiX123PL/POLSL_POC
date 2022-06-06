clear all
close all
clc

I = rand([512,500]);

Kern = ones(3) / 9;

I1 = filter_Linear(I,Kern);
I2 = conv2(I,Kern,"same");

border = 5;

I1 = I1(border:end-border, border:end-border);
I2 = I2(border:end-border, border:end-border);

dif = abs(I1 - I2);





