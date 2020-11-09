function w = linearRegression(set)

if min(size(set)) <  2
    msg = 'Wrong size of dataset, must be nxm, with m >= 2';
    error(msg) 
end

X = [ones(size(set,1),1) set(:, 1:end-1)];
t = set(:, end);

w = pinv(X)*t;
end