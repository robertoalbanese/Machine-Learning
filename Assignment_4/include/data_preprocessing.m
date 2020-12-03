function [train_set,test_set,ts_label,dataset] = data_preprocessing
% Load the dataset
dataset = load('iris_set.txt');% Multivariate, supervised.
[row,col] = size(dataset); 
indexes = randperm(length(row)); % create random indexes
% Create a randome dataset where we'll extract 2 rndm set (train and test)
random_set = dataset(randperm(row),:);
train_set = random_set(1:10,:);
test_set = random_set(11:14,1:4);
% Save apart the label of the train set for evaluete the error 
ts_label = random_set(11:14,5);
% Checking if the data set is consistence and with the appropiate
% dimensions.
[n,d] = size(train_set);
[m,c] = size(test_set);
if (c < (d-1))
    msg = 'Wrong dimensions of train and/or test set';
    error(msg);
    return;
end
for i = 1:size(dataset,1)
    for j = 1:size(dataset,2)
        if (dataset(i,j) < 1)
            msg = 'inconsistent data set values (< 1)';
            error(msg);
            return;
        end 
    end
end
end

