function [ padded_bw ] = addpadding( bw , padding)

bwsize = size(bw);
padded_bw = [zeros(padding,bwsize(2)); bw; zeros(padding,bwsize(2))];
bwsize = size(padded_bw);
padded_bw = [zeros(bwsize(1),padding), padded_bw, zeros(bwsize(1), padding)];


end

