function [notes] = findNotes(im, linelocations)
%findNotes
%   im: input image is a "straightened" rgb image with one staff
%   linelocations: input vector containing the y-coords for each staffline
%   notes: output string containing the notes in the image
% 
%loads the template image, finds the correlation for the template and the 
%image, locates centroids for the found notes and classifies the notes.

%% SETTINGS
debug = false;

%% Preparations
space = (linelocations(2)-linelocations(1))/2;

%% Convert to binary
level = graythresh(im);
bw = im2bw(im, level);
bwinv = 1-bw;


%% prepare the image before template matching
thinned = bwmorph(bwinv, 'thin');
imfixed = thinned;


%% Template resizing
template = im2double(imread('template1.png'));
level = graythresh(template);
template = im2bw(template,level);
template = 1-template;
template = imresize(template,[2*space NaN]); 

C = normxcorr2(template, imfixed);
C2 = C;
level = graythresh(C) + 0.5;
%C = im2bw(C, 0.55);
C = im2bw(C, level);
%C = bwmorph(C, 'dilate', 2);
L = bwlabel(C,4);
stats = regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);

%% DEBUGGING
if debug
    %debugimage(imfixed,'Image centroids is fetched from',@()plot(centroids(:,1),centroids(:,2),'b*'));
    %debugimage(C,'Result image centroids is fetched from',@()plot(centroids(:,1),centroids(:,2),'b*'));
    debugimage(C2,'Result image centroids is fetched from');
    debugimage(C,'Result image centroids is fetched from');
end

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

%% Removing notes that are found two times
%int16(round(centroids(:,1:2)))
centroids_to_remove = [];
for i = 1:size(centroids(:,1),1)-1
    cx1 = int16(round(centroids(i,1)));
    cy1 = int16(round(centroids(i,2)));
    cx2 = int16(round(centroids(i+1,1)));
    cy2 = int16(round(centroids(i+1,2)));
    if abs(cx1 - cx2) < 3 && abs(cy1 - cy2) < 4
        centroids_to_remove = [centroids_to_remove i+1];
        centroids(i,1) = (centroids(i,1) + centroids(i+1,1)) / 2;
        centroids(i,2) = (centroids(i,2) + centroids(i+1,2)) / 2;
    end
end
centroids = removeindices(centroids, centroids_to_remove);
%int16(round(centroids(:,1:2)))

%% remove 1/16 notes
[eighths, centroids_to_remove] = getdoublebarnotes(bwinv, centroids,linelocations);
%centroids = removeindices(centroids, centroids_to_remove);



%% DEBUGGING
if debug
    filtered_centroid = removeindices(centroids, centroids_to_remove);
    debugimage(bwinv,'BW with filtered centroid and line locations',@()plot(filtered_centroid(:,1),filtered_centroid(:,2),'b*'),@()plot (50,linelocations(:,1), 'r*'));
end

%% classify notes
%dummie data
%eighths= [1 2 3 4 5 6 7 8 9 10 11 12];

y_centroids = centroids(:,2);

notes = classification(y_centroids,linelocations, eighths, centroids_to_remove, space);


end

