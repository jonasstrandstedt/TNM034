function print(varargin)
%print Prints formatted text
%   Usage: print(text);
%   Usage: print(key, text);
%   Usage: print(key, text, separator);

key = '';
sep = '';
txt = '';
switch nargin
    case 3
        key = varargin{1};
        sep = sprintf(varargin{3});
        txt = varargin{2};
    case 2
        key = varargin{1};
        sep = ': ';
        txt = varargin{2};
    case 1
        key = '';
        sep = '';
        txt = varargin{1};
    otherwise
        key = '';
        sep = '';
        txt = '';
end
    
str = [key, sep, txt];
disp(str);

end

