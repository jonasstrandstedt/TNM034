function debugimage(varargin)

debug = true;

% If in debug mode and at least one argument
if debug && nargin > 0
    
    % Plot the image
    im = varargin{1};
    figure
    imshow(im)
    
    % Set the title of at least two arguments
    if nargin > 1
        title = varargin{2};
        set(gcf,'name',title,'numbertitle','off')
    end
    
    % call the extra function if there is any, 3 arguments or more
    if nargin > 2
        hold on
        
        for i = 3: nargin
            extraplotfunction = varargin{i};
            extraplotfunction();
        end
        hold off
    end
end
    
end

