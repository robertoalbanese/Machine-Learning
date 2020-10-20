close all 
clear

%Build the sets for training and test data
[train_set, test_set,arg] = BuildSets ('Data.txt');

%Training the Bayes classificator with a training set
[P_xw, P_w] = TrainBayesClassifier(train_set, test_set, arg);

%Bayesclassifies operating with test set
[P_wx,decision] = BayesClassifier(test_set, P_xw, P_w, arg);