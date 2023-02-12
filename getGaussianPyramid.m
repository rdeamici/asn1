function imPyramid = getGaussianPyramid(image)
    box_filter = [1/4 1/4; 1/4 1/4];
    imPyramid = cell(9);
    imPyramid{1} = image;
    curImg = image(:,:); % make a copy
    levels = log2(size(image,1));
    % log2 levels of blur + 1 level
    % for original image
    for i= 2:levels+1
        c = conv2(curImg, box_filter, 'valid');
        if size(c,1) > 1
            subsampled = c(1:2:end, 1:2:end);
        else
            subsampled = c;
        end
        imPyramid{i} = subsampled;
        curImg = subsampled;
    end
end
