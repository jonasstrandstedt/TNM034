%%%%%%%%%%%%%%%%%%%%%%%%%% 
function strout = tnm034(Im) 
% 
% Im: Input image of captured sheet music. Im should be in 
% double format, normalized to the interval [0,1] 
% 
% strout: The resulting character string of the detected notes. 
% The string must follow the pre-defined format, explained below. 
% 
% Your program code? 

% gauss filter
gauss =  fspecial('gaussian', 5, 0.9);

% line detection filter (notes disappear)
kernel = [ -1 -1 -1; 2 2 2; -1 -1 -1] / 9;

% make grayscale image and get size
grayscale = rgb2gray(Im);
[x y]=size(grayscale);

% blur the grayscale image
blurred = conv2(grayscale,gauss,'same');

% threshold and invert the image
Im_BW = im2bw(grayscale, 0.8);
Im_BW = 1-Im_BW;

% use the line detection kernel
C = conv2(Im_BW,kernel);
C = im2bw(C, 0.3);

% create black image and project the intensities to the left.
R = zeros(x,y);
for i=1:x
    rowsum = sum(C(i,:));
    R(i,1:rowsum) = ones(1, rowsum);
end

%figure
%imshow(blurred);
%figure
%imshow(Im_BW);
%figure
%imshow(C);
figure
imshow(R);

strout = 'TEST';
end
%%%%%%%%%%%%%%%%%%%%%%%%%% 