function variance = calculateVariance(segmented)
    sz = 3;
    mn = floor(sz/2);
    variance = zeros(size(segmented));
    padded = padarray(segmented,[mn mn]);
            
    for i=1:size(padded,1)-mn*2
        for j=1:size(padded,2)-mn*2
            tmp = padded(i:i+(sz-1),j:j+(sz-1));
            mu = mean(tmp(:));
            tmp2 = mean(tmp(:).^2);
            variance(i,j)=tmp2 - mu.^2;
        end
    end
end