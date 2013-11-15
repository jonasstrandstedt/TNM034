function [ outlocations ] = findLines( gray )
%FINDLINES Summary of this function goes here
%   Detailed explanation goes here

% gauss filter
gauss =  fspecial('gaussian', 5, 0.9);

% line detection filter (notes disappear)
kernel = [ -1 -1 -1; 2 2 2; -1 -1 -1] / 9;

% make grayscale image and get size
[x y]=size(gray);

% blur the grayscale image
blurred = conv2(gray,gauss,'same');

% threshold and invert the image
Im_BW = im2bw(gray, 0.8);
Im_BW = 1-Im_BW;

% use the line detection kernel
C = conv2(Im_BW,kernel);
C = im2bw(C, 0.3);

% create black image and project the intensities to the left.
R = zeros(x,y);
rowsum = zeros(x,1);
for i=1:x
    rowsum(i) = sum(C(i,:));
    R(i,1:rowsum(i)) = ones(1, rowsum(i));
end

% normalize
rowsum = rowsum/max(rowsum);

% find the peaks of the projection (and plot to compare with original
% image)
[peaks, locations] = findpeaks(rowsum, 'MINPEAKHEIGHT', 0.4);

% plot(rowsum,'Color','blue');
% hold on;
% plot(locations,rowsum(locations),'k^','markerfacecolor',[1 0 0]);


startline = 0;
[x y] = size(locations);
peakno = zeros(x,1);
n=1;

while startline<numel(locations)-1
    linedistance = zeros(4,1);
    for i=1:4
        linedistance(i) = locations(startline+i+1) - locations(startline+i);
    end
    meandistance = (sum(linedistance))/4;
    for i=1:4
        if (linedistance(i)>meandistance-1 &&linedistance(i)<meandistance+1)
            peakno(n)=startline+i;
            n=n+1;
            if i==4
                peakno(n)=startline+5;
                n =n+1;
            end
        else
            startline = startline -4;
            break;
        end
    end
    startline = startline+5;
    
    
end

%delete the zeros from the peakindices

for i = 1:numel(peakno)
    if peakno(i) == 0
        peakno=peakno(1:i-1);
    end
end

outlocations = zeros(numel(peakno),1);

for i = 1:numel(peakno)
    outlocations(i) = locations(peakno(i));
end

end

