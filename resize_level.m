function resized = resize_level(larger, smaller)
    s = size(larger);
    resized = imresize(smaller, s, 'bilinear');
end