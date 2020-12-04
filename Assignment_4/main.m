%% Lab03 Machine Learning - Tiranti Andrea, Albanese Roberto
%% Task 1: Program two one-unit neural networks
clc;
close all;
clear all;

addpath('include','inputs');
% Load dataset 
% [train_set, train_lb] = loadMNIST(0);
% [test_set, test_lb] = loadMNIST(1);
%[train_set2, test_set2, test_label2, dataset] = data_preprocessing
dataset = load('iris_set.txt');
n = size(dataset,1);
eta2 = 0.0005; %used for Adaline algorithm
eta1 = 2; %used for Perceptron algorithm
k1 = n;
k2 = 2;
[train_set, test_set] = partition(dataset,k1);
perceptron(train_set,train_set, eta1);
%adaline(train_set, test_set, eta2);
