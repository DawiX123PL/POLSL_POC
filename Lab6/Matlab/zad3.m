clear all;
%close all;
clc



source1 = ["../Obrazy/lena_512x512.bmp";...
           "../Obrazy/baboon_512x512.bmp";...
           "../Obrazy/frymire_512x512.png"];

destination1 = ["../zad3/img1";...
                "../zad3/img2";...
                "../zad3/img3"];


texFileDir = ["../zad3", "/result_1.tex";...
              "../zad3", "/result_2.tex";...
              "../zad3", "/result_3.tex"];


for i = 1:3
    CreateTexFile(source1(i), destination1(i), texFileDir(i,:));
end



function [I1, I2, I3, I4] = ProcessImage(source, destination)
    
    % load images and convert to gray scale
    I = imread(source);
    I = double(I) / 255;
    I = rgb2gray(I);
    I = I(1:500, :);
    
    % process images

 
    I1 = I; % "clean" image
    I2 = HistogramStretch(I1,"Auto"); % global contrast fix
    I3 = filter_Unsharp(I1,3,1,2); % unsharp masking
    I4 = LocalContrastFix(I1,[6,6],0.01); % local contrast fix
    
    


    % display result
    figure; tiledlayout(2,2);

    nexttile; imshow(I1);
    nexttile; imshow(I3);

    nexttile; imshow(I2);
    nexttile; imshow(I4);
   
    [~,~] = mkdir(destination);
    
    imwrite(I1, destination + "/I1.png");
    imwrite(I2, destination + "/I2.png");
    imwrite(I3, destination + "/I3.png");
    imwrite(I4, destination + "/I4.png");

end

function CreateTexFile(source, destination,texFileDir)
     [I1, I2, I3, I4] = ProcessImage(source, destination);


    imPath = destination + ["/I1.png", "/I3.png"; ... 
                            "/I2.png", "/I4.png"];
    
    
    imDesc = [...
        "Obraz O" + " \\ ocena kontrastu k4 = " + string(k4(I1)), ...
        "Obraz UM" + " \\ ocena kontrastu k4 = " + string(k4(I3)); ...
        "Metoda globalna" + " \\ ocena kontrastu k4 = " + string(k4(I2)), ...
        "Metoda lokalna" + " \\ ocena kontrastu k4 = " + string(k4(I4)), ...
        ];

    

    fileContentImages = CreateLatexImages(imPath, imDesc, "Porownanie wyników z różnymi metodami poprawy kontrastu", (texFileDir(1) + texFileDir(2)));
    fileContent = fileContentImages;

        
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
