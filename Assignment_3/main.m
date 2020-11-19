%% Assignment 3 Machine Learning - Andrea Tiranti, Roberto Albanese
clc;
clear all;
close all;
%% Task1: Obtain a data set
[train_set, train_lb] = loadMNIST(0);
[test_set, test_lb] = loadMNIST(1);
%% Task2: Build k-NN classifier
k = [1:3];
labels = unique(train_lb);
% [classification, error] = kNNclassifier(train_set,train_lb,test_set,k,test_lb);
classification = [];
err = [];

tmp = [test_set test_lb];
tmp = randSet(tmp,15/size(test_set,1));

h = waitbar(0,'Please wait...');

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

for i = 1:size(k,2)
    averageError(i) = sum(err(:,i))/size(err,1);
end
close(h)
