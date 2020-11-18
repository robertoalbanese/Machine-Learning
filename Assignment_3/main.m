%% Assignment 3 Machine Learning - Andrea Tiranti, Roberto Albanese
clc;
clear all;
close all;
%% Task1: Obtain a data set
[train_set, train_lb] = loadMNIST('train-images.idx3-ubyte');
[test_set, test_lb] = loadMNIST('t10k-images.idx3-ubyte');
%% Task2: Build k-NN classifier
k = 3;
labels = unique(train_lb);
% [classification, error] = kNNclassifier(train_set,train_lb,test_set,k,test_lb);
classification = [];
err = [];
for j = 1 :size(labels,1)
        tmpTrainlabel = train_lb;
        tmpTrainlabel(tmpTrainlabel ~= labels(j)) = 0;
        %tmpTrain_set = [train_set tmpTrainlabel];
        
        tmpTest = test_lb;
        tmpTest(tmpTest ~= labels(j)) = 0;
        tmpTest_set = [test_set tmpTest];
        for i =  1 : max(size(k))
                    [classification(:,j, i), err(i)] = kNNclassifier(train_set, test_set,tmpTrainlabel, k(i), tmpTest);
        end

end
