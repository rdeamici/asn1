function [images] = pyramid(path)
    orig = imread(path);
    img_dbl = im2double(orig);
    images = cell(1,9);
    original_size = size(img_dbl);
    smaller = img_dbl;
    images{1} = img_dbl;
    imageNum = 1;

    N = original_size(1);
    while N > 2
        imageNum = imageNum + 1;
        convolved = conv2(smaller,[1,1;1,1], 'valid');
        smaller = convolved(1:2:end,1:2:end)/4;
        resized = imresize(smaller,original_size);
        images{imageNum} = resized;
        N = size(smaller,1);
    end

    convolved = conv2(smaller,[1,1;1,1], 'valid');
    final_pixel = convolved(1:2:end,1:2:end)/4;
    final_image = ones(256)*final_pixel;
    images{9} = final_image;
end