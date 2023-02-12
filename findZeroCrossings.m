function zeroCrossings = findZeroCrossings(segmented)
    neighbors = ones(3);
    zeroCrossings = segmented;
    neighAvs = conv2(segmented,neighbors,'same')./conv2(ones(size(segmented)),neighbors,'same');
    zeroCrossings(neighAvs>0) = 1;
    zeroCrossings(neighAvs==1) = 0;
%   zeroCrossings(neighAvs == 0) = 0;
end