function smaller = filterAndResize(inputImg)
    N = size(inputImg,1);
    convolved = conv2(inputImg,[1,1;1,1], 'valid');
    smaller = convolved(1:2:end,1:2:end)/4;
end
