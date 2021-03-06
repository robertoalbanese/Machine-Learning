%% Function: k-NN classifier
function varargout = kNNclassifier(train_set,train_lb,test_set,k,test_lb)

error_evaluation = true;
if nargin < 4
    error_evaluation = false;
    if nargin < 3
        msg = 'Wrong number of input';
        error(msg)
    end
end
if (k < 0 || k > size(train_set,2))
    msg = 'error for choosing k, must respect the cardinality of the train set';
    error(msg)
end
if size(train_set,2) - size(test_set,2) ~= 0
    msg = 'Wrong size of train and/or test set';
    error(msg)
end

classification = zeros(size(test_set,1),1);

for i = 1 : size(test_set,1)
    distance  = sum((train_set(:, 1 : end) - test_set(i, :)) .^ 2 , 2);
    [~,index] = mink(distance, k);
    classification(i) = mode(train_lb(index)); % Mode, or most frequent value in a sample. for vector X computes M as the sample mode, or most frequently
    %occurring value in X
end

varargout{1} = classification;


if error_evaluation == true
    e = sum(test_lb ~= classification)/size(test_set,1);
    varargout{2} = e;
end

end