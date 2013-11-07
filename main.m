% Script calling the tnm034 functions

clc
clear all
addpath helpers

A = imreadnorm('Images_Training/im1s.jpg');
img1_txt = tnm034(A);

print('img1_txt', img1_txt);
print(img1_txt);
print('img1_txt', img1_txt, ':\n');