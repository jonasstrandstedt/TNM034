function [ im ] = imreadnorm( filename )
%imreadnorm Reads a normalized file
%   Reads the image file specified in the filename. 
%   Normalizes the values to be between 0.0 and 1.0.

A = double(imread(filename));
A_max = max(A(:));
A_min = min(A(:));
A = (A - A_min) / (A_max - A_min);

im = A;

end

