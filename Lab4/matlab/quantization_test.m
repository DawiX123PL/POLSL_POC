clear all
close all
clc


source = "../images/lena_512x512.bmp"
target = "../img/q2/i1"


I1 = imread("../images/lena_512x512.bmp");


I1_OTSU = image_quantization(I1, [2 2 2]);
I1_FS   = FS_quantization   (I1, [2 2 2]);


figure; imshow(I1     );
figure; imshow(I1_OTSU);
figure; imshow(I1_FS  );



mkdir(target);
imwrite(I1,      target + "/orig.png")
imwrite(I1_OTSU, target + "/OTSU.png")
imwrite(I1_FS,   target + "/FS__.png")





