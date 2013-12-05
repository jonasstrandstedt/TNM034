function [ notes ] = classification( y_centroids, linelocations, eighths, centroid_to_remove, space)
%classifies the notes


notes = '';
length = size(y_centroids,1);

counter = 1;

for i = 1:length
    if ~isempty(find(i == centroid_to_remove, 1))
        continue;
    end
    note = '-';
    if y_centroids(i) <(linelocations(1)-5*space)
        note = 'E4';
        %notes = strcat(notes,'E4');
    elseif y_centroids(i) <(linelocations(1)-4*space)
        note = 'D4';
%            notes = strcat(notes,'D4');
    elseif y_centroids(i) <(linelocations(1)-3*space)
        note = 'C4';
%            notes = strcat(notes,'C4');
    elseif y_centroids(i) <(linelocations(1)-2*space)
        note = 'B3';
%            notes = strcat(notes,'B3');
    elseif y_centroids(i) <(linelocations(1)-space)
        note = 'A3';
%            notes = strcat(notes,'A3');
    elseif y_centroids(i)<(linelocations(1))
        note = 'G3';
%            notes = strcat(notes,'G3');
    elseif y_centroids(i) <(linelocations(1)+space)
        note = 'F3';
%            notes = strcat(notes,'F3');
    elseif y_centroids(i) <(linelocations(2))
        note = 'E3';
%            notes = strcat(notes,'E3');
    elseif y_centroids(i) <(linelocations(2)+space)
        note = 'D3';
%            notes = strcat(notes,'D3');
    elseif y_centroids(i) <(linelocations(3))
        note = 'C3';
%            notes = strcat(notes,'C3');
    elseif y_centroids(i) <(linelocations(3)+space)
        note = 'B2';
%            notes = strcat(notes,'B2');
    elseif y_centroids(i) <(linelocations(4))
        note = 'A2';
%            notes = strcat(notes,'A2');
    elseif y_centroids(i)<(linelocations(4)+space)
        note = 'G2';
%            notes = strcat(notes,'G2');
    elseif y_centroids(i) <linelocations(5)
        note = 'F2';
%            notes = strcat(notes,'F2');
    elseif y_centroids(i) <(linelocations(5)+space)
        note = 'E2';
%            notes = strcat(notes,'E2');
    elseif y_centroids(i) <(linelocations(5)+2*space)
        note = 'D2';
%            notes = strcat(notes,'D2');
    elseif y_centroids(i) <(linelocations(5)+3*space)
        note = 'C2';
%            notes = strcat(notes,'C2');
    elseif y_centroids(i) <(linelocations(5)+4*space)
        note = 'B1';
%            notes = strcat(notes,'B1');
    elseif y_centroids(i) <(linelocations(5)+5*space)
        note = 'A1';
%            notes = strcat(notes,'A1'); 
    elseif y_centroids(i) <(linelocations(5)+6*space)
        note = 'G1';
%            notes = strcat(notes,'G1');
    end
    
    if ~isempty(find(i == eighths, 1))
        note = lower(note);
    end
    
    notes = strcat(notes,note);

%     if i == eighths(counter)
%        notes(i*2-1) = lower(notes(i*2-1));
%        if(counter < numel(eighths))
%            counter=counter+1;
%        end
% 
%     end
end

end

