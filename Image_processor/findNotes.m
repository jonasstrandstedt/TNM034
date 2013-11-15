function [notes] = findNotes( bw)
%findNotes
%loads the template image, finds the correlation for the template and the 
%bwimage, locates centroids for the found notes and classifies the notes.
%output is a string with the notes. input is a black and white image.

linedistance = 10;
linethickness = linedistance/ 5;
thin = bwmorph(bw, 'thin');
opened = bwmorph(thin, 'open');
partsearch = opened;
%opened = bwmorph(opened, 'thin');
%figure
%imshow(thin)
%figure
%imshow(opened)
%figure
%imshow(opened)

template = imread('template1.png');
level = graythresh(template);
template = im2bw(template,level);
template = 1-template;

C1 = normxcorr2(template, opened);
level = graythresh(C1);
C = im2bw(C1, 0.6);

%figure
%imshow(C1);

C = bwmorph(C, 'dilate', 2);

%L = logical(C,4);
L = bwlabel(C,4);


stats = regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);


centroids_to_remove = getdoublebarnotes(bw, centroids);

centroidsx = centroids(:,1);
centroidsy = centroids(:,2);
centroidsx(centroids_to_remove) = [];
centroidsy(centroids_to_remove) = [];

centroids = [centroidsx centroidsy];

plot (centroids(:,1),centroids(:,2),'b*')
%plot (centroids(i,1),centroids(i,2),'r*')
%hold off

%figure
%imshow(noteblock)

y_centroids = centroids(:,2);
notes = 'n';
length = size(y_centroids,1);

for i = 1:length
   if y_centroids(i)<55
       notes = strcat(notes,'G3');
   elseif y_centroids(i) <60
           notes = strcat(notes,'F3');
   elseif y_centroids(i) <64
           notes = strcat(notes,'E3');
   elseif y_centroids(i) <69
           notes = strcat(notes,'D3');
   elseif y_centroids(i) <74
           notes = strcat(notes,'C3');
   elseif y_centroids(i) <78
           notes = strcat(notes,'B2');
   elseif y_centroids(i) <83
           notes = strcat(notes,'A2');
   elseif y_centroids(i) <88
           notes = strcat(notes,'G2');
   else 
           notes = strcat(notes,'-');
end


end

