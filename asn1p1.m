imagefiles = [
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];

for i = 1: length(imagefiles)
    orig = imread(imagefiles(i));
    img_dbl = im2double(orig);
    origSize = size(img_dbl);


    images = pyramid(img_dbl);
    for i=1:length(images)
        images{i} = imresize(images{i},origSize, 'bilinear');
    end
    combined = montage(images);
%     imsave(combined);
end