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

%% Template resizing
template = imread('template1.png');
level = graythresh(template);
template = im2bw(template,level);
template = 1-template;
template = imresize(template,[2*space NaN]); 

C = normxcorr2(template, bwinv);
C = im2bw(C, 0.65);
C = bwmorph(C, 'dilate', 2);
L = bwlabel(C,4);
stats = regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);

%% DEBUGGING
if debug
    debugimage(bwinv,'Image centroid is fetched from',@()plot(centroids(:,1),centroids(:,2),'b*'));
    debugimage(C,'Image centroid is fetched from',@()plot(centroids(:,1),centroids(:,2),'b*'));
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


%% remove 1/16 notes

[eighths, centroids_to_remove] = getdoublebarnotes(bwinv, centroids,linelocations);
centroids = removeindices(centroids, centroids_to_remove);



%% DEBUGGING
if debug
    debugimage(bwinv,'BW with filtered centroid and line locations',@()plot(centroids(:,1),centroids(:,2),'b*'),@()plot (50,linelocations(:,1), 'r*'));
end

%% classify notes
%dummie data
eighths= [1 2 3 4 5 6 7 8 9 10 11 12];

y_centroids = centroids(:,2);

notes = classification(y_centroids,linelocations, eighths, space);


end

