function [train_set, test_set] = partition(set,k)

n=size(set,1);
% Check if k is consistency 
if (k < 2 || k > n)
        msg = ('k < 2 or k > n(size set)');
        error(msg);
end
% randomize the set
idx = randperm(n);
set = set(idx,:);

if k == 2
trainTmp = set;
testTmp = set((size(set,1)/2)+1:end,:);
trainTmp((size(set,1)/2)+1:end,:) = [];
end
if 2<k<=(n/2)
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