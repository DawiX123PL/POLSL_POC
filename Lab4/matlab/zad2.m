clear all
close all
clc


source = "../images/lena_512x512.bmp"
target = "../img/q16/i1"
P(1,:) = testFS(source, target, [0 0 0 0])

source = "../images/baboon_512x512.bmp"
target = "../img/q16/i2"
P(2,:) = testFS(source, target, [0 0 0 0])

source = "../images/frymire_512x512.png"
target = "../img/q16/i3"
P(3,:) = testFS(source, target, [0 0 0 0])

source = "../images/kodim23_512x512.png"
target = "../img/q16/i4"
P(4,:) = testFS(source, target, [0 0 0 0])

source = "../images/peppers3_512x512.bmp"
target = "../img/q16/i5"
P(5,:) = testFS(source, target, [0 0 0 0])

source = "../images/bangko_13_512x512.png"
target = "../img/q16/i6"
P(6,:) = testFS(source, target, [0 0 0 0])



function P = testFS(source, target, cropVal)

    I1 = imread(source);
    % I1 = rgb2gray(I1);
    
    I1_QU16  = image_quantization(I1, [2 4 2]); % 16
    I1_FS16  = FS_quantization   (I1, [2 4 2]); % 16
    I1_QU256 = image_quantization(I1, [8 8 4]); % 256
    I1_FS256 = FS_quantization   (I1, [8 8 4]); % 256

    
    figure; imshow(I1     );
    figure; imshow(I1_QU16);
    figure; imshow(I1_FS16);
    figure; imshow(I1_QU256);
    figure; imshow(I1_FS256);
    
    
    mkdir(target);
    imwrite(I1,       target + "/origi.png")
    imwrite(I1_QU16,  target + "/QU_16.png")
    imwrite(I1_FS16,  target + "/FS_16.png")
    imwrite(I1_QU256, target + "/QU256.png")
    imwrite(I1_FS256, target + "/FS256.png")

    
    P1_QU16  = psnr(I1_QU16,I1)
    P1_FS16  = psnr(I1_FS16,I1)
    P1_QU256 = psnr(I1_QU256,I1)
    P1_FS256 = psnr(I1_FS256,I1)

    P = [P1_QU16, P1_FS16, P1_QU256, P1_FS256]

end
