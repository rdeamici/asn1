function laplacianPyramid = laplacian(gaussianPyr)
    laplacianPyramid = cell(length(gaussianPyr)-1);
    lapLevels = length(laplacianPyramid);
    for p = 1:lapLevels
%         p
        larger = gaussianPyr{p};
%         size(larger)
        smaller = gaussianPyr{p+1};
%         size(smaller)
        resized = resize_level(larger, smaller);
        laplacianPyramid{p} = larger - resized;
%         size(laplacianPyramid{p})
    end
