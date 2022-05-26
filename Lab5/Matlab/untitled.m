I1 = imread("../ObrazySzare/Ex2.png");
I1 = double(I1) / 255;

I2 = LocalContrastFix2(I1,7);

imshow(I2);