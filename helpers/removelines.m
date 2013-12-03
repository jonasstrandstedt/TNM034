function [ out ] = removelines( bw, vh, step, loctions )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

out = bw;
vh = lower(vh);

if nargin < 3
    step = 0;
end

rowdiff = 0;
coldiff = 0;

if strcmp(vh, 'horizontal')
    rowdiff = 1;
end
if strcmp(vh, 'vertical')
    coldiff = 1;
end

bwsize = size(bw);
if nargin == 4
    locsize = size(loctions);
    for i=1:locsize(1)
        for j=1:bwsize(2)
            for diff = -step:step
               rowloc = loctions(i) + diff;
               if out(rowloc,j) == 1 && out(rowloc-rowdiff,j-coldiff) == 0 && out(rowloc+rowdiff,j+coldiff) == 0
                   out(rowloc,j) = 0;
               end
            end
        end
    end
else
    for i=1+rowdiff:bwsize(1)-rowdiff
        for j=1+coldiff:bwsize(2)-coldiff
           rowloc = i;
           if out(rowloc,j) == 1 && out(rowloc-rowdiff,j-coldiff) == 0 && out(rowloc+rowdiff,j+coldiff) == 0
               out(rowloc,j) = 0;
           end
        end
    end
end

end

