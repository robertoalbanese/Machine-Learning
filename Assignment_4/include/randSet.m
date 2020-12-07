function [orig_set, reduced_set] = randSet(set, ratio)
%Get a random subset of a given set of a ginven percentage on the input
%set.
%Take as input:
%-the set in which element are
%-the ration between the whole set and the random subset

%Give as output:
%-the subset, called training set ---> RANDOM SET 


possible_values = size(set,1);
subset = (1:size(set,1));
    
random_rows = subset(randperm(possible_values, round(size(set,1) * ratio)));
rows = (1:size(set,1));
rows(random_rows) = [];

orig_set = set(random_rows, :);
reduced_set = set(rows, 1:end-1);
ts_label = set(rows, end);

reduced_set = [reduced_set ts_label];


end