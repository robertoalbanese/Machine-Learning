%% Task2: Build the classifier.
%% Function: k-NN classifier
function varargout = kNNclassifier(train_set,train_lb,test_set,k,test_lb)
    
    error_evaluation = true;
    % Check if the test set has the optional additional column.
    if nargin < 4
        error_evaluation = false;
    end
    % Check that the number of arguments received equals at least the number of mandatory arguments.
    if nargin < 3
        msg = 'Wrong number of input';
        error(msg)
    end
    % Check that k>0 and k<=cardinality of the training set
    if (k < 0 || k > size(train_set,2))
        msg = 'error for choosing k, must respect the cardinality of the train set';
        error(msg)
    end
    % Check if trai and set have the right dimensions.
    if size(train_set,2) - size(test_set,2) ~= 0
        msg = 'Wrong size of train and/or test set';
        error(msg)
    end

    classification = zeros(size(test_set,1),1);
    % k-NN Classifier
    for i = 1 : size(test_set,1)
        distance  = sum((train_set(:, 1 : end) - test_set(i, :)) .^ 2 , 2);
        [~,index] = mink(distance, k);
        classification(i) = mode(train_lb(index)); % Mode, or most frequent value in a sample. for vector X computes M as the sample mode, or most frequently
        %occurring value in X
    end

    varargout{1} = classification;
    % If 5 input evaluete the errore w.r.t. the test labels.
    if error_evaluation == true
        e = sum(test_lb ~= classification)/size(test_set,1);
        varargout{2} = e;
    end

end