function  plotalphablock( x, y, dx ,dy, color)
%PLOTALHABLOCK plots an alpha block

if nargin < 5
    color = 'b';
end

p=patch([x x x+dx x+dx],[y y+dy y+dy y],color);
set(p,'FaceAlpha',0.5);

end

