close all;
clc;
clear;
imagefiles = [
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];


% step 1 generate 2nd order derivative images using provided laplacian
% operator
laplacianOperator = [-1/8 -1/8 -1/8; -1/8 1 -1/8; -1/8 -1/8 -1/8];

i = 2; % change this to use the different imageFiles
curImgPath = imagefiles(i);
img = imread(curImgPath);
img_dbl = im2double(img);
N = size(img_dbl,1);

gaussianPyramid = getGaussianPyramid(img_dbl);
for i = 2 : length(gaussianPyramid)
    subplot(2,4,i-1), imshow(imresize(gaussianPyramid{i}, [N N], 'bilinear'));
    title('gaussian pyramid');
end

secondOrders = cell(8);
variances = cell(8);
segmenteds = cell(8);
zeroCrossings = cell(8);

% generate 2nd order Images
% skip original image 
for level = 2: length(gaussianPyramid)
    gImg = gaussianPyramid{level};
    secondOrder = imfilter(gImg,laplacianOperator);
%     figure, imshow(secondOrder)
    secondOrders{level-1} = secondOrder;
end
% for i = 1 : length(secondOrders) - 1
%     subplot(2,4,i), imshow(imresize(secondOrders{i}, [N N], 'bilinear'));
%     title('second order derivatives');
% end
% figure, montage(secondOrders,'Size',[2 4]);
% title('second order derivatves');

% step 2 segment 2nd Order images
for level = 1: length(secondOrders)
    segmented = secondOrders{level};
    segmented(segmented>0) = 1;
    segmented(segmented<0) = 0;
    segmenteds{level} = segmented;
end
% whos segmenteds
% for i = 1 : length(segmenteds) - 1
%     subplot(2,4,i), imshow(imresize(segmenteds{i}, [N N], 'bilinear'));
%     title('2nd order derivative segmented');
% end
% figure, montage(segmenteds, 'Size',[2 4]);
% title('2nd order images segmented');

% step 3 detect zero crossings
for level = 1: length(segmenteds)
    segIm = segmenteds{level};
    zeroCrossing = findZeroCrossings(segIm);
    zeroCrossings{level} = zeroCrossing;
end
% for i = 1 : length(zeroCrossings) - 1
%     subplot(2,4,i), imshow(imresize(zeroCrossings{i}, [N N], 'bilinear'));
%     title('zero crossings');
% %     title('2nd order derivative segmented');
% end
% endfigure, montage(zeroCrossings,'Size', [2 4])
% title('zero crossings');

% step 4: Calculate the local variance and mark it as an edge pixel if this
% value is greater than a certain threshold.
edgeImages = cell(length(gaussianPyramid));
thresholds = [.0015 .002 .004 .005 .007 .006 .002 .002];

for level = 1: length(zeroCrossings)
    secondOrder = secondOrders{level};
    zeroCrossing = zeroCrossings{level};
    variance = calculateVariance(secondOrder);
    edgeImg = variance.*zeroCrossing;
    m = max(max(edgeImg))
    thresh = thresholds(level)
    edgeImg(edgeImg > thresh) = 1;
    edgeImg(edgeImg < thresh) = 0;
    edgeImages{level} = edgeImg;
end
% display results
figure, montage(edgeImages,'Size',[2 4]);
title('final output');
% for i = 1 : length(edgeImages) - 1
%     subplot(2,4,i), imshow(imresize(edgeImages{i}, [N N], 'bilinear'), []);
%     title('final output');
% end
