function [ num_bars ] = countbars( bw , debug)
%COUNTBARS Count the number of lines in an image
%   bw is a black & white image

bw = bwareaopen(bw, 15);
[labeledImage, num_bars] = bwlabel(bw);



end

