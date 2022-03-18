Path = "..\convertedImg\T1_s2"

names = [ ...
"_1image.png.png" ...
"_2image.gif.png" ...
"_3image_Q80.jpg.png" ...
"_4image_Q50.jpg.png" ...
"_5image_Q30.jp2.png" ...
"_6image_Q20.jp2.png" ...    
]

cropTop   = 1
cropBot   = 80
cropLeft  = 50
cropRight = 200


for f = names

    [A, map] = imread(Path + '\' + f);
    


    A1 = A(cropTop:end-cropBot, cropLeft:end-cropRight, : );

    if size(map) == [0 0]
        imwrite(A1, Path + '\c' + f)
    else
        imwrite(A1, map, Path + '\c' + f)
    end
end