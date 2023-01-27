filepath = "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\img-gallery\flowergray.jpg";
orig = imread(filepath);
img_dbl = im2double(orig);
figure, imshow(img_dbl)
box_filtering(img_dbl);
