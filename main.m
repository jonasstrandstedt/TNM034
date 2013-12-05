% Script calling the tnm034 functions

% clear the screen and environment
clc
close all
clear all

testall = false;

% add the folder helpers to the path so we can access the function
addpath helpers
addpath Image_processor

% read and process 'im1s'
im1s = imreadnorm('Images_Training/im1s.jpg');
im1s_txt = tnm034(im1s);


if testall
    expectations = {im1s_txt,'mhm','mhm','mhm','mhm'};
    ids = [1, 3, 6, 8, 10];
    testsize = size(ids);
    for i = 1:testsize(2)

        id = ids(i);
        impath = strcat('Images_Training/im',num2str(id),'s.jpg');
        outstr = strcat('Testing im',num2str(id),'s.jpg: ');
        im = imreadnorm(impath);
        teststr = tnm034(im);
        if strcmp(teststr, expectations(i))
            outstr= strcat(outstr, ' success!');
        else
            outstr= strcat(outstr, ' fail!');
        end
        disp(outstr);
    end
end



% example use of print
% txt = 'B2F5D2d1d1';
% print(txt);
% print('content', txt);
% print('content', txt, ':\n');

%print the notes
print('notes',im1s_txt,':\n');
