function [ new_array ] = removeindices( array, indices )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

indices(indices==0) = [];

arrayx = array(:,1);
arrayy = array(:,2);

arrayx(indices) = [];
arrayy(indices) = [];

new_array = [arrayx, arrayy];

end

