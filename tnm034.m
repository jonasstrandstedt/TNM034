%%%%%%%%%%%%%%%%%%%%%%%%%% 
function strout = tnm034(Im) 
% 
% Im: Input image of captured sheet music. Im should be in 
% double format, normalized to the interval [0,1] 
% 
% strout: The resulting character string of the detected notes. 
% The string must follow the pre-defined format, explained below. 
% Your program code? 


%% Settings
debug = false;
hardcodedthreshold = 0.8;

%% Preparations
notes = '';

% make BW image and invert
grayscale = rgb2gray(Im);
level = graythresh(grayscale);
BW = im2bw(grayscale, level);
BW = 1-BW;

%% TEST FREDAG(?)
BW08 = im2bw(grayscale, hardcodedthreshold);
BW08 = 1-BW08;
angle = getstraightenangle(BW08);
BW08rot = imrotate(BW08,angle,'bicubic','crop');

angle = getstraightenangle(BW);
Imrot = imrotate(Im,angle,'bicubic','crop');

%compensating for white edge after rotating the image
[rows, columns] = size(BW08rot);
BW08rot(1:10, :) = 0;
BW08rot(rows-10:rows, :) = 0;
BW08rot(:, 1:10) = 0;

[staff,linepositions]= staffDivision(Imrot, BW08rot);%testar skicka in BW8rot
staffsize = size(staff);
numberofstaffs = staffsize(3);

%% Process each staff
for i=1:numberofstaffs
    if debug
        imgtitle = strcat('Staff about to be processed [', num2str(i), ']');
        debugimage(staff(:,:,i), imgtitle);
    end
    
    %find the notes in the image
    morenotes = findNotes(staff(:,:,i), linepositions(:,i));
    notes = strcat(notes,'n', morenotes);
end

%% Return the note string
strout = notes;
end
%%%%%%%%%%%%%%%%%%%%%%%%%% 