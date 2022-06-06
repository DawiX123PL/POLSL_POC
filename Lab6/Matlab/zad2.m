clear all;
%close all;
clc



source1 = ["../Obrazy/lena_512x512.bmp";...
           "../Obrazy/baboon_512x512.bmp";...
           "../Obrazy/frymire_512x512.png"];

destination1 = ["../zad2/img1";...
                "../zad2/img2";...
                "../zad2/img3"];


texFileDir = ["../zad2", "/result_1.tex";...
              "../zad2", "/result_2.tex";...
              "../zad2", "/result_3.tex"];


for i = 1:3
    CreateTexFile(source1(i), destination1(i), texFileDir(i,:));
end



function [I1, I2, I3, I4, I5, I6, maskMd, maskMg] = ProcessImage(source, destination)
    
    % load images and convert to gray scale
    I = imread(source);
    I = double(I) / 255;
    I = rgb2gray(I);
    I = I(1:500, :);
    
    % process images

    maskMd = ones(5) / 5^2
    maskMg = [-1 -1 -1; -1 8 -1; -1 -1 -1]
    %maskMg = [0 -1 0; -1 4 -1;0 -1 0]

    I1 = I; % "clean" image

    I2 = awgn(I1, 20);
    %I2 = I1 + rand(size(I1)) / 10;

    %[I3, maskMd] = filter_Gausian(I2, 4, 0.48); % low-pass filter
    %[I3, maskMd] = filter_Gausian(I2, 4, 2); % low-pass filter
    [I3, maskMd] = filter_Mean(I2, 3); % low-pass filter
    I4 = I2 - I3;
    
    %[I5, maskMg] = filter_LOG(I3,3,0.71); % hi-pass filter
    [I5, maskMg] = filter_Laplacian(I3); % hi-pass filter
    I6 = I2 + I5;
    
    
    maskMd
    maskMg

    psnr(I2, I1)
    psnr(I3, I1)
    psnr(I6, I1)

    % display result
    figure; tiledlayout(2,3);

    nexttile; imshow(I1);
    nexttile; imshow(I3);
    nexttile; imshow(I5 * 2 + .5);

    nexttile; imshow(I2);
    nexttile; imshow(I4 * 2 + .5);
    nexttile; imshow(I6);
    

    [~,~] = mkdir(destination);
    
    imwrite(I1, destination + "/I1.png");
    imwrite(I2, destination + "/I2.png");
    imwrite(I3, destination + "/I3.png");
    imwrite(I4 * 1.5 + .5, destination + "/I4.png");
    imwrite(I5 * 1.5 + .5, destination + "/I5.png");
    imwrite(I6, destination + "/I6.png");

end

function CreateTexFile(source, destination,texFileDir)
     [I1, I2, I3, I4, I5, I6, maskMd, maskMg] = ProcessImage(source, destination);


    imPath = destination + ["/I1.png", "/I3.png", "/I5.png"; ...
                            "/I2.png", "/I4.png", "/I6.png"];
    
    
    imDesc = [...
        "Wielkość obrazu O1: " + join(string(size(I1)), "x") , ...
        "Wielkość obrazu Id: " + join(string(size(I3)), "x") + "\\ PSNR = " + string(psnr(I3,I1)), ...
        "Wielkość obrazu I: "  + join(string(size(I5)), "x"); ...
        "Os = O + szum" + "\\ PSNR = " + string(psnr(I2,I1)), ...
        "O - Id", ...
        "O - I" + "\\ PSNR = " + string(psnr(I6,I1)), ...
        ];

    

    fileContentImages = CreateLatexImages(imPath, imDesc, "Porownanie", (texFileDir(1) + texFileDir(2)));

    maskDescription = join([ ...
        "maski użyte do filtracji obrazu:";
        "$$";
        "Md = " + mat2Latex(maskMd, 2);
        "$$"; ...
        " \\ "; ...
        "$$";
        "Mg = " + mat2Latex(maskMg, 2);
        "$$";
        ],newline );

    fileContent = fileContentImages + newline + maskDescription;
        
    fid1 = fopen(texFileDir(1) + texFileDir(2), 'w');
    fprintf(fid1, '%s', fileContent);
    fclose(fid1);
    
    fid1 = fopen(destination + "\result.tex", 'w');
    fprintf(fid1, '%s', fileContent);
    fclose(fid1);
    
    fid1 = fopen(destination + "\result.tex", 'w');
    fprintf(fid1, '%s', fileContent);
    fclose(fid1);

end
