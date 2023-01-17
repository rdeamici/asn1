% replace this with your own filepath
filepath = "<path>\<to>\img-gallery\<some_image>jpg";
A = imread(filepath);
img_dbl = im2double(A);

% a) Sort all the intensities in A, 
%    put the result in a single 10000-dimensional vector x,
%    and plot the values in x. 
x = sort(img_dbl(:));
plot(x);

% b) show a histogram of A)s intensities with 32 bins. 
histogram(x,32);

t = mean(A(:));

% c) white where intensity in A is greater than t, else black.
thresh_img = A;
thresh_img(thresh_img > t) = 255; % white
thresh_img(thresh_img<t) = 0;     % black

% d) A's mean subtracted from each pixel. Set any negative values to 0
mean_int_img = A - t;
mean_int_img(mean_int_img < 0) = 0;

% e) Let y be the vector: y = [1: 8]. 
% Form s whose first columns are [1, 2, 3, 4], [5, 6, 7, 8]. 
y = [1:8]
s = reshape(y,[4,2]);