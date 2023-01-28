imagefiles = [
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];
laplacianPyramid = cell(1,8);
for i = 1: length(imagefiles)
    curImgPath = imagefiles(i);
    images = pyramid(curImgPath);
    level = size(images,2);
    for p = 1:level-1
        laplacianPyramid{p} = mat2gray(imsubtract(images{p},images{p+1}));
    end
    combined = montage(laplacianPyramid);
    imsave(combined);

end