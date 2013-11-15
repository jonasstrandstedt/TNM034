function [notes] = findNotes(bw, linelocations)
%findNotes
%loads the template image, finds the correlation for the template and the 
%bwimage, locates centroids for the found notes and classifies the notes.
%output is a string with the notes. input is a black and white image.

space = (linelocations(2)-linelocations(1))/2;
   

template = imread('template1.png');
level = graythresh(template);
template = im2bw(template,level);
template = 1-template;
template = imresize(template,[2*space NaN]); 

bwinv = 1-bw;

C = normxcorr2(template, bwinv);
C = im2bw(C, 0.65);


C = bwmorph(C, 'dilate', 2);

L = bwlabel(C,4);


stats = regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);
% plot (centroids(:,1),centroids(:,2),'b*')
% hold off

y_centroids = centroids(:,2);
notes = '';
length = size(y_centroids,1);


for i = 1:length
    if y_centroids(i) <(linelocations(1)-5*space)
           notes = strcat(notes,'E4');
   elseif y_centroids(i) <(linelocations(1)-4*space)
           notes = strcat(notes,'D4');
   elseif y_centroids(i) <(linelocations(1)-3*space)
           notes = strcat(notes,'C4');
   elseif y_centroids(i) <(linelocations(1)-2*space)
           notes = strcat(notes,'B3');
   elseif y_centroids(i) <(linelocations(1)-space)
           notes = strcat(notes,'A3');
   elseif y_centroids(i)<(linelocations(1))
           notes = strcat(notes,'G3');
   elseif y_centroids(i) <(linelocations(1)+space)
           notes = strcat(notes,'F3');
   elseif y_centroids(i) <(linelocations(2))
           notes = strcat(notes,'E3');
   elseif y_centroids(i) <(linelocations(2)+space)
           notes = strcat(notes,'D3');
   elseif y_centroids(i) <(linelocations(3))
           notes = strcat(notes,'C3');
   elseif y_centroids(i) <(linelocations(3)+space)
           notes = strcat(notes,'B2');
   elseif y_centroids(i) <(linelocations(4))
           notes = strcat(notes,'A2');
   elseif y_centroids(i)<(linelocations(4)+space)
           notes = strcat(notes,'G2');
   elseif y_centroids(i) <linelocations(5)
           notes = strcat(notes,'F2');
   elseif y_centroids(i) <(linelocations(5)+space)
           notes = strcat(notes,'E2');
   elseif y_centroids(i) <(linelocations(5)+2*space)
           notes = strcat(notes,'D2');
   elseif y_centroids(i) <(linelocations(5)+3*space)
           notes = strcat(notes,'C2');
   elseif y_centroids(i) <(linelocations(5)+4*space)
           notes = strcat(notes,'B1');
   elseif y_centroids(i) <(linelocations(5)+5*space)
           notes = strcat(notes,'A1'); 
   elseif y_centroids(i) <(linelocations(5)+6*space)
           notes = strcat(notes,'G1');
   else 
           notes = strcat(notes,'-');
end


end

