%% Assignment 5 Machine Learning - Tiranti Andrea, Albanese Roberto
clc;
clear all;
close all;
clearvars;
addpath('input' , 'include')
%% Task 1: Autoencoder 
% Prepare data
[train_data, train_labels] = loadMNIST(0);
labels = (unique(train_labels));
% Training Parameters
trials = 2;
hl = 1;
% Initialize vectors of pattern
X = zeros(1,trials);
Y = zeros(1,trials);
for i = 1 : trials
    while (X(i) == Y(i))
        X(i) = randi(numel(labels));
        Y(i) = randi(numel(labels));
    end
end
% Start training
figure
for j = 1 : trials
    subplot(floor(trials/2), 2, j)
    % Create a training set with only 2 classes
    train_trio = train_data(train_labels(:,1) == X(j) | train_labels(:,1) == Y(j), :);
    % Train an autoencoder on the new, reduced training set
    myAutoencoder = trainAutoencoder(train_trio', hl);
    % Encode the different classes using the encoder obtained
    myEncodedData = encode(myAutoencoder, train_trio');
    % Plot data using plotcl
    subplot(2,2,j), hold on
    plotcl(myEncodedData', train_labels(train_labels(:,1) == X(j) | train_labels(:,1) == Y(j)));
    tit = 'Comparison for classes: '  + string(X(j)) + ', ' + string(Y(j));
    title(tit)
    legend(string(X(j)), string(Y(j)));
    hold off
end




