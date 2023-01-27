function resized = box_filtering(inputImg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = size(inputImg,1);
if N > 2
    convolved = conv2(inputImg,[1,1;1,1], 'valid');
    smaller = convolved(1:2:end,1:2:end)/4;
    size(smaller)
    resized = interp2(smaller, 8, 'linear');
%     size(resized)
    figure, imshow(resized);
    box_filtering(smaller);
else
    convolved = conv2(inputImg,[1,1;1,1], 'valid');
    final_pixel = convolved(1:2:end,1:2:end)/4;
    final_matrix = ones(256)*final_pixel;
    size(final_matrix)
    imshow(final_matrix)
end