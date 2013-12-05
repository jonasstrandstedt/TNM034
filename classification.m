function [ notes ] = classification( y_centroids, linelocations, eighths, space)
%classifies the notes


notes = '';
length = size(y_centroids,1);

counter = 1;

for i = 1:length
   if y_centroids(i) <(linelocations(1)-5*space)
           notes = strcat(notes,'E4');
   elseif y_centroids(i) <(linelocations(1)-4*space)
           notes = strcat(notes,'D4');
   elseif y_centroids(i) <(linelocations(1)-3*space)
           notes = strcat(notes,'C4');
   elseif y_centroids(i) <(linelocations(1)-2*space)
           notes = strcat(notes,'B3');
   elseif y_centroids(i) <(linelocations(1)-space)
           notes = strcat(notes,'A3');
   elseif y_centroids(i)<(linelocations(1))
           notes = strcat(notes,'G3');
   elseif y_centroids(i) <(linelocations(1)+space)
           notes = strcat(notes,'F3');
   elseif y_centroids(i) <(linelocations(2))
           notes = strcat(notes,'E3');
   elseif y_centroids(i) <(linelocations(2)+space)
           notes = strcat(notes,'D3');
   elseif y_centroids(i) <(linelocations(3))
           notes = strcat(notes,'C3');
   elseif y_centroids(i) <(linelocations(3)+space)
           notes = strcat(notes,'B2');
   elseif y_centroids(i) <(linelocations(4))
           notes = strcat(notes,'A2');
   elseif y_centroids(i)<(linelocations(4)+space)
           notes = strcat(notes,'G2');
   elseif y_centroids(i) <linelocations(5)
           notes = strcat(notes,'F2');
   elseif y_centroids(i) <(linelocations(5)+space)
           notes = strcat(notes,'E2');
   elseif y_centroids(i) <(linelocations(5)+2*space)
           notes = strcat(notes,'D2');
   elseif y_centroids(i) <(linelocations(5)+3*space)
           notes = strcat(notes,'C2');
   elseif y_centroids(i) <(linelocations(5)+4*space)
           notes = strcat(notes,'B1');
   elseif y_centroids(i) <(linelocations(5)+5*space)
           notes = strcat(notes,'A1'); 
   elseif y_centroids(i) <(linelocations(5)+6*space)
           notes = strcat(notes,'G1');
   else 
           notes = strcat(notes,'-');
   end
   
   if i == eighths(counter)
       notes(i*2-1) = lower(notes(i*2-1));
       if(counter < numel(eighths))
           counter=counter+1;
       end

   end
end

end

