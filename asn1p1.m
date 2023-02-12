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
    orig = imread(imagefiles(i));
    img_dbl = im2double(orig);
    origSize = size(img_dbl);
    pyr = getGaussianPyramid(img_dbl);
    size(pyr);
    for i = 1:length(pyr)
        cur = pyr{i};
        pyr{i} = imresize(cur, origSize, 'bilinear');
%         subplot(3,3,i), imshow(pyr{i});
    end
    figure, montage(pyr, 'Size',[3 3])
    %     imshow(combined);
end