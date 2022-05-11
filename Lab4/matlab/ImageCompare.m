clear all
close all
clc


SrcPath(1) = "../img/q2/i1";
SrcPath(2) = "../img/q2/i2";
SrcPath(3) = "../img/q2/i3";
SrcPath(4) = "../img/q2/i4";
SrcPath(5) = "../img/q2/i5";
SrcPath(6) = "../img/q2/i6";

originalName = "/orig.png"
programName  = "/Prog.png"

Cmp2 = CompareMultipleImages(SrcPath, originalName, programName)';

SrcPath(1) = "../img/q16/i1";
SrcPath(2) = "../img/q16/i2";
SrcPath(3) = "../img/q16/i3";
SrcPath(4) = "../img/q16/i4";
SrcPath(5) = "../img/q16/i5";
SrcPath(6) = "../img/q16/i6";

originalName    = "/origi.png"
programName16   = "/Pr_16.png"
programName256  = "/Pr256.png"

Cmp16  = CompareMultipleImages(SrcPath, originalName, programName16)';
Cmp256 = CompareMultipleImages(SrcPath, originalName, programName256)';









function val = CompareImage(SrcPath, originalName, programName)
    Ioriginal = imread(SrcPath + originalName);
    Iprogram  = imread(SrcPath + programName);
    
    val = psnr(Iprogram,Ioriginal);
end


function val = CompareMultipleImages(SrcPath, originalName, programName)
    for i = 1:length(SrcPath)
        val(i) = CompareImage(SrcPath(i), originalName, programName);
    end
end

