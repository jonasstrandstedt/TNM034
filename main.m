% Script calling the tnm034 functions


%% Preparations
% clear the screen and environment
clc
close all
clear all
% add the folder helpers to the path so we can access the function
addpath helpers
addpath Image_processor

%% Settings
ids = [1, 3, 5, 6, 8, 9, 10];
%ids = [1];

%% Test run
expectations = {
    'ng3e3f3e3g2e3f3a2b2C3c3g3e3f3e3g2e3nf3a2b2C3c3e2g2g2f2a2A2d3d3g2e3c3nf3d3g3a2b2C3c3C3c3',...
    'nG3g3a3G3E3e3f3E3D3d3e3d3b2c3d3e3f3G3nG3g3a3G3D3g3a3B3C4E3F3E3nc3c3c3d3e3d3c3d3E3C3d3d3d3e3f3e3d3e3F3D3ne3f3G3f3e3f3e3g3A3g3f3g3a3B3a3g3C4C4',...
    'nd3b2d3g3d3b2d3b2g2f2a2d2f2a2c3e3c2a2f2d2f2g2d2g2b2d3b2g3d3b2d3b2g2nf2a2d2f2a2c3e3c3a2f2b2f2G2a2d3f3c3e3a3c3e3c3d3f3a2d3f3d3ne3g3e3c3a3c3d3f3a3e3b3a3c3e3a2c3e3c3d3f3a2d3f3d3e3g3e3g3e3c3D3',...
    'nG2g2G2G2F2G2F2G2nE2g2G2G2F2G2nG2g2G2G2F2G2F2A2nG2g2G2G2F2G2nD2C3b2a2B2C3nA2G2F2F2nD2C3b2a2B2C3nA2G2F2G2F2A2',...
    'nC2F2A2F2b2a2g2f2E2G2C2E2nC2F2A2F2b2a2g2f2E2G2C2E2nA2a2a2A2A2B2a2a2G2g2g2G2f2f2E2F2nA2a2a2A2A2B2A2G2G2F2E2',...
    'saknas',...
    'nC3A3c3e3G3f3a3B3f3g3A3a3G3e3f3D3e3c3nC3f3D3D3f3g3B3g3f3E3g3b3C4a3g3nF3e3d3E3d3c3D3c3b2C3a3c3F3d3C3e3f3F3E3nC3A3c3e3G3f3a3B3f3g3A3a3G3e3f3D3e3c3nC3A3e3e3G3f3a3B3f3g3A3a3G3e3f3D3e3c3nf3g3f3E3g3b3C4a3g3F3e3b3E3d3c3nD3c3B3C3c3F3d3C3F3E3'};
result = expectations;

testsize = size(ids);
for i = 1:testsize(2)

    id = ids(i);
    impath = strcat('Images_Training/im',num2str(id),'s.jpg');
    outstr = strcat('Testing im',num2str(id),'s.jpg: ');
    im = imreadnorm(impath);
    teststr = tnm034(im);
    expstr = char(expectations(i));
    sizeteststr = size(teststr);
    sizeexpectations = size(expstr);
    result(i) = {teststr};

    if strcmp(teststr, expstr)
        outstr= strcat(outstr, ' success!');
    else
        if strcmpi(teststr, expstr)
            outstr = strcat(outstr, ' right notes but wrong case!');
        else
            for j = 1:min(sizeteststr(2),sizeexpectations(2))
                if strcmp(teststr(j), expstr(j)) == 0
                    if strcmpi(teststr(j), expstr(j)) == 0
                        outstr = strcat(outstr, ' FAIL[',num2str(j),']');
                        break;
                    else
                        outstr = strcat(outstr, ' [',num2str(j),']');
                    end

                end

            end

        end
    end
    percentmatch = 0;
    for j = 1:min(sizeteststr(2),sizeexpectations(2))
        if strcmp(teststr(j), expstr(j)) == 1
            percentmatch = percentmatch +1;
        end
    end
    outstr = [outstr, ' [',num2str(percentmatch),'/',num2str(sizeexpectations(2)),']']; 
    disp(outstr);
end
for i = 1:testsize(2)
    id = ids(i);
    resstr = strcat('result(im',num2str(id),'s.jpg)');
    expstr = strcat('expres(im',num2str(id),'s.jpg)');
    print(resstr, char(result(i)));
    print(expstr, char(expectations(i)));
end

