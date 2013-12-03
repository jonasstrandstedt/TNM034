function [ singlebar_centroids, doublebar_centroids] = getdoublebarnotes(BW, centroids, linelocations)
%UNTITLED3 Summary of this function goes here
%Detailed explanation goes here

%% Settings
debug = false;
linedistance = 8;
padding = 100;

%% Preparations
centroidsize = size(centroids);
singlebar_centroids = zeros(centroidsize(1),1);
doublebar_centroids = zeros(centroidsize(1),1);

%% Preprocessing
thin = bwmorph(BW, 'thin');
thin = bwareaopen(thin, 40);
thin = removelines(thin, 'horizontal', 2, linelocations);
thin = removelines(thin, 'vertical', 1);

skel = bwareaopen(thin, 40);
skel = removelines(skel, 'horizontal');
partsearch =  skel;

%% Add padding to the partsearch image so we dont search outside the image
partsearchsize = size(partsearch);
partsearch = [zeros(padding,partsearchsize(2)); partsearch; zeros(padding,partsearchsize(2))];
partsearchsize = size(partsearch);
partsearch = [zeros(partsearchsize(1),padding), partsearch, zeros(partsearchsize(1), padding)];
centroids = centroids + padding;

%% DEBUGGING
if debug
    debugimage(partsearch,'Doublebarnotes partsearch', @()plot (centroids(:,1),centroids(:,2),'b*'));
end

%% More than one bar search
for i=1:centroidsize(1)
    
    clc
    cx = int16(round(centroids(i,1)));
    cy = int16(round(centroids(i,2)));
    
    % UP RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','right');
    noteblock = partsearch(y+dy:y, x:x+dx);
    num_bars = countbars(noteblock);
    if num_bars > 1
        doublebar_centroids(i) = i;
        if debug
            %plotalphablock(x, y ,dx, dy, 'r');
        end
        continue;
    end
    
    % UP LEFT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','left');
    noteblock = partsearch(y+dy:y, x+dx:x);
    num_bars = countbars(noteblock);
    if num_bars > 1
        doublebar_centroids(i) = i;
        if debug
           % plotalphablock(x, y ,dx, dy, 'r');
        end
        continue;
    end
    
    % DOWN RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','right');
    noteblock = partsearch(y:y+dy, x:x+dx);
    num_bars = countbars(noteblock);
    if num_bars > 1
        doublebar_centroids(i) = i;
        if debug
            %plotalphablock(x, y ,dx, dy, 'r');
        end
        continue;
    end
    
    % DOWN LEFT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','left');
    noteblock = partsearch(y:y+dy, x+dx:x);
    num_bars = countbars(noteblock);
    if num_bars > 1
        doublebar_centroids(i) = i;
        if debug
           % plotalphablock(x, y ,dx, dy, 'r');
        end
        continue;
    end
end

% remove double
centroids = removeindices(centroids, doublebar_centroids);
centroidsize = size(centroids);

%% One bar search
for i=1:centroidsize(1)
    
    cx = int16(round(centroids(i,1)));
    cy = int16(round(centroids(i,2)));
    
    % UP RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','right');
    noteblock = partsearch(y+dy:y, x:x+dx);
    num_bars = countbars(noteblock);
    if num_bars == 1
        singlebar_centroids(i) = i;
        if debug
            %plotalphablock(x, y ,dx, dy, 'g');
        end
        continue;
    end
    
    % UP LEFT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','left');
    noteblock = partsearch(y+dy:y, x+dx:x);
    num_bars = countbars(noteblock);
    if num_bars == 1
        singlebar_centroids(i) = i;
        if debug
           % plotalphablock(x, y ,dx, dy, 'g');
        end
        continue;
    end
    
    % DOWN RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','right');
    noteblock = partsearch(y:y+dy, x:x+dx);
    num_bars = countbars(noteblock);
    if num_bars == 1
        singlebar_centroids(i) = i;
        if debug
            %plotalphablock(x, y ,dx, dy, 'g');
        end
        continue;
    end
    
    % DOWN LEFT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','left');
    noteblock = partsearch(y:y+dy, x+dx:x);
    num_bars = countbars(noteblock);
    if num_bars == 1
        singlebar_centroids(i) = i;
        if debug
            %plotalphablock(x, y ,dx, dy, 'g');
        end
        continue;
    end
end

%% DEBUGGING
if debug
    pause
    close all
end

end
