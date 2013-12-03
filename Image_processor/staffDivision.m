function [staff, linepositions] = staffDivision(Im, BW)
%UNTITLED2 Summary of this function goes here
%   Im: input image is a "straightened" rgb image
%   BW: input image is a blackandwhite "straightened image
%   staff: output matrix containing the cutout staffs in each layer,
%   (staff nr i = staff(:,:,i)
%   linepositions: output vector with y-coords for the lines in each staff,
%   y-coords for staff nr i = linepositions(:,i)

%find the stafflines in the bw image
outlocations = findLines(BW);

%save the size for Im
sizeIm = size(Im);
sy = sizeIm(2);

% calculate the cut distance, for cropping the first staff from the
% original image
n = numel(outlocations)/5;
cutover = zeros(n,1);
cutunder = zeros(n,1);
staffheight = (outlocations(2) - outlocations(1))*4;


cutover(1) = outlocations(1) - staffheight;
cutunder(1) = outlocations(5) + staffheight;

%calculate the cutpositions for each staff
for i = 1:n-1
    j=(i*5)+1;
    cutover(i+1) = outlocations(j) - staffheight;
    cutunder(i+1) = outlocations(j+4) + staffheight;
end


sx = cutunder(1)-cutover(1)+5;

staff = ones(sx,sy,n);
linepositions = zeros(5,n);
bwstaffsout = ones(sx,sy,n);

%make the im bw with a thresh of 0.8 to be able to use findLines on the
%staffs 
graystaffs =rgb2gray(Im);
bwstaffs = im2bw(graystaffs, 0.8);
bwstaffs = 1-bwstaffs;


% crop off the staffs and find the positions of the stafflines
for i = 1:n
    h = cutunder(i) - cutover(i);
    staff(1:h+1,1:sy,i) = Im(cutover(i):cutunder(i),1:sy);
    bwstaffsout(1:h+1,1:sy,i) = bwstaffs(cutover(i):cutunder(i),1:sy);
    linepositions(:,i) = findLines(bwstaffsout(1:h+1,1:sy,i));

end


end

