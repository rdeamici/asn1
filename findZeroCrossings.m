function zeroCrossings = findZeroCrossings(im)
    n = size(im,1)
    zeroCrossings = zeros([n n]);
    for i = 2:n-1
        % process top row
        col = i;
        firstRow = 1;
        secondRow = 2;
        pVal = im(firstRow,col);
        if im(firstRow, col-1) ~= pVal ||... 
                im(firstRow, col+1) ~= pVal ||...
                im(secondRow, col-1) ~= pVal ||...
                im(secondRow, col) ~= pVal ||...
                im(secondRow, col+1) ~= pVal
            zeroCrossings(firstRow, col) = 1;
        end
        % process bottom row
        lastRow = n;
        nextToLastRow = n-1;
        pVal = im(lastRow,col);
        if im(lastRow,col-1) ~= pVal ||...
                im(lastRow,col+1) ~= pVal ||...
                im(nextToLastRow,col-1) ~= pVal ||...
                im(nextToLastRow,col) ~= pVal ||...
                im(nextToLastRow,col+1) ~= pVal
            zeroCrossings(lastRow,col) = 1;
        end
        % process left column
        firstCol = 1;
        secondCol = 2;
        row = i;
        pVal = im(row, firstCol);
        if im(row-1, firstCol) ~= pVal ||...
                im(row+1,firstCol) ~= pVal ||...
                im(row-1,secondCol) ~= pVal ||...
                im(row,secondCol) ~= pVal ||...
                im(row+1,secondCol) ~= pVal
            zeroCrossings(row, firstCol) = 1;
        end
        % process right column
        lastCol = n;
        nextToLastCol = n-1;
        row = i;
        pVal = im(row, lastCol);
        if im(row-1, lastCol) ~= pVal ||...
                im(row+1,lastCol) ~= pVal ||...
                im(row-1,nextToLastCol) ~= pVal ||...
                im(row,nextToLastCol) ~= pVal ||...
                im(row+1, nextToLastCol) ~= pVal
            zeroCrossings(row,lastCol) = 1;
        end
        % process interior values
        row = i;
        for col = 2:n-1
            pVal = im(row,col);
            if im(row-1, col) ~= pVal ||...
                    im(row+1,col) ~= pVal ||...
                    im(row,col-1) ~= pVal ||...
                    im(row,col+1) ~= pVal ||...
                    im(row-1, col-1) ~= pVal ||...
                    im(row-1, col+1) ~= pVal ||...
                    im(row+1, col-1) ~= pVal ||...
                    im(row+1, col+1) ~= pVal
                zeroCrossings(row,col) = 1;
            end
        end
    end
    % process upper left corner
    pVal = im(1,1);
    if im(1,2) ~= pVal ||...
            im(2,2) ~= pVal ||...
            im(2,1) ~= pVal
        zeroCrossings(1,1) = 1;
    end
    % process upper right corner
    pVal = im(1,n);
    if im(1,n-1) ~= pVal || im(2,n-1) ~= pVal || im(2,n) ~= pVal
        zeroCrossings(1,n) = 1;
    end
    % process lower left corner
    pVal = im(n,1);
    if im(n-1,1) ~= pVal || im(n-1,2) ~= pVal || im(n,2) ~= pVal
        zeroCrossings(n,1) = 1;
    end
    % process lower right corner
    pVal = im(n,n);
    if im(n-1,n) ~= pVal || im(n-1,n-1) ~= pVal || im(n,n-1) ~= pVal
        zeroCrossings(n,n) = 1;
    end
end