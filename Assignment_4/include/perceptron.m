% Percpetron function
function perceptron(train_set,test_set, eta)
% extrac dimensions of set
d = size(cell2mat(train_set(1)),2) - 1;

% init train and test and variable iterations
iterations = 0;


%% Training Phase

w = rand(1,d)'; %initialization weights vector randomly
%init of error to 1
err = 1;
for i = 1:size(train_set,2)
while( err > 0.05 && iterations < 1000)
    
        for j = 1:size(cell2mat(train_set(i)),1)
            trainTmp = cell2mat(train_set(i));
            r = trainTmp(j,1:end -1) * w;
            a = sign(r);
            
            delta = 0.5 * (trainTmp(j,end) - a);
            dw = eta*delta*trainTmp(j,1:end - 1)';
            w = w + dw;
            a1(j) = a;
            
        end
        iterations = iterations +1;
        err = abs(trainTmp(:,end) - a1);
        err = mean(err,'all');
    end
end


%% Test phase

for i = 1:size(test_set,2)
    for j = 1:size(cell2mat(test_set(i)),1)
        tmpTest = cell2mat(test_set(i));
        r = tmpTest(j,1:end -1) * w;
        a(j) = sign(r);
        
    end
    c_mat{i} = confusionmat(tmpTest(:,end),a);
end
%c_mat = confusionmat(tmpTest(:,end),a);
mat = zeros(2,2);
for i = 1:size(c_mat,2)
   mat = mat + cell2mat(c_mat(i)); 
end    
mat = ceil(mat/size(c_mat,2));
confusionchart(mat);



end