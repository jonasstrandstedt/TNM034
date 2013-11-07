% Script calling the tnm034 functions

% clear the screen and environment
clc
close all
clear all

% add the folder helpers to the path so we can access the function
addpath helpers

% read and process 'im1s'
im1s = imreadnorm('Images_Training/im1s.jpg');
im1s_txt = tnm034(im1s);

% example use of print
txt = 'B2F5D2d1d1';
print(txt);
print('content', txt);
print('content', txt, ':\n');
