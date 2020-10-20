function [train_set, test_set,arg] = BuildSets (address)
%% Error ceck

%Check if file address exists
if (exist(address,'file')==0)
    error('File %s does not exists', address);
end

%% Import data form file to the structure data
%   \For the purpose of this exercise data mast be integers separater by
%   commas
%
%   data -  data            integer data
%           textdata        text data
%           colheaders      headers of the columns

data = importdata('Data.txt');
[ n, m ] = size(data.data);
arg.N = 0;

%% Initialization and Evaluation of structure arg
%   arg -  N               number of different attributes
%          N_lev(i)        amount of different level for each attribute
%                           i = attributes
%


%count how many levels in a Attribute
for i=1:m
    arg.N = arg.N + 1;
    arg.N_lev(i) = max(unique(data.data(:,i)));
end

k = randperm(n);
train_set = data.data(k(1:(n-round(n*0.3))),:);
test_set = data.data(k(n-round(n*0.3)+1:n),:);
end