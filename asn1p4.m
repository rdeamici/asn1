clc;
clear all;

imagefiles = [
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg"
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];

%  step 1: laplacian pyramids for 2 images
leftImagePath = imagefiles(2);
leftOrig = imread(leftImagePath);
leftImg_dbl = im2double(leftOrig);
leftGaussPyr = getGaussianPyramid(leftImg_dbl);

rightImagePath = imagefiles(4);
rightOrig = imread(rightImagePath);
rightImg_dbl = im2double(rightOrig);

rightGaussPyr = getGaussianPyramid(rightImg_dbl);

leftLaplacian = laplacian(leftGaussPyr);
whos leftLaplacian
rightLaplacian = laplacian(rightGaussPyr);

% step 2: create binary mask
origSize = size(im2double(imread(leftImagePath)),1);
mask = double(zeros(origSize));
mask(:,1:origSize/2) = 1;
% maskGaussPyr = getGaussianPyramid(mask);
mask = double(zeros(2));
mask(:,1) = 1;

% step 3: gaussian pyramid for above mask
cur = mask;
levels = log2(origSize)+1;
maskGaussPyr = cell(9);
maskGaussPyr{9} = cur;
for i = 1:levels-1
    cur = impyramid(cur, 'expand');
    cur = vertcat(cur, cur(size(cur,1),:));
    zc = zeros(size(cur,1),1);
    cur = [cur,zc];
    maskGaussPyr{levels-i} = cur;
    size(cur)
    if i < 3
        cur
        fliplr(cur)
    end
end
% 

% step 4: create laplacian Pyramid by linear interpolation of 
%         left and right laplacian pyramids
newLaplacian = cell(length(leftLaplacian));
blendedImage = zeros(origSize);
for level = 1: length(leftLaplacian)
    size(maskGaussPyr{level})
    size(leftLaplacian{level})
    combined = (maskGaussPyr{level+1}.*leftLaplacian{level}) + ((1-maskGaussPyr{level+1}).*rightLaplacian{level});
%     combined = (maskGaussPyr{level}.*leftLaplacian{level}) + ((1-maskGaussPyr{level}).*rightLaplacian{level});
    combined = imresize(combined,[origSize origSize],'bilinear');
    newLaplacian{level} = combined;
    blendedImage = blendedImage+combined;
end

imshow(blendedImage, []);
