% Adaline function
function [train_set, test_set] = adaline(set, eta, k)
    % extrac dimensions of set
    n = size(set,1);
    d = size(set,2) - 1;
    % randomize set
    idx = randperm(n);
    set = set(idx,:);
    % init train and test and variable iterations
    train_set = [];
    test_set = [];
    iterations = 0;
    % Check if k is consistency 
    if (k < 2 || k > n)
        msg = ('k < 2 or k > n(size set)');
        error(msg);
    end
    
    %% Training Phase
    if k == 2
        train_set = set(1:(size(set,1))/2,:);
        test_set = set((size(set,1)/2)+1 : end , :);

        w = zeros(1,d)'; %initialization weights vector randomly
        %init of error to 1
        err = 1;
        while(err > 0.05 && iterations < 10000)
            for j = 1:size(train_set,1) 
                    r = train_set(j,1:end -1) * w;
                    delta = (train_set(j,end) - r);
                    dw = eta*delta*train_set(j,1:end - 1)';
                    w = w + dw;
                    
                    a(j) = sign(r);
            end
            iterations = iterations +1;
            err = immse(train_set(:,end),a');
        end
    end
    
    %% Test phase
    
    for j = 1:size(test_set,1) 
                    r = test_set(j,1:end -1) * w;
                    a(j) = sign(r);
                    
    end
    c_mat = confusionmat(test_set(:,end),a);
    confusionchart(c_mat);  
    
end