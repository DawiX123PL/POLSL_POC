clear all
close all
clc


source = "../images/lena_512x512.bmp"
target = "../img/q2/i1"
P(1,:) = testFS(source, target, [0 0 0 0])

source = "../images/baboon_512x512.bmp"
target = "../img/q2/i2"
P(2,:) = testFS(source, target, [0 0 0 0])

source = "../images/frymire_512x512.png"
target = "../img/q2/i3"
P(3,:) = testFS(source, target, [0 0 0 0])

source = "../images/kodim23_512x512.png"
target = "../img/q2/i4"
P(4,:) = testFS(source, target, [0 0 0 0])

source = "../images/peppers3_512x512.bmp"
target = "../img/q2/i5"
P(5,:) = testFS(source, target, [0 0 0 0])

source = "../images/bangko_13_512x512.png"
target = "../img/q2/i6"
P(6,:) = testFS(source, target, [0 0 0 0])



function P = testFS(source, target, cropVal)

    method = "b" % binarization
    % method = "q" % quantization

    I1 = imread(source);
    I1 = rgb2gray(I1);
    
    
    if method == "q"
        I1_OTSU = image_quantization(I1, [2 2 2]);
        I1_FS   = FS_quantization   (I1, [2 2 2]);
    elseif method == "b"
        I1_OTSU = image_binarization(I1);
        I1_FS   = FS_quantization   (I1, "bin");
    end
    
    
    figure; imshow(I1     );
    figure; imshow(I1_OTSU);
    figure; imshow(I1_FS  );
    
    
    
    mkdir(target);
    imwrite(I1,      target + "/orig.png")
    imwrite(I1_OTSU, target + "/OTSU.png")
    imwrite(I1_FS,   target + "/FS__.png")
    
    
    
    P1_OTSU = psnr(I1_OTSU,I1)
    P1_FS   = psnr(I1_FS  ,I1)

    P = [P1_OTSU, P1_FS]

end
