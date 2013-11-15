function [ dubblebar_centroids] = getdoublebarnotes(BW, centroids)
%UNTITLED3 Summary of this function goes here
%Detailed explanation goes here

linedistance = 10;
linethickness = linedistance/ 5;
thin = bwmorph(BW, 'thin');
opened = bwmorph(thin, 'open');
partsearch = opened;

partsearch = bwmorph(partsearch, 'close', Inf);
%figure
%imshow(partsearch)
partsearch = bwmorph(partsearch, 'thin', Inf);
%figure
%imshow(partsearch)
%hold on

[sizex sizey] = size(centroids);

dubblebar_centroids = [];
for i=1:sizex
    
    cx = round(centroids(i,1));
    cy = round(centroids(i,2));
    sum_limit = 12;
    
    % UP RIGHT
    x = cx;
    y = cy - linedistance;
    dx = linedistance;
    dy = -4*linedistance;
        
    noteblock = partsearch(y+dy:y, x:x+dx);
    noteblock_sum = sum(noteblock(:));
    
    if noteblock_sum > sum_limit
       dubblebar_centroids = [dubblebar_centroids i];
       %plotalphablock(x, y ,dx, dy, 'r');
       continue;
    end
    
    % UP LEFT
    x = cx - linethickness;
    y = cy - linedistance;
    dx = -linedistance;
    dy = -4*linedistance;
    noteblock = partsearch(y+dy:y, x+dx:x);
    noteblock_sum = sum(noteblock(:));
    if noteblock_sum > sum_limit
       dubblebar_centroids = [dubblebar_centroids i];
       %plotalphablock(x, y ,dx, dy, 'b');
       continue;
    end
    
    % DOWN RIGHT
    x = cx- linedistance;
    y = cy +linethickness;
    dx = linedistance;
    dy = 4*linedistance;
    noteblock = partsearch(y:y+dy, x:x+dx);
    noteblock_sum = sum(noteblock(:));
    if noteblock_sum > sum_limit
       dubblebar_centroids = [dubblebar_centroids i];
         %plotalphablock(x, y ,dx, dy, 'g');
        continue;
    end
    
    % DOWN LEFT
    x = cx - linedistance - linethickness;
    y = cy + linethickness;
    dx = -linedistance;
    dy = 4*linedistance;
    noteblock = partsearch(y:y+dy, x+dx:x);
    noteblock_sum = sum(noteblock(:));
    
    if noteblock_sum > sum_limit
       dubblebar_centroids = [dubblebar_centroids i];
        %plotalphablock(x, y ,dx, dy);
        continue;
    end
end

end

