%% Lab03 Machine Learning - Tiranti Andrea, Albanese Roberto
%% Task 1: Program two one-unit neural networks
clc;
close all;
clear all;

addpath('include','inputs');

%% Load dataset
% [train_set, train_lb] = loadMNIST(0);
% [test_set, test_lb] = loadMNIST(1);
% dataset = [ train_set   train_lb;
%             test_set    test_lb ];
% dataset = randSet(dataset,10/size(dataset,1));

dataset = load('iris_set.txt');
dataset_xor = load('xor_set.txt');

labels = unique(dataset(:,end));
labels_xor = unique(dataset_xor(:,end));
n = size(dataset,1);
n_xor = size(dataset_xor,1);
eta2 = 0.0005; %used for Adaline algorithm
eta1 = 2; %used for Perceptron algorithm

k1 = n;
k2 = 2;
k3 = 6;

%% Learning phase and Confusion matrix computation for iris/MNIST dataset
[train_set, test_set] = partition(dataset,k3);
% [c_mat_per,iterations] = perceptron(train_set,test_set, eta1,labels);
[c_mat_ad, iterations] = adaline(train_set, test_set, eta2,labels);
%[accuracy,err_freq,sensitivity,specificity,F_measure]  = qualityIndices(c_mat_per,n);

%% Learning phase and Confusion matrix computation for xor dataset
% [train_set_xor, test_set_xor] = partition(dataset_xor,k2);
% [c_mat_per_xor, iterations] = perceptron(train_set_xor,test_set_xor, eta1,labels_xor);
% [c_mat_ad_xor, iterations] = adaline(train_set_xor, test_set_xor, eta2,labels_xor);

%[accuracy_xor,err_freq_xor,sensitivity_xor,specificity_xor,F_measure_xor]  = qualityIndices(c_mat_per_xor,n_xor);
