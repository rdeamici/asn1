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
secondOrders = cell(8);
variances = cell(8);
segmenteds = cell(8);
zeroCrossings = cell(8);

% generate 2nd order Images
% skip original image 
for level = 2: length(gaussianPyramid)
    gImg = gaussianPyramid{level};
    secondOrder = conv2(gImg,laplacianOperator,'same');
    secondOrders{level-1} = secondOrder;
end
figure, montage(secondOrders,'Size',[2 4]);
title('second order derivatves');

% step 2 segment 2nd Order images
for level = 1: length(secondOrders)
    segmented = secondOrders{level};
    segmented(segmented>0) = 1;
    segmented(segmented<0) = 0;
    segmenteds{level} = segmented;
end
figure, montage(segmenteds, 'Size',[2 4]);
title('2nd order images segmented');

% step 3 detect zero crossings
for level = 1: length(segmenteds)
    segIm = segmenteds{level};
    if size(segIm,1) > 1
        zeroCrossing = findZeroCrossings(segIm);
    else
        zeroCrossing = 0;
    end 
    zeroCrossings{level} = zeroCrossing;
end
figure, montage(zeroCrossings,'Size', [2 4])
title('zero crossings');

% step 4: Calculate the local variance and mark it as an edge pixel if this
% value is greater than a certain threshold.
edgeImages = cell(length(gaussianPyramid));
threshold = .245;
for level = 1: length(zeroCrossings)
    segmented = segmenteds{level};
    zeroCrossing = zeroCrossings{level};
    variance = calculateVariance(segmented);
    edgeImg = variance.*zeroCrossing;
    edgeImg(edgeImg>threshold) = 1;
    edgeImg(edgeImg<threshold) = 0;
%     for row = 1: N
%         for col = 1: N
%             output(row,col) = 0;
%             if secondOrder(row,col) == 1 && variance(row,col) > threshold
%                 output(row,col) = 1;
%             end
%         end
%     end
    edgeImages{level} = edgeImg;
end
% display results
figure, montage(edgeImages,'Size',[2 4]);
title('final output');
% for i = 1 : length(edgeImages)
%     subplot(4,2,i), imshow(edgeImages{i});
%     title('final output');
% end
