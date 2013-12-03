function [ x, y, dx, dy ] = createsearchblock( cx, cy ,linedistance, updown, rightleft)

% init
x = 0;
y = 0;
dx = 0;
dy = 0;
updown = lower(updown);
rightleft = lower(rightleft);


% vars
heightfactor = 8;
linethickness = linedistance / 5;

% UP RIGHT
if strcmp(updown, 'up') && strcmp(rightleft, 'right') 
    x = cx;
    y = cy - 2*linedistance;
    dx = linedistance;
    dy = -heightfactor*linedistance;
end

if strcmp(updown, 'up') && strcmp(rightleft, 'left') 
% UP LEFT
    x = cx - linethickness;
    y = cy - 2*linedistance;
    dx = -linedistance;
    dy = -heightfactor*linedistance;
end


% DOWN RIGHT
if strcmp(updown, 'down') && strcmp(rightleft, 'right') 
    x = cx- linedistance;
    y = cy +2*linethickness;
    dx = linedistance;
    dy = heightfactor*linedistance;
end


if strcmp(updown, 'down') && strcmp(rightleft, 'left') 
% DOWN LEFT
    x = cx - linedistance - linethickness;
    y = cy + 3*linethickness;
    dx = -linedistance;
    dy = heightfactor*linedistance;
end

end

