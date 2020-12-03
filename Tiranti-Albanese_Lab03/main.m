%% Assignment 3 Machine Learning - Andrea Tiranti 4856315, Roberto Albanese 4234506.
clc;
clear all;
close all;
addpath('include','input');
%% Task1: Obtain a data set
[train_set, train_lb] = loadMNIST(0);
[test_set, test_lb] = loadMNIST(1);
%% Task3: Test the k-NN classifier
% Initialization phase.
k = [1:3];
labels = unique(train_lb);
classification = [];
err = [];

% Display each class of the dataset
figure;
for i = 1 : numel(labels)
    index = find(train_lb == labels(i));
    class_img = reshape(train_set(index(1), :), 28, 28);
    subplot(5,2,i)
    t = 'Label: ' + string(labels(i));
    imshow(class_img)
    title(t);
    
end
% Create temporary test set
tmp = [test_set test_lb];
tmp = randSet(tmp,15/size(test_set,1));

h = waitbar(0,'Please wait...');

% Loop for classify the test set
for j = 1 :size(labels,1)
    
    tmpTrainlabel = train_lb;
    tmpTrainlabel(tmpTrainlabel ~= labels(j)) = 0;
    
    tmpTestLabel = tmp(:,end);
    tmpTestLabel(tmpTestLabel ~= labels(j)) = 0;
    tmpTest_set = tmp(:,1:end-1);
    for i = 1:size(k,2)
        [classification(:,j,i), err(j,i)] = kNNclassifier(train_set, tmpTrainlabel, tmpTest_set, k(i), tmpTestLabel);
    end
    waitbar(j/size(labels,1))
end
% Save results
result_title = ["labels" ,"error k1","error k2","error k3"];
result = [result_title ; labels err];
% Evaluation of the average error for all labels and all values of k.
for i = 1:size(k,2)
    averageError(i) = sum(err(:,i))/size(err,1);
end
close(h)
% Display results.
disp(result);
averageError
