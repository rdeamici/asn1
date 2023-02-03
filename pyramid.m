function [images] = pyramid(img_dbl)
%     images = cell(1,9);
    images = cell(1,8);
    original_size = size(img_dbl);
    curImg = img_dbl;
%     images{1} = img_dbl;
    imageNum = 1;

    N = original_size(1);
    while N > 1
        convolved = conv2(curImg,[.25,.25;.25,.25], 'valid');
        curImg = convolved(1:2:end,1:2:end);
%         curImg = imresize(curImg,{[.25,.25;.25,.25],4})
        images{imageNum} = curImg;
        imageNum = imageNum + 1;
        N = size(curImg,1);
    end
end