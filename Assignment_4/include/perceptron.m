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
    c_mat{i} = zeros(2);
    for j = 1:size(cell2mat(test_set(i)),1)
        testTmp = cell2mat(test_set(i));
        r = testTmp(j,1:end -1) * w;
        a(j) = sign(r);        
    end
    %c_mat{i} = confusionmat(testTmp(:,end),a);
%         for k=1:size(testTmp,1)
%         switch(testTmp(k,end))
%             case 1
%                 if testTmp(k,end) == a(k)
%                     c_mat{i}(1,1) = c_mat{i}(1,1)+1;
%                 else
%                     c_mat{i}(1,2) = c_mat{i}(1,2)+1;
%                 end
%             case -1
%                 if testTmp(k,end) == a(k)
%                     c_mat{i}(2,2) = c_mat{i}(2,2)+1;
%                 else
%                     c_mat{i}(2,1) = c_mat{i}(1,2)+1;
%                 end
%             otherwise
%                 error('Something went wrong');
%         end
%     end
    c_mat{i} = confusionMat(testTmp,c_mat{i},a);
    a = [];
end
%c_mat = confusionmat(testTmp(:,end),a);
mat = zeros(2,2);
for i = 1:size(c_mat,2)
    mat = mat + cell2mat(c_mat(i));
end
mat = ceil(mat/size(c_mat,2));
confusionchart(mat);

end