function [ angle] = getstraightenangle( BW )
%STRAIGHTEN 
% Calculates the angle of the staffs by using HoughTransform.
% im Is BW, 
% output is angle in degrees.


thetaResolution = 0.01;
rhoResolution = 1;

BW = bwmorph(BW, 'thin', Inf);
BW = imrotate(BW, 90, 'bicubic','crop');
[H, T, R]  = hough(BW, 'RhoResolution',rhoResolution, 'Theta',-10:thetaResolution:10);

h = H/max(max(H));

peaks = houghpeaks(H)


angle = T(peaks(2))

%angle = tempangle*(sign(tempangle));

end

