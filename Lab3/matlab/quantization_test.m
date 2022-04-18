clear all
close all
clc


% load test image
I_rgb = imread("..\obrazy\cienkopisy_srgb.png");

I_rgbDouble = double(I_rgb)./256;
I_hsv = rgb2hsv(I_rgb);


% quantization

I1 = image_quantization(I_rgb, [3 2 2]);
I2 = image_quantization(I_hsv, [3 0 3]);

c = count_rgb4(I_rgb);
c1 = count_rgb4(I1);
c2 = count_rgb4(I2);

subplot(1,3,1);
imshow(I_rgb)
subplot(1,3,2); 
imshow(I1);
subplot(1,3,3); 
imshow(hsv2rgb(I2));






