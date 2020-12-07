%% Cross-validation partitioning

% if k=2            -> simple cross validation
% if 2<k<n          -> k-fold cross validation
% if k=n            -> leave-one-out cross validation
% if k<2 or k>n     -> error

function [train_set, test_set] = partition(set,k,cond)

n=size(set,1);
% Check if k is consistency
if (k < 2 || k > n)
    msg = ('k < 2 or k > n(size set)');
    error(msg);
end
%condition for randomizing the dataset
if cond == 0
    % randomize the set
    idx = randperm(n);
    set = set(idx,:);
else
end

if k == 2
    trainTmp = set;
    testTmp = set((size(set,1)/2)+1:end,:);
    trainTmp((size(set,1)/2)+1:end,:) = [];
    test_set{1}= testTmp;
    train_set{1} = trainTmp;
end

if k>2 && k<=(n/2)
    for i = 1 : k
        % Remove xl from set for n times
        trainTmp = set;
        testTmp = set(round(1+(((i-1)*n)/k)):min(floor((i*n)/k),n),:);
        trainTmp(round(1+(((i-1)*n)/k)):min(floor((i*n)/k),n),:) = [];
        test_set{i}= testTmp;
        train_set{i} = trainTmp;
    end
end
if k>(n/2)
    for i = 1 : k
        % Remove xl from set for n times
        trainTmp = set;
        testTmp = set(round(1+(((i-1)*n)/k)):min(floor(1+(((i-1)*n)/k))+rem(n,k),n),:);
        trainTmp(round(1+(((i-1)*n)/k)):min(floor(1+(((i-1)*n)/k))+rem(n,k),n),:) = [];
        test_set{i}= testTmp;
        train_set{i} = trainTmp;
    end
end