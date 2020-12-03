% Percpetron function
function [train_set, test_set] = perceptron(set, eta, k)
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

        w = rand(1,d)'; %initialization weights vector randomly
        %init of error to 1
        err = 1;
        while( err > 0.05 && iterations < 10000)
            for j = 1:size(train_set,1) 
                    r = train_set(j,1:end -1) * w;
                    a = sign(r);

                    delta = 0.5 * (train_set(j,end) - a);
                    dw = eta*delta*train_set(j,1:end - 1)';
                    w = w + dw;
                    a1(j) = a;
         
            end
            iterations = iterations +1;
            err = abs(train_set(:,end) - a1);
            err = mean(err,'all');
         end
    end
    if k == n % k = n perform leave one out cross validation
        for i = 1 : n 
            % Remove xl from set for n times
            set_xl = set;
            xl_idx = i;
            set_xl(xl_idx,:) = [];
            % Train machine Ml
            w = rand(1,d)'; %initialization weights vector randomly
            %init of error vector to 1
            err = 1;
            iterations = 0;
            while( err > 0.06 && iterations < 10000)
                for j = 1:size(set_xl,1) 
                    r = set_xl(j,1:end-1) * w;
                    a = sign(r);

                    delta = 0.5 * (set_xl(j,end) - a);
                    dw = eta*delta*set_xl(j,1:end-1)';
                    w = w + dw;
                    %e = set_xl(j,end) - a;
                    a1(j) = a;

                end
               iterations = iterations + 1;
               err = abs(set_xl(:,end) - a1);
               err = mean(err,'all');
            end
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