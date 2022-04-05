

I = imread("..\obrazy\cienkopisy_srgb.png");




disp count_rgb2
tic
count2 = count_rgb2(I);
toc


disp count_rgb3
tic
count3 = count_rgb3(I);
toc


%{
disp count_rgb1
tic
% zbyt długo
count1 = count_rgb1(I)
toc

%}




