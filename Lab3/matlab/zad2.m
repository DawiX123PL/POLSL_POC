clear all
close all
clc


zad1_RGB("..\obrazy\baboon_512x512.bmp"   , "..\zad2\rgb1")
zad1_RGB("..\obrazy\lena_512x512.bmp"     , "..\zad2\rgb2")
zad1_RGB("..\obrazy\peppers3_512x512.bmp" , "..\zad2\rgb3")
zad1_RGB("..\obrazy\bangko_13_512x512.png", "..\zad2\rgb4")
zad1_RGB("..\obrazy\frymire_512x512.png"  , "..\zad2\rgb5")
zad1_RGB("..\obrazy\kodim23_512x512.png"  , "..\zad2\rgb6")

zad1_HSV("..\obrazy\baboon_512x512.bmp"   , "..\zad2\hsv1")
zad1_HSV("..\obrazy\lena_512x512.bmp"     , "..\zad2\hsv2")
zad1_HSV("..\obrazy\peppers3_512x512.bmp" , "..\zad2\hsv3")
zad1_HSV("..\obrazy\bangko_13_512x512.png", "..\zad2\hsv4")
zad1_HSV("..\obrazy\frymire_512x512.png"  , "..\zad2\hsv5")
zad1_HSV("..\obrazy\kodim23_512x512.png"  , "..\zad2\hsv6")


function ret = zad1_RGB(nazwa, targetName)
    
    I1 = imread(nazwa);
    
    I1 = double(I1)./255;
    
    I1_222 = image_quantization(I1, [2 2 2]);
    I1_444 = image_quantization(I1, [4 4 4]);
    I1_464 = image_quantization(I1, [4 6 4]);
    I1_884 = image_quantization(I1, [8 8 4]);
    
    C    = size(count_rgb4(I1),    1);
    C222 = size(count_rgb4(I1_222),1);
    C444 = size(count_rgb4(I1_444),1);
    C464 = size(count_rgb4(I1_464),1);
    C884 = size(count_rgb4(I1_884),1);
    
    P222 = psnr(I1_222, I1);
    P444 = psnr(I1_444, I1);
    P464 = psnr(I1_464, I1);
    P884 = psnr(I1_884, I1);
    
    
    zad    = sprintf( 'Oryginał \\\\ Liczba barw = %d', C )
    zad222 = sprintf( 'Kwant. 2x2x2 \\\\ Liczba barw = %d \\\\ PSNR = %0.4f', C222 , P222)
    zad444 = sprintf( 'Kwant. 4x4x4 \\\\ Liczba barw = %d \\\\ PSNR = %0.4f', C444 , P444)
    zad464 = sprintf( 'Kwant. 4x6x4 \\\\ Liczba barw = %d \\\\ PSNR = %0.4f', C464 , P464)
    zad884 = sprintf( 'Kwant. 8x8x4 \\\\ Liczba barw = %d \\\\ PSNR = %0.4f', C884 , P884)


    ret = append(...
                zad   ,newline,...
                zad222,newline,...
                zad444,newline,...
                zad464,newline,...
                zad884,newline)



    mkdir(targetName)

    imwrite(I1     , targetName +  "/I1_ori.png");
    imwrite(I1_222 , targetName +  "/I1_222.png");
    imwrite(I1_444 , targetName +  "/I1_444.png");    
    imwrite(I1_464 , targetName +  "/I1_464.png");
    imwrite(I1_884 , targetName +  "/I1_884.png");  


    fid = fopen(targetName +  "/data",'w');
    fprintf(fid, '%s',ret );
    fclose(fid);


end


function ret = zad1_HSV(nazwa, targetName)
    
    I1 = imread(nazwa);
    
    I1 = rgb2hsv(I1);
    
    I1_10 = image_quantization(I1, [10 5 5 6]);
    I1_12 = image_quantization(I1, [12 4 5 6]);

    C    = size(count_rgb4(I1),    1);
    C10 = size(count_rgb4(I1_10),1);
    C12 = size(count_rgb4(I1_12),1);
    
    P10 = psnr(I1_10, I1);
    P12 = psnr(I1_12, I1);
    
    zad    = sprintf( 'Oryginał \\\\ Liczba barw = %d', C )
    zad10 = sprintf( 'Kwant. 10x5x5+6 \\\\ Liczba barw = %d \\\\ PSNR = %0.4f', C10 , P10)
    zad12 = sprintf( 'Kwant. 12x4x5+6 \\\\ Liczba barw = %d \\\\ PSNR = %0.4f', C12 , P12)

    ret = append(...
                zad   ,newline,...
                zad10,newline,...
                zad12,newline)



    mkdir(targetName)
    

    imwrite(hsv2rgb(I1   ), targetName +  "/I1_ori.png");
    imwrite(hsv2rgb(I1_10), targetName +  "/I1_222.png");
    imwrite(hsv2rgb(I1_12), targetName +  "/I1_444.png");


    fid = fopen(targetName +  "/data",'w');
    fprintf(fid, '%s',ret );
    fclose(fid);


end










