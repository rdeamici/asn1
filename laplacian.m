function laplacianPyramid = laplacian(gaussianPyr)
length(gaussianPyr)
    laplacianPyramid = cell(length(gaussianPyr)-1);
    lapLevels = length(laplacianPyramid);
    for p = 1:lapLevels
        larger = gaussianPyr{p};
        smaller = gaussianPyr{p+1};
        resized = resize_level(larger, smaller);
        laplacianPyramid{p} = larger - resized;
        size(laplacianPyramid{p})
    end
