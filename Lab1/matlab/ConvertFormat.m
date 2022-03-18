function ConvertFormat(Source, Folder, Target)

    mkdir(Folder)

    [A,amap] = imread(Source);
    [x,cmap]=rgb2ind(A,256);

    t_name1 = append( '1', Target,          '.png' );
    t_name2 = append( '2', Target,          '.gif' );
    t_name3 = append( '3', Target, '_Q80' , '.jpg' );
    t_name4 = append( '4', Target, '_Q50' , '.jpg' );
    t_name5 = append( '5', Target, '_Q30' , '.jp2' );
    t_name6 = append( '6', Target, '_Q20' , '.jp2' );

    % save file in different formats 
    imwrite(x,cmap , append(Folder, '/', t_name1), 'png' )
    imwrite(x,cmap , append(Folder, '/', t_name2), 'gif' )
    imwrite(x,cmap , append(Folder, '/', t_name3), 'jpg' , Quality=80 )
    imwrite(x,cmap , append(Folder, '/', t_name4), 'jpg' , Quality=50 )
    imwrite(A     , append(Folder, '/', t_name5), 'jp2' , CompressionRatio=30 )
    imwrite(A     , append(Folder, '/', t_name6), 'jp2' , CompressionRatio=20 )

    % save files back to png
    [A1, map1] = imread(append(Folder, '/', t_name1));
    [A2, map2] = imread(append(Folder, '/', t_name2));
    [A3, map3] = imread(append(Folder, '/', t_name3));
    [A4, map4] = imread(append(Folder, '/', t_name4));
    [A5, map5] = imread(append(Folder, '/', t_name5));
    [A6, map6] = imread(append(Folder, '/', t_name6));

    %[A1] = ind2rgb8(A1, map1);
    %[A2] = ind2rgb8(A2, map2);
    %[X3] = ind2rgb(A3, map3);
    %[X4] = ind2rgb(A4, map4);
    %[X5] = ind2rgb(A5, map5);
    %[X6] = ind2rgb(A6, map6);


    imwrite(A1, map1, append(Folder, '/_', t_name1, '.png'), 'png' )
    imwrite(A2, map2, append(Folder, '/_', t_name2, '.png'), 'png' )
    imwrite(A3,       append(Folder, '/_', t_name3, '.png'), 'png' )
    imwrite(A4,       append(Folder, '/_', t_name4, '.png'), 'png' )
    imwrite(A5,       append(Folder, '/_', t_name5, '.png'), 'png' )
    imwrite(A6,       append(Folder, '/_', t_name6, '.png'), 'png' )



    % get data from files ( PSNR size ) 


    [A1, map1] = imread(append(Folder, '/_', t_name1, '.png'));
    [A2, map2] = imread(append(Folder, '/_', t_name2, '.png'));
    [A3, map3] = imread(append(Folder, '/_', t_name3, '.png'));
    [A4, map4] = imread(append(Folder, '/_', t_name4, '.png'));
    [A5, map5] = imread(append(Folder, '/_', t_name5, '.png'));
    [A6, map6] = imread(append(Folder, '/_', t_name6, '.png'));

    if isa(A,'uint16')

        A1 = ind2rgb(A1,map1);
        A2 = ind2rgb(A2,map2);
        
        PSNR1 = psnr(uint16( round(A1 * 2^16) ) , A);
        PSNR2 = psnr(uint16( round(A2 * 2^16) ) , A);
        PSNR3 = psnr(uint16( A3 ) * 256 , A);
        PSNR4 = psnr(uint16( A4 ) * 256, A);
        PSNR5 = psnr(A5, A);
        PSNR6 = psnr(A6, A);
    else
        PSNR1 = psnr(A1, x);
        PSNR2 = psnr(A2, x);
        PSNR3 = psnr(A3, A);
        PSNR4 = psnr(A4, A);
        PSNR5 = psnr(A5, A);
        PSNR6 = psnr(A6, A);
    end

    size1 = dir( append(Folder, '/', t_name1) ).bytes;
    size2 = dir( append(Folder, '/', t_name2) ).bytes;
    size3 = dir( append(Folder, '/', t_name3) ).bytes;
    size4 = dir( append(Folder, '/', t_name4) ).bytes;
    size5 = dir( append(Folder, '/', t_name5) ).bytes;
    size6 = dir( append(Folder, '/', t_name6) ).bytes;


    tofile = '';

    tofile = append(tofile, '1 : PSNR = ', string(PSNR1) , '  size = ', string(size1/1024), 'kB' , '\n' );
    tofile = append(tofile, '2 : PSNR = ', string(PSNR2) , '  size = ', string(size2/1024), 'kB' , '\n' );
    tofile = append(tofile, '3 : PSNR = ', string(PSNR3) , '  size = ', string(size3/1024), 'kB' , '\n' );
    tofile = append(tofile, '4 : PSNR = ', string(PSNR4) , '  size = ', string(size4/1024), 'kB' , '\n' );
    tofile = append(tofile, '5 : PSNR = ', string(PSNR5) , '  size = ', string(size5/1024), 'kB' , '\n' );
    tofile = append(tofile, '6 : PSNR = ', string(PSNR6) , '  size = ', string(size6/1024), 'kB' , '\n' );

    
    fid = fopen(append(Folder, '/', 'result'), 'w');

    fprintf(fid, tofile);
    fclose(fid);


end





