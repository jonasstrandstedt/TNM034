function [notes] = findNotes( bw)
%findNotes
%loads the template image, finds the correlation for the template and the 
%bwimage, locates centroids for the found notes and classifies the notes.
%output is a string with the notes. input is a black and white image.

template = imread('template1.png');
level = graythresh(template);
template = im2bw(template,level);
template = 1-template;

C = normxcorr2(template, bw);
C = im2bw(C, 0.6);

%figure
%imshow(C);
%hold on

C = bwmorph(C, 'dilate', 2);

L = bwlabel(C,4);


stats = regionprops(L,'centroid');
centroids = cat(1, stats.Centroid)
%plot (centroids(:,1),centroids(:,2),'b*')
%hold off

y_centroids = centroids(:,2);
notes = 'n';
length = size(y_centroids,1);

for i = 1:length
   if y_centroids(i)<55
       notes = strcat(notes,'G2');
   elseif y_centroids(i) <60
           notes = strcat(notes,'F2');
   elseif y_centroids(i) <64
           notes = strcat(notes,'E2');
   elseif y_centroids(i) <69
           notes = strcat(notes,'D2');
   elseif y_centroids(i) <74
           notes = strcat(notes,'C2');
   elseif y_centroids(i) <78
           notes = strcat(notes,'B1');
   elseif y_centroids(i) <83
           notes = strcat(notes,'A1');
   elseif y_centroids(i) <88
           notes = strcat(notes,'G1');
   else 
           notes = strcat(notes,'-');
end


end

