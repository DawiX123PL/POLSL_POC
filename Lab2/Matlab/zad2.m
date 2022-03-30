clear all
close all
clc


sourceImage = "..\Obrazy\Bayer\GT_sRGB\cienkopisy_srgb.png"
%sourceImage = "C:\Users\dawid\Desktop\testowe.png"


imagesList = [...
...%{"sourceCFA",                 "sourceRGB",             "folder", [top, bot, left, right] }; ...
    { "cienkopisy_srgb_CFA.png" , "cienkopisy_srgb.png"  , "img01", [1,1,1,1]  }; ...
    { "IMG_0016_srgb_CFA.png"   , "IMG_0016_srgb.png"    , "img02", [1,1,1,1]  }; ...
    { "IMG_0018_srgb_CFA.png"   , "IMG_0018_srgb.png"    , "img03", [1,1,1,1]  }; ...
    { "IMG_0022_srgb_CFA.png"   , "IMG_0022_srgb.png"    , "img04", [1,1,1,1]  }; ...
    { "IMG_003_srgb_CFA.png"    , "IMG_003_srgb.png"     , "img05", [1,1,1,1]  }; ...
    { "IMG_006_srgb_CFA.png"    , "IMG_006_srgb.png"     , "img06", [1,1,1,1]  }; ...
    { "IMG_007_srgb_CFA.png"    , "IMG_007_srgb.png"     , "img07", [1,1,1,1]  }; ...
    { "IMG_008_srgb_CFA.png"    , "IMG_008_srgb.png"     , "img08", [1,1,1,1]  }; ...
    { "IMG_009_srgb_CFA.png"    , "IMG_009_srgb.png"     , "img09", [1,1,1,1]  }; ...
    { "IMG_010_srgb_CFA.png"    , "IMG_010_srgb.png"     , "img10", [1,1,1,1]  }; ...
    { "IMG_011_srgb_CFA.png"    , "IMG_011_srgb.png"     , "img11", [1,1,1,1]  }; ...
    { "IMG_012_srgb_CFA.png"    , "IMG_012_srgb.png"     , "img12", [1,1,1,1]  }; ...
    { "IMG_013_srgb_CFA.png"    , "IMG_013_srgb.png"     , "img13", [1,1,1,1]  }; ...
    { "IMG_014_srgb_CFA.png"    , "IMG_014_srgb.png"     , "img14", [1,1,1,1]  }; ...
    { "IMG_015_srgb_CFA.png"    , "IMG_015_srgb.png"     , "img15", [1,1,1,1]  }; ...
    { "IMG_0440_srgb_CFA.png"   , "IMG_0440_srgb.png"    , "img16", [1,1,1,1]  }; ...
    { "IMG_0669_srgb_CFA.png"   , "IMG_0669_srgb.png"    , "img17", [1,1,1,1]  }; ...
    { "IMG_0670_srgb_CFA.png"   , "IMG_0670_srgb.png"    , "img18", [1,1,1,1]  }; ...
    { "IMG_0674_srgb_CFA.png"   , "IMG_0674_srgb.png"    , "img19", [1,1,1,1]  }; ...
    { "IMG_7066_srgb_CFA.png"   , "IMG_7066_srgb.png"    , "img20", [1,1,1,1]  }; ...
    { "IMG_7067_srgb_CFA.png"   , "IMG_7067_srgb.png"    , "img21", [1,1,1,1]  }; ...
    { "IMG_7068_srgb_CFA.png"   , "IMG_7068_srgb.png"    , "img22", [1,1,1,1]  }; ...
    { "IMG_7069_srgb_CFA.png"   , "IMG_7069_srgb.png"    , "img23", [1,1,1,1]  }; ...
    { "IMG_7072_srgb_CFA.png"   , "IMG_7072_srgb.png"    , "img24", [1,1,1,1]  }; ...
    { "IMG_7073_srgb_CFA.png"   , "IMG_7073_srgb.png"    , "img25", [1,1,1,1]  }; ...
    { "IMG_7074_srgb_CFA.png"   , "IMG_7074_srgb.png"    , "img26", [1,1,1,1]  }; ...
    { "IMG_7076_srgb_CFA.png"   , "IMG_7076_srgb.png"    , "img27", [1,1,1,1]  }; ...
    { "IMG_7078_srgb_CFA.png"   , "IMG_7078_srgb.png"    , "img28", [1,1,1,1]  }; ...
    { "IMG_7084_srgb_CFA.png"   , "IMG_7084_srgb.png"    , "img29", [1,1,1,1]  }; ...
    { "IMG_7085_srgb_CFA.png"   , "IMG_7085_srgb.png"    , "img30", [1,1,1,1]  }; ...
    { "IMG_7107_srgb_CFA.png"   , "IMG_7107_srgb.png"    , "img31", [1,1,1,1]  }; ...
    { "IMG_7109_srgb_CFA.png"   , "IMG_7109_srgb.png"    , "img32", [1,1,1,1]  }; ...
    { "IMG_7111_srgb_CFA.png"   , "IMG_7111_srgb.png"    , "img33", [1,1,1,1]  }; ...
    { "IMG_7116_srgb_CFA.png"   , "IMG_7116_srgb.png"    , "img34", [1,1,1,1]  }; ...
]



scale = 3.3


for imageData = imagesList'
    disp(imageData)

    inputCFA = append("..\Obrazy\Bayer\CFA_sRGB\", imageData{1} )
    inputRGB = append("..\Obrazy\Bayer\GT_sRGB\", imageData{2} )

    targetFolder = append("..\zad1\", imageData{3} )

    image_resize_test(inputCFA,[], scale)

end






function image_resize_test(source, targetFolder, scale)
        
    sourceImage = source
    I = imread(sourceImage);

    I = double(I)./255;

    



    I1 = imresize(I,scale,"nearest");
    I2 = resize_nearest(I,scale);

    cropImage = @(A) A(20:end-150,200:end-50,:);
    I   = cropImage(I);
    I1  = cropImage(I1);
    I2  = cropImage(I2);


    figure()
    sgtitle(source)
    subplot(1,2,1);
        imshow(I1);
    subplot(1,2,2);
        imshow(I2);

    
    max(I1 - I2,[], 'all')

end



