%% Assignment 2 Machine Learning - Group Albanese Roberto, Tiranti Andrea
clc;
clear all; close all;
addpath('include'); addpath('input');
%% Task1: Get Data
[ dataset_1.set] = loadSet('double', 'turkish-se-SP500vsMSCI.csv');
[ dataset_2.set] = loadSet('double', 'mtcarsdata-4features.csv');
%% Task2: Fit a linear regression model
% 1. One-dimensional problem without intercept on the Turkish stock exchange data
w_1 = linearRegression1D(dataset_1.set);

figure;
plot(dataset_1.set(:,1), dataset_1.set(:,1) * w_1, 'k'); %linear regression whole dataset
hold on;
plot(dataset_1.set(:,1), dataset_1.set(:,2), 'or'); % whole dataset
xlabel('x');ylabel('t');title('Linear Regression for DATASET1  whole dataset')

% 2. Compare graphically the solution obtained on different random subsets (10%) of the whole data set
[dataset_1.train_set, dataset_1.test_set] = randSet(dataset_1.set, 0.10);
w_1rand = linearRegression1D(dataset_1.train_set);
figure;
plot(dataset_1.set(:,1), dataset_1.set(:,1)* w_1rand, 'r'); %linear regression 10% of the dataset
hold on
plot(dataset_1.train_set(:,1), dataset_1.train_set(:,2), '*r');%reduced dataser
hold on
plot(dataset_1.set(:,1), dataset_1.set(:,1) * w_1, 'b');%linear regression whole dataset
hold on;
plot(dataset_1.set(:,1), dataset_1.set(:,2), 'or');% whole dataset
xlabel('x');ylabel('t');title('Comparison between whole DATASET1 and a random subset of 10% of the original')

% 3. One-dimensional problem with intercept on the Motor Trends car data, using columns mpg and weight
[dataset_2.set] = loadSet('double', 'mtcarsdata-4features.csv'); %load 2nd dataset
subset = [dataset_2.set(:,end) dataset_2.set(:,1)]; % extract only 2 dimensional dataset (mpg and weight)
[w_0, w_1] = linearRegression1D(subset); %% apply the 1D linear regression
% plot results
figure;
plot(subset(:,1), subset(:,2), 'ok'); hold on;
plot(subset(:,1), w_1*subset(:,1) + w_0); hold on
%legend('Real Data', 'Linear Regression'); hold on
xlabel('weight');
ylabel('mpg');
title('1-Dimensional Linear Regression for DATASET2');
hold off

% 4. Multi-dimensional problem on the complete MTcars data, using all four columns (predict mpg with the other three columns)
dataset_2.set(:, [1 end]) = dataset_2.set(:, [end 1]); %load 2nd dataset
w_vect = linearRegression(dataset_2.set); % apply multi dimensional linear regression
prediction = [ones(size(dataset_2.set,1),1) dataset_2.set(:, 1:end-1)] * w_vect;% build the prediction matrix using weight just computed. y = X*w
%plot results
figure;
subplot(1,2,1)
scatter3(dataset_2.set(:,1), dataset_2.set(:,2), dataset_2.set(:,3), 75, prediction, 'filled');
title('Multidimensional Linear Regression for DATASET2');
xlabel('disp');ylabel('hp');zlabel('weight');
hcb1 = colorbar;
hcb1.Label.String = 'mpg';
hcb1.Label.FontSize = 12;

subplot(1,2,2)
scatter3(dataset_2.set(:,1), dataset_2.set(:,2), dataset_2.set(:,3), 75, dataset_2.set(:,4),'filled'); 
title('Real Value dataset2');
xlabel('disp');ylabel('hp');zlabel('weight');
hcb1 = colorbar;
hcb1.Label.String = 'mpg (real)';
hcb1.Label.FontSize = 12;
%% Task3: Test regression model

for i = 1 : 10
    [dataset_1.train_set, dataset_1.test_set] = randSet(dataset_1.set, 0.05);
    [dataset_2.train_set, dataset_2.test_set] = randSet(dataset_2.set, 0.25);
    %First Dataset
    w = linearRegression1D(dataset_1.train_set);
    mse_1(i,1) = evalJMSE(dataset_1.train_set(:,end), w*dataset_1.train_set(:,1));% error with 5% of the set
    mse_1(i,2) = evalJMSE(dataset_1.test_set(:,end), w*dataset_1.test_set(:,1)); %error with the 95% of the set
    %Second dataset, 1D case.
    [w_0, w_1] = linearRegression1D([dataset_2.train_set(:,1), dataset_2.train_set(:,end)]);
    
    mse_2(i,1) = evalJMSE(dataset_2.train_set(:,end),w_1 * dataset_2.train_set(:,1) + w_0);%evalute Jmse between t and y
    mse_2(i,2) = evalJMSE(dataset_2.test_set(:,end),w_1 * dataset_2.test_set(:,1) + w_0);
    
    %Second dataset, Multidimensional Case.
    
    beta = linearRegression(dataset_2.train_set);
    %beta1 = linearRegression(dataset_2.set);
    mse_3(i,1) = evalJMSE(dataset_2.train_set(:,end),[ones(size(dataset_2.train_set, 1),1) dataset_2.train_set(:, 1:end-1)] * beta);
    mse_3(i,2) = evalJMSE(dataset_2.test_set(:, end),[ones(size(dataset_2.test_set, 1),1) dataset_2.test_set(:, 1 : end -1)] * beta);
    %mse_3(i,2) = evalJMSE(dataset_2.set(:,end),[ones(size(dataset_2.set, 1),1) dataset_2.set(:, 1 : end -1)] * beta1);
end

% Print the results

l1 = strcat('Error on dataset1 5%  of the total');
l2 = strcat('Error on test dataset1 95% of the total');
l3 = strcat('Error on dataset2 25%  of the total');
l4 = strcat('Error on test dataset2 75% of the total');
l5 = strcat('Error on dataset2 25%  of the total');
l6 = strcat('Error on test dataset2 75% of the total');

figure();
subplot(3,1,1)
bar(mse_1);
xlabel('N. trial');ylabel('Mean squared error');
title('DATASET1 analysis');
legend(l1,l2)


subplot(3,1,2)
bar(mse_2);
xlabel('N. trial');ylabel('Mean squared error');
title('DATASET2 l analysis');
legend(l3,l4)

subplot(3,1,3);
bar(mse_3);
xlabel('N. trial');ylabel('Mean squared error');
title('DATASET2 multi dimensional analysis');
legend(l5,l6)


