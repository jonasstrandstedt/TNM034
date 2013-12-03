function [notes] = findNotes(im, linelocations)
%findNotes
%   im: input image is a "straightened" rgb image with one staff
%   linelocations: input vector containing the y-coords for each staffline
%   notes: output string containing the notes in the image
% 
%loads the template image, finds the correlation for the template and the 
%image, locates centroids for the found notes and classifies the notes.
debug = true;

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

%figure
%imshow(bwinv)

%bwinv = bw; %opened or bw??
[rows cols] = size(bwinv);
padding = 200;

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

[eighths, centroids_to_remove] = getdoublebarnotes(bwinv, centroids,linelocations);
centroids = removeindices(centroids, centroids_to_remove);

%% classify notes

if debug == true
    figure
    imshow(bwinv)
    hold on
    plot (centroids(:,1),centroids(:,2),'b*')
    plot (50,linelocations(:,1), 'r*');
    hold off
end


%figure
%imshow(noteblock)

%dummie data
eighths= [1 2 3 4 5 6 7 8 9 10 11 12];

y_centroids = centroids(:,2);

notes = classification(y_centroids,linelocations, eighths, space);


end

