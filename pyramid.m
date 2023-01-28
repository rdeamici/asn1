function [images] = pyramid()
    imagefiles = [
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];
    
    for imagefile = 1: length(imagefiles)
    %     curimagefile = load(strcat(d,imagefile.name));
        curImgPath = imagefiles(imagefile)
        orig = imread(curImgPath);
        img_dbl = im2double(orig);
        images = {1,2,3,4,5,6,7,8};
        original_size = size(img_dbl);
        smaller = img_dbl;
        images{1} = img_dbl;
        imageNum = 1;
    
        N = original_size(1);
        while N > 2
            imageNum = imageNum + 1
            convolved = conv2(smaller,[1,1;1,1], 'valid');
            smaller = convolved(1:2:end,1:2:end)/4;
            resized = imresize(smaller,original_size);
            figure, imshow(resized)
            images{imageNum} = resized;
            N = size(smaller,1);
        end
        convolved = conv2(smaller,[1,1;1,1], 'valid');
        final_pixel = convolved(1:2:end,1:2:end)/4
        final_image = ones(256)*final_pixel;
        images{9} = final_image;
        combined = montage(images);
        imsave(combined);
    end