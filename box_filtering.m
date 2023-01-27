function smaller = filterAndResize(inputImg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = size(inputImg,1);
convolved = conv2(inputImg,[1,1;1,1], 'valid');
smaller = convolved(1:2:end,1:2:end)/4;
%     size(smaller)
%     resized = interp2(smaller,'linear', 256);
