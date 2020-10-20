close all
clear

%Let the user decide to improve the classifier with the Laplace smoothing
mode = SetClassifierMode();

%Build the sets for training and test data
[train_set, test_set,arg_levNum] = BuildSets ('Data.txt');

if (mode == "Normal")
    %Training the Bayes classificator with a training set
    [P_xw, P_w] = TrainBayesClassifier(train_set, test_set, arg_levNum);
elseif (mode == "Laplace")
    [P_xw, P_w] = TrainBayesClassifierLaplaceSmoothing (train_set, test_set, arg_levNum);
end

%Bayesclassifies operating with test set
[decision, err] = BayesClassifier(test_set, P_xw, P_w, arg_levNum);
