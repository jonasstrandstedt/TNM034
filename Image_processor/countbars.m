function [ num_bars ] = countbars( bw, linedistance)
%COUNTBARS Count the number of lines in an image
%   bw is a black & white image

bw = bwareaopen(bw, linedistance-3);
nums = bwconncomp(bw);
num_bars = nums.NumObjects;

end

