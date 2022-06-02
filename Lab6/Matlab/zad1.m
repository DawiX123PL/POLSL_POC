clear all;
close all;
clc



source1 = ["../Obrazy/lena_512x512.bmp";...
           "../Obrazy/baboon_512x512.bmp";...
           "../Obrazy/frymire_512x512.png"];

source2 = ["../Obrazy/bangko_13_512x512.png";...
           "../Obrazy/kodim23_512x512.png";...
           "../Obrazy/peppers3_512x512.bmp"];

destination1 = ["../zad1/img1";...
                "../zad1/img2";...
                "../zad1/img3"];

destination2 = ["../zad1/img4";...
                "../zad1/img5";...
                "../zad1/img6"];

texFileDir = ["../zad1", "/result_1_4.tex";...
              "../zad1", "/result_2_5.tex";...
              "../zad1", "/result_3_6.tex"];


for i = 1:3
    CreateTexFile(source1(i), destination1(i),...
                    source2(i), destination2(i), texFileDir(i,:));
end



function [I1, I2, I3, mask2, mask3] = ProcessImage(source, destination)
    
    % load images and convert to gray scale
    I = imread(source);
    I = double(I) / 255;
    I = rgb2gray(I);
    I = I(1:500, :);
    
    % process images
    I1 = I;
    
    Md = ones(3) / 9;
    I2 = filter_Linear(I1, Md);
    
    Mg = [0 -1  0;-1  4 -1; 0 -1  0];
    I3 = filter_Linear(I1, Mg);
    
    % return masks
    
    mask2 = Md;
    mask3 = Mg;
    
%     % display result
%     figure;
%     tiledlayout(1,3);
%     
%     nexttile;
%     imshow(I1);
%     
%     nexttile;
%     imshow(I2);
%     
%     nexttile;
%     imshow(I3);
    
    % saving images on disk
    mkdir(destination);
    
    imwrite(I1, destination + "/O1___.png");
    imwrite(I2, destination + "/O1_Md.png");
    imwrite(I3, destination + "/O1_Mg.png");

end

function CreateTexFile(source1, destination1, source2, destination2, texFileDir)
        
        [I1a, I2a, I3a, mask2a, mask3a] = ProcessImage(source1, destination1);
        [I1b, I2b, I3b, mask2b, mask3b] = ProcessImage(source2, destination2);
        
        % save result in tex file
        
        imPath = [destination1 + ["/O1___.png", "/O1_Md.png", "/O1_Mg.png"]; ...
                  destination2 + ["/O1___.png", "/O1_Md.png", "/O1_Mg.png"]; ];


        imDesc = ["Wielkość obrazu O1: " + join(string(size(I1a)), "x") , ...
                  "Wielkość obrazu: "  + join(string(size(I2a)), "x") + "\\ Wielkość maski: " + join(string(size(mask2a)) + "x"), ...
                  "Wielkość obrazu: "  + join(string(size(I3a)), "x") + "\\ Wielkość maski: " + join(string(size(mask3a)) + "x"); ...
                  "Wielkość obrazu O1: " + join(string(size(I1b)), "x"), ...
                  "Wielkość obrazu: "  + join(string(size(I2b)), "x") + "\\ Wielkość maski: " + join(string(size(mask2b)) + "x"), ...
                  "Wielkość obrazu: "  + join(string(size(I3b)), "x") + "\\ Wielkość maski: " + join(string(size(mask3b)) + "x"); ...
                  ];


        fileContentImages = CreateLatexImages(imPath, imDesc, "Porownanie", (texFileDir(1) + texFileDir(2)));
        
%         fileContentImages = join([ ...
%             "\newcommand{\ww}{0.32} ";
%             "\begin{figure}[H] ";
%             "    \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % ";
%             "    \subfloat[";
%             "       Wielkość obrazu O1: " + join(string(size(I1a)), "x") + "]{";
%             "       \includegraphics[width=\ww\linewidth]{" + destination1 + "/O1___.png}} \hfill%";
%             "    \subfloat[";
%             "       Wielkość obrazu: "  + join(string(size(I2a)), "x") + "\\ Wielkość maski: " + join(string(size(mask2a)) + "x")+ "]{"; 
%             "       \includegraphics[width=\ww\linewidth]{" + destination1 + "/O1_Md.png}} \hfill% wypełnenie";
%             "    \subfloat[";
%             "       Wielkość maski Md: "  + join(string(size(I3a)), "x") + "\\ Wielkość maski: " + join(string(size(mask3a)) + "x")+ "]{";
%             "       \includegraphics[width=\ww\linewidth]{" +  destination1 +  "/O1_Mg.png}} \\ ";
%             "    \subfloat[";
%             "       Wielkość obrazu O2: " + join(string(size(I1b)), "x")+ "]{";
%             "       \includegraphics[width=\ww\linewidth]{" +  destination2 +  "/O1___.png}} \hfill%";
%             "    \subfloat[";
%             "       Wielkość obrazu: " + join(string(size(I2b)), "x") + "\\ Wielkość maski: " + join(string(size(mask2b)) + "x")+ "]{";
%             "       \includegraphics[width=\ww\linewidth]{" +  destination2 +  "/O1_Md.png}} \hfill";
%             "    \subfloat[";
%             "       Wielkość maski Mg: " + join(string(size(I3b)), "x") + "\\ Wielkość maski: " + join(string(size(mask3b)) + "x")+ "]{";
%             "       \includegraphics[width=\ww\linewidth]{" +  destination2 +  "/O1_Mg.png}}";
%             "    \caption{Tekst do zmiany}  ";
%             "    \label{fig:" + (texFileDir(1) + texFileDir(2)) + "} ";
%             "\end{figure} ";
%             "\let\ww\undefined "...
%             ],newline );
% 

        maskDescription = join([ ...
            "maski użyte do filtracji obrazu:";
            "$$";
            "\begin{array}{cc}";
            "Md = " + mat2Latex(mask2a);
            "&";
            "Mg = " + mat2Latex(mask3a);
            "\end{array}";
            "$$";
            ],newline );

        fileContent = fileContentImages + newline + maskDescription;
        
        fid1 = fopen(texFileDir(1) + texFileDir(2), 'w');
        fprintf(fid1, '%s', fileContent);
        fclose(fid1);

        fid1 = fopen(destination1 + "\result.tex", 'w');
        fprintf(fid1, '%s', fileContent);
        fclose(fid1);

        fid1 = fopen(destination2 + "\result.tex", 'w');
        fprintf(fid1, '%s', fileContent);
        fclose(fid1);
        
end

function latexMatrix = mat2Latex(mat)
    latexMatrix = latex(sym(mat));
    latexMatrix = strrep(latexMatrix, "array", "bmatrix")
    latexMatrix = strrep(latexMatrix, "\left(", " ")
    latexMatrix = strrep(latexMatrix, "\right)", " ")
    ccc = "{" + join(repmat("c", [size(mat,2),1]),"") + "}"
    latexMatrix = strrep(latexMatrix, ccc, " ")
    latexMatrix = strrep(latexMatrix, "\\", "\\[6pt]" + newline)
end