function [staff, linepositions] = staffDivision(Im)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
grayscale = rgb2gray(Im);
outlocations = findLines(grayscale);
sizeIm = size(Im);
sx = sizeIm(1);
sy = sizeIm(2);

% calculate the cut distance, for cropping the first staff from the
% original image
n = numel(outlocations)/5;
cutover = zeros(n,1);
cutunder = zeros(n,1);
staffheight = (outlocations(2) - outlocations(1))*4;


cutover(1) = outlocations(1) - staffheight;
cutunder(1) = outlocations(5) + staffheight;

for i = 1:n-1
    j=(i*5)+1;
    cutover(i+1) = outlocations(j) - staffheight;
    cutunder(i+1) = outlocations(j+4) + staffheight;
end


sx = cutunder(1)-cutover(1)+5;
staff = ones(sx,sy,n);

linepositions = zeros(5,n);

% crop off the staffs and find the positions of the stafflines
for i = 1:n
    h = cutunder(i) - cutover(i);
    staff(1:h+1,1:sy,i) = Im(cutover(i):cutunder(i),1:sy);
    linepositions(:,i)= findLines(staff(:,:,i));
end

end

