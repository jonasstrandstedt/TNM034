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
BW = im2bw(grayscale, hardcodedthreshold);
BW = 1-BW;
angle = getstraightenangle(BW);
BWrot = imrotate(BW,angle,'bicubic','crop');

%compensating for white edge after rotating the image
[rows, columns] = size(BWrot);
BWrot(1:10, :) = 0;
BWrot(rows-10:rows, :) = 0;
BWrot(:, 1:10) = 0;

[staff,linepositions]= staffDivision(BWrot);%testar skicka in BW8rot
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
    if ~isempty(notes)
        notes = strcat(notes,'n');
    end
    notes = strcat(notes, morenotes);
    
    if debug
        disp(['current staff: ', morenotes]);
        disp('Press ENTER to close all figures and process the next staff..');
        pause
        close all
    end
end

%% Return the note string
strout = notes;
end
%%%%%%%%%%%%%%%%%%%%%%%%%% 