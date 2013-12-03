function [ num_bars ] = countbars( bw)
%COUNTBARS Count the number of lines in an image
%   bw is a black & white image

bw = bwareaopen(bw, 15);
bwlabelreturn = bwlabel(bw);
num_bars = bwlabelreturn(2);

end

