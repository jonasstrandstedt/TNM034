function [staff] = staffDivision(bw)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


% gauss filter
gauss =  fspecial('gaussian', 5, 0.9);

% line detection filter (notes disappear)
kernel = [ -1 -1 -1; 2 2 2; -1 -1 -1] / 9;

% make grayscale image and get size
grayscale = rgb2gray(bw);
[x y]=size(grayscale);

% blur the grayscale image
blurred = conv2(grayscale,gauss,'same');

% threshold and invert the image
Im_BW = im2bw(grayscale, 0.8);
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

%plot(rowsum,'Color','blue');
%hold on;
%plot(locations,rowsum(locations),'k^','markerfacecolor',[1 0 0]);

sizebw = size(bw);
sx = sizebw(1);
sy = sizebw(2);


startline = 0;
peakno = zeros(size(locations),1);
locsize = size(locations);
locx = locsize(1);
n=1;

while startline<locx-1
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

% calculate the cut distance, for cropping the first staff from the
% original image

for i = 1:size(peakno)
    if peakno(i) == 0
        peakno=peakno(1:i-1);
    end
end

ps = size(peakno);
n = ps(1)/5;

for i = 1:n-1
    cutdistance(i)= (locations(peakno(i*5+1))+locations(peakno(i*5)))/2;

end

%lull is the empty space over and under the staffs
lull = cutdistance(1) - locations(5);

finalcut(1) = locations(1)-lull;

for i = 1:n-1
    finalcut(i+1) = cutdistance(i);
end
finalcut(n+1) = locations(n*5) + lull;
    

sx = finalcut(2)-finalcut(1)+30;
staff = ones(sx,sy,n);
size(staff);

% crop off the staffs
for i = 1:n
    h= finalcut(i+1) - finalcut(i);
    staff(1:h,1:sy,i) = bw(finalcut(i)+1:finalcut(i+1),1:sy);
end

end

