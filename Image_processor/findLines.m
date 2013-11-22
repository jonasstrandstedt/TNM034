function [ outlocations ] = findLines( bw )
%FINDLINES Summary of this function goes here
%   bw: input image is black and white and "straightened"
%   outlocations: a vector with y-coordinates for the staff lines

% line detection filter (notes disappear)
kernel = [ -1 -1 -1; 2 2 2; -1 -1 -1] / 9;

% get size of bw
[x y]=size(bw);


% use the line detection kernel
C = conv2(bw,kernel);
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
[peaks, locations] = findpeaks(rowsum, 'MINPEAKHEIGHT', 0.3);

%  plot(rowsum,'Color','blue');
%  hold on;
%  plot(locations,rowsum(locations),'k^','markerfacecolor',[1 0 0]);


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

