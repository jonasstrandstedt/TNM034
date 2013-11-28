function [notes] = findNotes(im, linelocations)
%findNotes
%   im: input image is a "straightened" rgb image with one staff
%   linelocations: input vector containing the y-coords for each staffline
%   notes: output string containing the notes in the image
% 
%loads the template image, finds the correlation for the template and the 
%image, locates centroids for the found notes and classifies the notes.

level = graythresh(im);
bw = im2bw(im, level);

bwinv = 1-bw;
thin = bwmorph(bw, 'thin');


space = (linelocations(2)-linelocations(1))/2;

template = imread('template1.png');
level = graythresh(template);
template = im2bw(template,level);
template = 1-template;
template = imresize(template,[2*space NaN]); 
[tempx, tempy] = size(template);


%bwinv = bw; %opened or bw??
[rows cols] = size(bwinv);
padding = 100;
%compensating for white edge after rotating the image
bwinv(:, 1:10) = 0;
bwinv = [zeros(padding,cols); bwinv; zeros(padding,cols)];
linelocations = linelocations+ padding;

%[rows cols] = size(bwinv);
%bwinv = [zeros(rows, padding) bwinv zeros(rows, padding)];


C = normxcorr2(template, bwinv);
C = im2bw(C, 0.65);
C = bwmorph(C, 'dilate', 2);

%L = logical(C,4);
L = bwlabel(C,4);


stats = regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);



%% g-clef removal
% create black image and project the intensities to the left.

[x y] = size(bwinv); 
R = zeros(x,y);
columnsum = zeros(x,1);
for i=1:x
    columnsum(i) = sum(bwinv(:,i));
    R(1:floor(columnsum(i)),i) = ones(floor(columnsum(i)),1);
end

% normalize
columnsum = columnsum/max(columnsum);

% find the peaks of the projection
[peaks, locations] = findpeaks(columnsum, 'MINPEAKHEIGHT', 0.3);


px = locations(1,1);
c1 = centroids(1,:);

% check if the first centroid is the g-clef and ifso, remove it
if (c1(1) - px) < (12*space)
    centroids(1,:)= [];
end
%% remove 1/16 notes

centroids_to_remove = getdoublebarnotes(bwinv, centroids,linelocations);
centroids = removeindices(centroids, centroids_to_remove);

%% classify notes

% figure
% imshow(bwinv)
% hold on
% plot (centroids(:,1),centroids(:,2),'b*')
% plot (50,linelocations(:,1), 'r*');
% hold off


%figure
%imshow(noteblock)

%dummie data
eighths= [1 2 3 4 5 6 7 8 9 10 11 12];

y_centroids = centroids(:,2);
notes = '';
length = size(y_centroids,1);

counter = 1;

for i = 1:length
    if i == eighths(counter)
       if(counter < numel(eighths))
           counter=counter+1;
       end
       if y_centroids(i) <(linelocations(1)-5*space)
           notes = strcat(notes,'e4');
       elseif y_centroids(i) <(linelocations(1)-4*space)
               notes = strcat(notes,'d4');
       elseif y_centroids(i) <(linelocations(1)-3*space)
               notes = strcat(notes,'c4');
       elseif y_centroids(i) <(linelocations(1)-2*space)
               notes = strcat(notes,'b3');
       elseif y_centroids(i) <(linelocations(1)-space)
               notes = strcat(notes,'a3');
       elseif y_centroids(i)<(linelocations(1))
               notes = strcat(notes,'g3');
       elseif y_centroids(i) <(linelocations(1)+space)
               notes = strcat(notes,'f3');
       elseif y_centroids(i) <(linelocations(2))
               notes = strcat(notes,'e3');
       elseif y_centroids(i) <(linelocations(2)+space)
               notes = strcat(notes,'d3');
       elseif y_centroids(i) <(linelocations(3))
               notes = strcat(notes,'c3');
       elseif y_centroids(i) <(linelocations(3)+space)
               notes = strcat(notes,'b2');
       elseif y_centroids(i) <(linelocations(4))
               notes = strcat(notes,'a2');
       elseif y_centroids(i)<(linelocations(4)+space)
               notes = strcat(notes,'g2');
       elseif y_centroids(i) <linelocations(5)
               notes = strcat(notes,'f2');
       elseif y_centroids(i) <(linelocations(5)+space)
               notes = strcat(notes,'e2');
       elseif y_centroids(i) <(linelocations(5)+2*space)
               notes = strcat(notes,'d2');
       elseif y_centroids(i) <(linelocations(5)+3*space)
               notes = strcat(notes,'c2');
       elseif y_centroids(i) <(linelocations(5)+4*space)
               notes = strcat(notes,'b1');
       elseif y_centroids(i) <(linelocations(5)+5*space)
               notes = strcat(notes,'a1'); 
       elseif y_centroids(i) <(linelocations(5)+6*space)
               notes = strcat(notes,'g1');
       else 
           notes = strcat(notes,'-');
       end
       
    else
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
end

end

