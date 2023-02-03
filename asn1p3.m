imagefiles = [
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\CARTOON.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\flowergray.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\kitty.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\polarcities.jpg";
        "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\asn1\img-gallery\text.jpg"
        ];
laplacianOperator = [-.125 -.125 -.125; -.125 1 -.125; -.125 -.125 -.125];
% class(laplacianOperator)

secondOrderDervs = cell(1,8);
% step 1
for i = 1: length(imagefiles)
    curImgPath = imagefiles(i);
    orig = imread(curImgPath);
    img_dbl = im2double(orig);
    origSize = size(img_dbl);
    gaussianPyramid = pyramid(img_dbl);
    outputs = cell(1,numel(gaussianPyramid)-2);
    for level = 1: length(gaussianPyramid)-2
        image = gaussianPyramid{level};
%         class(image)
        convolved = conv2(image,laplacianOperator, 'valid');
        secondDerivative = convolved(1:3:end,1:3:end);
        secondOrderDervs{level} = secondDerivative;
        % step 2
        segmented = secondDerivative;
        segmented(segmented>0) = 1;
        segmented(segmented<0) = 0;
        % step 3
        shiftLeft = segmented.*circshift(segmented,-1,2);
        shiftRight = segmented.*circshift(segmented,1,2);
        shiftUp = segmented.*circshift(segmented,1,1);
        shiftDown = segmented.*circshift(segmented,-1,1);
        shiftUpLeft = segmented.*circshift(segmented,[1,-1]);
        shiftUpRight = segmented.*circshift(segmented,[1,1]);
        shiftdownLeft = segmented.*circshift(segmented,[-1,-1]);
        shiftdownRight = segmented.*circshift(segmented,[-1,1]);
        zeroCrossingsShifted = shiftLeft+shiftRight+shiftUp+shiftDown+shiftUpLeft+shiftUpRight+shiftdownLeft+shiftdownRight;
%         zeroCrossingsShifted = shiftLeft+shiftRight+shiftUp+shiftDown;
        zeroCrossingsShifted(zeroCrossingsShifted>1) = 1;
        % step 4: Calculate the local variance and mark it as an edge pixel if this
        % value is greater than a certain threshold.
        sz = 3;
        mn = floor(sz/2);
        output = zeros(size(segmented));
        padded = padarray(segmented,[mn mn]);
                
        for i=1:size(padded,1)-mn*2
            for j=1:size(padded,2)-mn*2
                tmp = padded(i:i+(sz-1),j:j+(sz-1));
                mu = mean(tmp(:));
                tmp2 = mean(tmp(:).^2);
                output(i,j)=tmp2 - mu.^2;
            end
        end
        output = output.*zeroCrossingsShifted;
        output(output > .23) = 1;
        output(output <= .23) = 0;
        outputs{level} = imresize(output,origSize, 'bilinear');
    end
    for i = 1 : length(outputs)
        figure, imshow(outputs{i});
    end
%     combined = montage(outputs);
    %     imsave(combined)
%     figure, imshow(combined)
end
