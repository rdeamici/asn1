function laplacianPyramid = laplacian(gaussianPyr)
    laplacianPyramid = cell(size(gaussianPyr)-1);
    levels = numel(gaussianPyr);
    for p = 1:levels-1
        cur = gaussianPyr{p};
        N = size(cur,1);

        smaller = gaussianPyr{p+1};
        resized = imresize(smaller,2,'bilinear');
        laplacianPyramid{p} = cur - resized(1:N,1:N,:);
    end
