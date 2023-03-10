% replace this with your own filepath
filepath = "C:\Users\rtdea\Documents\UCI\cs211A-VisualComputing\img-gallery\flowergray.jpg";
A = imread(filepath);
img_dbl = im2double(A);

% a) Sort all the intensities in A, 
%    put the result in a single 10000-dimensional vector x,
%    and plot the values in x. 
x = sort(img_dbl(:));
plot(x);

% b) show a histogram of A)s intensities with 32 bins. 
histogram(x,32);

t = mean(img_dbl(:));

% c) white where intensity in A is greater than t, else black.
thresh_img = img_dbl;
thresh_img(thresh_img > t) = 255; % white
thresh_img(thresh_img<t) = 0;     % black

% d) A's mean subtracted from each pixel. Set any negative values to 0
mean_int_img = img_dbl - t;
mean_int_img(mean_int_img < 0) = 0;

% e) Let y be the vector: y = [1: 8]. 
% Form s whose first columns are [1, 2, 3, 4], [5, 6, 7, 8]. 
y = [1:8]
s = reshape(y,[4,2]);

% f.  Create  a  vector  [1,  3,  5  ...,  99].  
% Extract  the  corresponding  pixel  from  the  image  in  its  two  
% dimensions, i.e., subsample the original image to its half size. 
v = [1:2:256]
subsampled = img_dbl(v,v)
% size(subsampled)
% size(A)

%% 
% g. Use fspecial to create a Gaussian Filter and then apply the imfilter function to the image with 
% the  created  Gaussian  Filter,  by  doing  so  you  should  see  a  blurred  image.  Change  three  
% combinations of parameters of the Gaussian Filter and compare the results. 
% filter = fspecial('gaussian',3,0.5)
which fspecial
filter = fspecial('gaussian',[3,3],3);
blurred = imfilter(img_dbl,filter)
figure, imshow(A)
figure, imshow(blurred)

% h. Apply the conv2 instead of imfilter function to the same process (for one Gaussian Filter), do 
% you see any changes? Why? 



%% 
% def apply_filter(img,filter):
%   smaller_img = apply_filter(img,filter)
%   save(interp2(image, original_size)
% 




