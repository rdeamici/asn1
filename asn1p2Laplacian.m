imagefiles = [
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];

for i = 1: length(imagefiles)
    curImgPath = imagefiles(i);
    orig = imread(curImgPath);
    img_dbl = im2double(orig);
    origSize = size(img_dbl)
    gaussianPyr = pyramid(img_dbl);
    
    laplacianPyramid = laplacian(gaussianPyr);
    levels = numel(laplacianPyramid);
    for i = 1 : levels
        laplacianPyramid{i} = imresize(laplacianPyramid{i},origSize);
    end
    combined = montage(laplacianPyramid);
    imsave(combined);

end