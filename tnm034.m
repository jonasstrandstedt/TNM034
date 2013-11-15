%%%%%%%%%%%%%%%%%%%%%%%%%% 
function strout = tnm034(Im) 
% 
% Im: Input image of captured sheet music. Im should be in 
% double format, normalized to the interval [0,1] 
% 
% strout: The resulting character string of the detected notes. 
% The string must follow the pre-defined format, explained below. 
% Your program code? 


% make grayscale image and get size
grayscale = rgb2gray(Im);
[x y]=size(grayscale);

level = graythresh(grayscale);
BW = im2bw(grayscale, level);

%inverterar bilden
BW = 1-BW;

%
angle = getstraightenangle(BW);
BW = imrotate(BW,angle,'bicubic','crop');
BWT = im2bw(BW, 0.1);

Imrot = imrotate(Im,angle,'bicubic','crop');

% Rotate BW
% figure
% imshow(BW);
% figure
% imshow(BWT);


%create black image and project the intensities to the left.
%R = zeros(x,y);
%for i=1:x
%    rowsum = sum(C(i,:));
%    R(i,1:rowsum) = ones(1, rowsum);
%end

%separate the staffs
staff = staffDivision(Imrot);
staffsize = size(staff);
numberofstaffs = staffsize(3);
notes = '';

for i=1:numberofstaffs
    figure
    imshow(staff(:,:,i))
    %find the notes in the image
    morenotes = findNotes(staff(:,:,i));
    notes = strcat(notes,'n', morenotes);

end
% figure
% imshow(bw2)





%figure
%imshow(blurred);
%figure
%imshow(Im_BW);
%figure
%imshow(C);
%figure
%imshow(R);

strout = notes;
end
%%%%%%%%%%%%%%%%%%%%%%%%%% 