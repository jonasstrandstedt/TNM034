function [ num_bars ] = countbars( bw)
%COUNTBARS Count the number of lines in an image
%   bw is a black & white image

%debugimage(bw,'BEfore labeling')
bw = bwareaopen(bw, 13);
nums = bwconncomp(bw);
num_bars = nums.NumObjects;
%bwlabelreturn = bwlabel(bw);
%num_bars = bwlabelreturn(2);

end

