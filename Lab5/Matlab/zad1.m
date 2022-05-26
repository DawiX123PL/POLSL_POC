close all;
clear all;
clc;

%%

source = "../ObrazySzare/Ex1.png";
destination1 = "../zad1/NoCut/I1";
destination2 = "../zad1/WithCut/I1";
ProduceImages(source, destination1, "NoCut");
ProduceImages(source, destination2, "WithCut");

%%

source = [...
            "../ObrazySzare/Ex1.png", ...
            "../ObrazySzare/Ex2.png", ...
            "../ObrazySzare/Ex3.png", ...
            "../ObrazySzare/M92.png", ...
        ];

destination1 = "../zad1/NoCut";
destination2 = "../zad1/WithCut";

for i = 1:length(source)
    path = destination1 + "/I" + num2str(i);
    ProduceImages(source(i), path, "NoCut");

    path = destination2 + "/I" + num2str(i);
    ProduceImages(source(i), path, "WithCut");
end

%%

function ProduceImages(source, destination, cut)
    
    I1 = imread(source);
    I1 = double(I1) ./ 255;

    if size(I1, 3) ~= 1
        I1 = rgb2gray(I1);
    end

    
    if cut == "NoCut"
        I2 = HistogramStretch(I1, "No Cut");
        I3 = HistogramStretch(I1, "Histeq");
    elseif cut == "WithCut"
        % sztuczne dodanie czarnego i białego pixela
        I1(1,1) = 1;
        I1(1,2) = 0;
        I2 = HistogramStretch(I1, "Cut Insignificant", [.001 .001]);
        I3 = HistogramStretch(I1, "Cut Insignificant", [.02 .02]);
    end
    
    
    figure; imhist(I1); H1 = gcf;
    figure; imhist(I2); H2 = gcf;
    figure; imhist(I3); H3 = gcf;
    
    
    K_calc = @(I) [ k1(I) k2(I) k3(I) k4(I)];
    
    K1 = K_calc(I1);
    K2 = K_calc(I2);
    K3 = K_calc(I3);
    K  = [K1; K2; K3];
    
    
    minmax_calc = @(I) [ min(I,[],"all"), max(I,[],"all") ];
    
    M1 = minmax_calc(I1);
    M2 = minmax_calc(I2);
    M3 = minmax_calc(I3);
    M  = [M1; M2; M3];
    
    % zapis do plikow
    mkdir(destination);

    crop = [.12 .12 .12 .12];
    
    if cut == "NoCut"
        imwrite(cropImage(I1, crop), destination + "/I_Origin.png");
        imwrite(cropImage(I2, crop), destination + "/I_No_Cut.png");
        imwrite(cropImage(I3, crop), destination + "/I_Histeq.png");
        
        saveas(H1, destination + "/H_Origin.png");
        saveas(H2, destination + "/H_No_Cut.png");
        saveas(H3, destination + "/H_Histeq.png");
    elseif cut == "WithCut"
        imwrite(cropImage(I1, crop), destination + "/I_Origin.png");
        imwrite(cropImage(I2, crop), destination + "/I_Cut_P1.png");
        imwrite(cropImage(I3, crop), destination + "/I_Cut_P2.png");
        
        saveas(H1, destination + "/H_Origin.png");
        saveas(H2, destination + "/H_Cut_P1.png");
        saveas(H3, destination + "/H_Cut_P2.png");
    end
    
    close([H1 H2 H3])

    data1 = "k1 = "           + num2str(K1(1), 5) ...
          + " \\\\ k2 = "     + num2str(K1(2), 5) ...
          + " \\\\ k3 = "     + num2str(K1(3), 5) ...
          + " \\\\ k4 = "     + num2str(K1(4), 5) ...
          + " \\\\ min(I) = " + num2str(M1(1), 5) ...
          + " \\\\ max(I) = " + num2str(M1(2), 5) + " \n";

    data2 = "k1 = "           + num2str(K2(1), 5) ...
          + " \\\\ k2 = "     + num2str(K2(2), 5) ...
          + " \\\\ k3 = "     + num2str(K2(3), 5) ...
          + " \\\\ k4 = "     + num2str(K2(4), 5) ...
          + " \\\\ min(I) = " + num2str(M2(1), 5) ...
          + " \\\\ max(I) = " + num2str(M2(2), 5) + " \n";

    data3 = "k1 = "           + num2str(K3(1), 5) ...
          + " \\\\ k2 = "     + num2str(K3(2), 5) ...
          + " \\\\ k3 = "     + num2str(K3(3), 5) ...
          + " \\\\ k4 = "     + num2str(K3(4), 5) ...
          + " \\\\ min(I) = " + num2str(M3(1), 5) ...
          + " \\\\ max(I) = " + num2str(M3(2), 5) + " \n";
         
    data = data1 + data2 + data3;

    disp(data);
    
    fid = fopen(destination + "/result",'w');
    fprintf(fid, data);
    fclose(fid);
    
end















