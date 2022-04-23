clear all
close all
clc


fid = fopen('zad1_count.txt','w');
fprintf(fid, '%s',  zad1_count("..\obrazy\05_512x512.png" )  );
fprintf(fid, '%s',  zad1_count("..\obrazy\baboon_512x512.bmp"  )  );
fprintf(fid, '%s',  zad1_count("..\obrazy\lena_512x512.bmp"    )  );
fprintf(fid, '%s',  zad1_count("..\obrazy\peppers3_512x512.bmp")  );
fclose(fid);




function [zad] = zad1_count( nazwa )

    I1_RGB = imread(nazwa);
    I1_HSV = rgb2hsv(I1_RGB);
    I1_YCbCr = rgb2lab(I1_RGB);
    
    
    disp count_rgb
    tic 
    countRGB   = size(count_rgb4(I1_RGB), 1) 
    time1 = toc
    countHSV   = size(count_rgb4(I1_HSV), 1) 
    countYCbCr = size(count_rgb4(I1_YCbCr), 1) 

    zad = sprintf( 'POClab = %d \\\\ RGB = %d  \\\\ HSV = %d \\\\ YCbCr = %d \\\\ czas =  %0.4f s \n', countRGB, countRGB, countHSV, countYCbCr , time1 );

end







