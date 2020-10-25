close all
clear

%Let the user decide to improve the classifier with the Laplace smoothing
mode = SetClassifierMode();

%Inizialize error vector
count = 1000;
err=zeros(1,count);

for i=1:count
%Build the sets for training and test data
[train_set, test_set,arg_levNum] = BuildSets ('Data.txt');

    if (mode == "Normal")
        %Training the Bayes classificator with a training set (no Laplace
        %smoothing)
        [P_xw, P_w] = TrainBayesClassifier(train_set, test_set, arg_levNum);
    elseif (mode == "Laplace")
        %Training the Bayes classificator with a training set (Laplace
        %smoothing)
        [P_xw, P_w] = TrainBayesClassifierLaplaceSmoothing (train_set, test_set, arg_levNum);
    end
    
    %Bayes classification operating with test set
    [decision, err(i)] = BayesClassifier(test_set, P_xw, P_w, arg_levNum);
    
    %Display the result of the classifier w.r.t. the prevision
    %result = [decision' (test_set(1:size(test_set,1),size(test_set,2)))]
    
end
average_error = sum(err)/count