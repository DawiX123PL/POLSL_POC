clear all
close all
clc

imagesList = [...
...%{"sourceCFA",                 "sourceRGB",             "folder", [top, bot, left, right] }; ...
    { "cienkopisy_srgb_CFA.png" , "cienkopisy_srgb.png"  , "img01", []  }; ...
    { "IMG_0016_srgb_CFA.png"   , "IMG_0016_srgb.png"    , "img02", []  }; ...
    { "IMG_0018_srgb_CFA.png"   , "IMG_0018_srgb.png"    , "img03", []  }; ...
    { "IMG_0022_srgb_CFA.png"   , "IMG_0022_srgb.png"    , "img04", []  }; ...
    { "IMG_003_srgb_CFA.png"    , "IMG_003_srgb.png"     , "img05", []  }; ...
    { "IMG_006_srgb_CFA.png"    , "IMG_006_srgb.png"     , "img06", []  }; ...
    { "IMG_007_srgb_CFA.png"    , "IMG_007_srgb.png"     , "img07", []  }; ...
    { "IMG_008_srgb_CFA.png"    , "IMG_008_srgb.png"     , "img08", []  }; ...
    { "IMG_009_srgb_CFA.png"    , "IMG_009_srgb.png"     , "img09", []  }; ...
    { "IMG_010_srgb_CFA.png"    , "IMG_010_srgb.png"     , "img10", []  }; ...
    { "IMG_011_srgb_CFA.png"    , "IMG_011_srgb.png"     , "img11", []  }; ...
    { "IMG_012_srgb_CFA.png"    , "IMG_012_srgb.png"     , "img12", []  }; ...
    { "IMG_013_srgb_CFA.png"    , "IMG_013_srgb.png"     , "img13", []  }; ...
    { "IMG_014_srgb_CFA.png"    , "IMG_014_srgb.png"     , "img14", []  }; ...
    { "IMG_015_srgb_CFA.png"    , "IMG_015_srgb.png"     , "img15", []  }; ...
    { "IMG_0440_srgb_CFA.png"   , "IMG_0440_srgb.png"    , "img16", []  }; ...
    { "IMG_0669_srgb_CFA.png"   , "IMG_0669_srgb.png"    , "img17", []  }; ...
    { "IMG_0670_srgb_CFA.png"   , "IMG_0670_srgb.png"    , "img18", []  }; ...
    { "IMG_0674_srgb_CFA.png"   , "IMG_0674_srgb.png"    , "img19", []  }; ...
    { "IMG_7066_srgb_CFA.png"   , "IMG_7066_srgb.png"    , "img20", []  }; ...
    { "IMG_7067_srgb_CFA.png"   , "IMG_7067_srgb.png"    , "img21", []  }; ...
    { "IMG_7068_srgb_CFA.png"   , "IMG_7068_srgb.png"    , "img22", []  }; ...
    { "IMG_7069_srgb_CFA.png"   , "IMG_7069_srgb.png"    , "img23", []  }; ...
    { "IMG_7072_srgb_CFA.png"   , "IMG_7072_srgb.png"    , "img24", []  }; ...
    { "IMG_7073_srgb_CFA.png"   , "IMG_7073_srgb.png"    , "img25", []  }; ...
    { "IMG_7074_srgb_CFA.png"   , "IMG_7074_srgb.png"    , "img26", []  }; ...
    { "IMG_7076_srgb_CFA.png"   , "IMG_7076_srgb.png"    , "img27", []  }; ...
    { "IMG_7078_srgb_CFA.png"   , "IMG_7078_srgb.png"    , "img28", []  }; ...
    { "IMG_7084_srgb_CFA.png"   , "IMG_7084_srgb.png"    , "img29", []  }; ...
    { "IMG_7085_srgb_CFA.png"   , "IMG_7085_srgb.png"    , "img30", []  }; ...
    { "IMG_7107_srgb_CFA.png"   , "IMG_7107_srgb.png"    , "img31", []  }; ...
    { "IMG_7109_srgb_CFA.png"   , "IMG_7109_srgb.png"    , "img32", []  }; ...
    { "IMG_7111_srgb_CFA.png"   , "IMG_7111_srgb.png"    , "img33", []  }; ...
    { "IMG_7116_srgb_CFA.png"   , "IMG_7116_srgb.png"    , "img34", []  }; ...
]


cropDefault = [.1 .6 .6 .1]




for imageData = imagesList'
    disp(imageData)

    inputCFA = append("..\Obrazy\Bayer\CFA_sRGB\", imageData{1} )
    inputRGB = append("..\Obrazy\Bayer\GT_sRGB\", imageData{2} )
    targetFolder = append("..\zad1\", imageData{3} )

    crop = imageData{4};
    if size(crop) == [0 0]
        crop = cropDefault
    end

    demosaic_test(inputCFA, inputRGB, targetFolder, crop)
break
end





function demosaic_test(inputCFA, inputRGB, targetFolder1, crop)
    
DISP_ONLY = true

    inputFileNameCFA = inputCFA;
    inputFileNameRGB = inputRGB;
    targetFolder = targetFolder1;

    %inputFileNameCFA = "..\Obrazy\Bayer\CFA_sRGB\cienkopisy_srgb_CFA.png"
    %inputFileNameRGB = "..\Obrazy\Bayer\GT_sRGB\cienkopisy_srgb.png"
    
    %targetFolder = "..\zad1\img1"
    
    if(DISP_ONLY == false)
        mkdir(targetFolder)
    end
    
    I   = imread(inputFileNameCFA);
    IGT = imread(inputFileNameRGB);
    I1  = demosaic(I,'gbrg'); 
    I2  = demosaic(I,'grbg'); 
    I3  = demosaic(I,'bggr'); 
    I4  = demosaic(I,'rggb'); 
    
    
    %cropImage = @(A) A(20:end-150,200:end-50,:);
    
    I   = cropImage(I,   crop);
    IGT = cropImage(IGT, crop);
    
    I1  = cropImage(I1, crop);
    I2  = cropImage(I2, crop);
    I3  = cropImage(I3, crop);
    I4  = cropImage(I4, crop);
    
    
    
    figure()
    sgtitle(inputCFA)
    subplot(2,3,1);
        imshow(I);
        title("Obraz Surowy")
    subplot(2,3,4);
        imshow(IGT);
        title("Obraz Wzorcowy - GT")
    
    subplot(2,3,2);
        imshow(I1);
        title("gbrg")
    subplot(2,3,3);
        imshow(I2);
        title("grbg")
    subplot(2,3,5);
        imshow(I3);
        title("bggr (prawidlowy)")
    subplot(2,3,6);
        imshow(I4);
        title("rggb")
    

    if(DISP_ONLY == false)
        
        imwrite(I,    append(targetFolder, "\img1_raw_.png"))
        imwrite(IGT,  append(targetFolder, "\img1_gt__.png"))
        
        imwrite(I1,   append(targetFolder, "\img1_gbrg.png"))
        imwrite(I2,   append(targetFolder, "\img1_grbg.png"))
        imwrite(I3,   append(targetFolder, "\img1_bggr.png"))
        imwrite(I4,   append(targetFolder, "\img1_rggb.png"))
    end
end


