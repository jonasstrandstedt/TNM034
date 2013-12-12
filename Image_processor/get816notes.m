function [ singlebar_centroids, doublebar_centroids] = get816notes(BW, centroids, linelocations)
%UNTITLED3 Summary of this function goes here
%Detailed explanation goes here

%% Settings
debug = false;
linedistance = 8;
padding = 100;

%% Preparations
centroidsize = size(centroids);
indices = 1:centroidsize(1);
singlebar_centroids = zeros(centroidsize(1),1);
doublebar_centroids = zeros(centroidsize(1),1);

%% Preprocessing
thin = bwmorph(BW, 'thin');
thin = bwareaopen(thin, 40);
thin_cleaned = removelines(thin, 'horizontal', 2, linelocations);
thin = removelines(thin_cleaned, 'vertical', 1);

skel = bwareaopen(thin, 40);
skel = removelines(skel, 'horizontal');
partsearch =  skel;
partsearch =  bwmorph(partsearch, 'thin');
partsearch = removelines(partsearch, 'vertical', 1);

%% Add padding to the partsearch image so we dont search outside the image
partsearch = addpadding(partsearch, padding);
centroids = centroids + padding;

%% DEBUGGING
if debug
    debugimage(partsearch,'Doublebarnotes partsearch', @()plot (centroids(:,1),centroids(:,2),'b*'));
    hold on
end

%% More than one bar search
for i=1:centroidsize(1)
    
    cx = int16(round(centroids(i,1)));
    cy = int16(round(centroids(i,2)));
    
    % UP RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','right');
    noteblock = partsearch(y+dy:y, x:x+dx);
    num_bars = countbars(noteblock, linedistance);
    if num_bars > 1
        doublebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'r');
        end
        continue;
    end
    
    % UP LEFT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','left');
    noteblock = partsearch(y+dy:y, x+dx:x);
    num_bars = countbars(noteblock, linedistance);
    if num_bars > 1
        doublebar_centroids(i) = i;
        if debug
           plotalphablock(x, y ,dx, dy, 'r');
        end
        continue;
    end
    
    % DOWN RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','right');
    noteblock = partsearch(y:y+dy, x:x+dx);
    num_bars = countbars(noteblock, linedistance);
    if num_bars > 1
        doublebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'r');
        end
        continue;
    end
    
    % DOWN LEFT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','left');
    noteblock = partsearch(y:y+dy, x+dx:x);
    num_bars = countbars(noteblock, linedistance);
    if num_bars > 1
        doublebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'r');
        end
        continue;
    end
end

% remove double
doublebar_centroids(doublebar_centroids==0) = [];
indices(doublebar_centroids) = [];

%% One bar search
for i=indices
    cx = int16(round(centroids(i,1)));
    cy = int16(round(centroids(i,2)));
    
    % UP RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','right');
    noteblock = partsearch(y+dy:y, x:x+dx);
    num_bars = countbars(noteblock, linedistance);
    if num_bars == 1
        singlebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'g');
        end
        continue;
    end
    
    % UP LEFT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','left');
    noteblock = partsearch(y+dy:y, x+dx:x);
    num_bars = countbars(noteblock, linedistance);
    if num_bars == 1
        singlebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'g');
        end
        continue;
    end
    
    % DOWN RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','right');
    noteblock = partsearch(y:y+dy, x:x+dx);
    num_bars = countbars(noteblock, linedistance);
    if num_bars == 1
        singlebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'g');
        end
        continue;
    end
    
    % DOWN LEFT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','left');
    noteblock = partsearch(y:y+dy, x+dx:x);
    num_bars = countbars(noteblock, linedistance);
    if num_bars == 1
        singlebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'g');
        end
        continue;
    end
end


% remove double
%centroids = removeindices(centroids, singlebar_centroids);
tmpsingles = singlebar_centroids;
tmpsingles(tmpsingles==0) = [];
indices = 1:centroidsize(1);
indices([tmpsingles; doublebar_centroids(:)]) = [];

thin_cleaned = removelines(thin_cleaned, 'horizontal');
partsearch = addpadding(thin_cleaned, padding);

%% DEBUGGING
if debug
    
    debugimage(partsearch,'Searching for flags', @()plot (centroids(:,1),centroids(:,2),'b*'));
    hold on
end

%% Find single flags

for i=indices
    
    cx = int16(round(centroids(i,1)));
    cy = int16(round(centroids(i,2)));
    
    % UP RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'up','right');
    noteblock = partsearch(y+dy:y, x:x+dx);
    num_bars = countbars(noteblock, linedistance);
    if num_bars > 0
        singlebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'b');
        end
        continue;
    end
    % DOWN RIGHT
    [x, y, dx, dy] = createsearchblock(cx, cy, linedistance, 'down','right');
    noteblock = partsearch(y:y+dy, x:x+dx);
    num_bars = countbars(noteblock, linedistance);
    if num_bars > 0
        singlebar_centroids(i) = i;
        if debug
            plotalphablock(x, y ,dx, dy, 'b');
        end
        continue;
    end
end

end
