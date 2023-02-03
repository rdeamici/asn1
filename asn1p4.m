imagefiles = [
%         "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
%         "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg"
%         "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];

%  step 1: laplacian pyramids for 2 images
leftImagePath = imagefiles(1);
leftOrig = imread(leftImagePath);
class(leftOrig)
leftImg_dbl = im2double(leftOrig);
leftGaussPyr = pyramid(leftImg_dbl);

rightImagePath = imagefiles(2);
rightOrig = imread(rightImagePath);
rightImg_dbl = im2double(rightOrig);
rightGaussPyr = pyramid(rightImg_dbl);

leftLaplacian = laplacian(leftGaussPyr);
rightLaplacian = laplacian(rightGaussPyr);

% step 2: create binary mask
origSize = size(im2double(imread(leftImagePath)),1);
mask = zeros(origSize,origSize);
mask(1:origSize/2,:,:) = 1;
% size(mask)

% step 3: gaussian pyramid for above mask
maskGaussPyr = pyramid(mask);
% maskGaussPyr{8}(1,:)

% step 4: create laplacian Pyramid by linear interpolation of 
%         left and right laplacian pyramids
newLaplacian = cell(1,7);

numel(leftLaplacian)
numel(rightLaplacian)
numel(maskGaussPyr)

for level = 1: length(leftLaplacian)
    combined = (maskGaussPyr{level}.*leftLaplacian{level}) + ((1-maskGaussPyr{level}).*rightLaplacian{level});
    newLaplacian{level} = combined;
%     figure, imshow(combined)
end

final_result = newLaplacian{end};
% size(final_result)
% figure, imshow(final_result)
lvls = numel(newLaplacian);
for k = (lvls - 1): -1: 1
    nextLvl = newLaplacian{k};
    N = size(nextLvl,1);
    final_result = imresize(final_result,2,'bilinear');
    final_result = final_result(1:N,1:N,:) + nextLvl;
end
imwrite(final_result,"flowerCities.png");
