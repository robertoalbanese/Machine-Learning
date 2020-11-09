function [set] = loadSet(expected_type, varargin)
%Function to read a dataset from a csv file. 
%Take as input:
%-expected type (e.g. 'string', 'double', ...) 
%-The name of the dataset
%Give as optput:

%-the set, saved as a a matrix of the type chosen.

if numel(varargin) == 0
    pattern = fullfile('input', '*.csv');
    name = uigetfile(pattern, 'Select a dataset:');
    
elseif numel(varargin) == 1
    name = varargin{1};
else
    msg = 'Too many argument, must be 1 or 2';
    error(msg)
end


mat_name = fullfile('input',[name(1:end-3), 'mat']);


a = load(mat_name); 
set = a.set;

if ~strcmp(expected_type, 'string') && ~strcmp(expected_type, 'char')
    set = removeNan(set);
end
end

function setB = removeNan(setA)
[~, col] = find(isnan(setA));
setA(:, unique(col)) = [];
setB = setA;
end