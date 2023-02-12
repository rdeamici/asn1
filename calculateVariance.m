function localVar = calculateVariance(segmented)
    % local variance is defined as E[X^2] - E[X]^2
    % define a 3x3 window the calculate local
    % variance around each pixel
    sz = 3;
    window = ones(sz);

    % calculate local means E[X]
    mu = conv2(segmented,window,'same')./conv2(ones(size(segmented)),window,'same');

    % calculate local means of squares E[X^2]
    II = conv2(segmented.^2,window,'same')./conv2(ones(size(segmented)),window,'same');
    
    % calculate local variance E[X^2] - E[X]^2
    localVar = II-(mu.^2);
end