


Source = "..\obrazy\TestImages1\color\psal309k_512x512.bmp"
Folder = "..\convertedImg2\jp2"
Target = "img"



%quality = [0:5:100] 

quality = round( logspace(0, 3, 12) );


[A, map] = imread(Source);

mkdir(Folder)


% zapis w roznych jakosciach
for q = quality

    qualityString = sprintf( '%03d', q ) ;

    targetFile = append( Folder, '\', qualityString, Target, '.jp2' )
    if size(map) == [0 0]
        imwrite(A, targetFile, CompressionRatio=q);
    else
        imwrite(A,map, targetFile, CompressionRatio=q);
    end

end

% odczyt PNSR

pnsr1 = []
rozmiar1 = []

for q = quality

    qualityString = sprintf( '%03d', q ) ;
    targetFile = append( Folder, '\', qualityString, Target, '.jp2' )
    
    [A1,map1] = imread(targetFile);
    
    pnsr1 = [pnsr1, psnr(A1,A)];

    rozmiar1 = [rozmiar1  (dir(targetFile).bytes)];


end


figure
plot(quality ,pnsr1)
grid on
xlabel("Quality")
ylabel("PNSR, dB")


figure
plot( quality, rozmiar1/1024)
grid on
xlabel("Quality")
ylabel("Size, kB")


figure
plot( rozmiar1/1024, pnsr1)
grid on
xlabel("Size, kB")
ylabel("PNSR, dB")


% zmniejszenie rozmiaru pliku

for q = quality

    qualityString = sprintf( '%03d', q ) ;
    targetFile = append( Folder, '\', qualityString, Target, '.jp2' )
    
    [A1,map1] = imread(targetFile);
    
    A2 = A1(200:end-200, 200:end-200, :);

    imwrite(A2, targetFile + '.png');

end



% zapis wyników do pliku

t1 = ""
for i = [1: max(size(quality))]
    t2 = sprintf("Q = %d   size=%1.2f kB \n",quality(i),rozmiar1(i)/1024)
    t1 = t1  + t2

end


fid = fopen(append(Folder, '/', 'result'), 'w');
fprintf(fid, t1);
fclose(fid);






