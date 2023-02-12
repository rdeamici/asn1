clc;
clear all;
close all;
imagefiles = [
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];

for i = 1: length(imagefiles)
    curImgPath = imagefiles(i);
    orig = imread(curImgPath);
    img_dbl = im2double(orig);
    origSize = size(img_dbl);
    gaussianPyr = getGaussianPyramid(img_dbl);
    
    laplacianPyramid = laplacian(gaussianPyr);
    levels = length(laplacianPyramid);
    levels
    for i = 1 : levels
        cur = laplacianPyramid{i};
        laplacianPyramid{i} = mat2gray(imresize(laplacianPyramid{i},origSize, 'bilinear'));
    end
    figure, montage(laplacianPyramid, 'Size',[2 4]);
%     combined = montage(laplacianPyramid);
%     imsave(combined);
end