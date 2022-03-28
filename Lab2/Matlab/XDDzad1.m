clear all
close all
clc


inputFileNameCFA = "..\Obrazy\Bayer\CFA_sRGB\cienkopisy_srgb_CFA.png"
inputFileNameRGB = "..\Obrazy\Bayer\GT_sRGB\cienkopisy_srgb.png"



I = imread(inputFileNameCFA);
IGT=imread(inputFileNameRGB);

figure(1);
subtitle('Identyfikacja układu matrycy Bayera' );
subplot (2,3,1);
    imshow(I(80:180,90:190));
    xlabel('obraz surowy');
subplot (2,3,4);
    imshow(IGT(80:180,90:190,:));
    xlabel('obraz wzorcowy - GT')

%I, IGT slajd wcześniej

IC=I(80:180,90:190); %crop

ICRGB=cat(3,IC,IC,IC);% 1 kanałowy do RGB
IGTC=IGT(80:180,90:190,:);% Crop GT

I1=demosaic(I,'gbrg'); %podobnie I2,I3,I4
I2=demosaic(I,'grbg'); %podobnie I2,I3,I4
I3=demosaic(I,'bggr'); %podobnie I2,I3,I4
I4=demosaic(I,'rggb'); %podobnie I2,I3,I4

I1C=I1(80:180,90:190,:);%crop I1 itd..
I2C=I2(80:180,90:190,:);%crop I1 itd..
I3C=I3(80:180,90:190,:);%crop I1 itd..
I4C=I4(80:180,90:190,:);%crop I1 itd..

%Połączenie obrazów:
im1a=[ICRGB,I1C,I2C];
im1b=[IGTC,I3C,I4C];

%skalowanie 400% metodą NN:
im1aX4=imresize(im1a,4,'nearest');
im1bX4=imresize(im1b,4,'nearest');

%zapisać lub wyświetlić:
%imwrite(im1aX4,'zad1a.png');
%imwrite(im1bX4,'zad1b.png');

im1_ab=[ICRGB,I1C,I2C;IGTC,I3C,I4C];
im1_abX4=imresize(im1_ab,4,'nearest');
%imwrite(im1_abX4,'zad1_ab.png%);














