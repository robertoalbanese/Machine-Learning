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
%eta = 0.0005;
eta = 2;
k = 150;
[train_set, test_set] = perceptron(dataset, eta, k);
%[train_set, test_set] = adaline(dataset, eta, k);
