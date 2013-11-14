function [ angle] = getstraightenangle( BW )
%STRAIGHTEN 
% Calculates the angle of the staffs by using HoughTransform.
% im Is BW, 
% output is angle in degrees.

thetaResolution = 0.1;
rhoResolution = 1;

[H, T, R]  = hough(BW, 'RhoResolution',rhoResolution, 'Theta',-90:thetaResolution:89);
 
peaks = houghpeaks(H);

tempangle = T(peaks(2));



angle = tempangle-90*sign(tempangle)

end

