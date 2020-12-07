% Adaline function
function [mat,iterations] = adaline(train_set, test_set, eta)
% extrac dimensions of set
d = size(cell2mat(train_set(1)),2) - 1;

% init train and test andz variable iterations
iterations = 0;

%% Training Phase

w = rand(1,d)'; %initialization weights vector randomly
%init of error to 1
err = 1;
h = waitbar(0,'Please wait...');
k = 0.9;
for i = 1:size(train_set,2)
    prev_disc_av = 0;
    norma = 1;
    waitbar(i/size(train_set,2),h)
    %while( err > 0.05 && iterations < 10000)
     while( norma > 0.0004)
        for j = 1:size(cell2mat(train_set(i)),1)
            trainTmp = cell2mat(train_set(i));
            r = trainTmp(j,1:end -1) * w;
            
            delta = (trainTmp(j,end) - r);
            dw = eta*delta*trainTmp(j,1:end - 1)';
            disc_av = k*prev_disc_av + (1-k)*dw; %exponentially discounted running average
            norma = norm(disc_av);
            w = w + dw;
            a1(j) = sign(r);
            r1(j) = r;
            
        end
        iterations = iterations +1;
        err = abs(trainTmp(:,end) - r1);
        err = mean(err,'all');
    end
end
close(h)


%% Test phase

for i = 1:size(test_set,2)
    c_mat{i} = zeros(2);
    for j = 1:size(cell2mat(test_set(i)),1)
        testTmp = cell2mat(test_set(i));
        r = testTmp(j,1:end -1) * w;
        a(j) = sign(r);
        
    end
    %c_mat{i} = confusionmat(testTmp(:,end),a);
    c_mat{i} = confusionMat(testTmp,c_mat{i},a);
    a = [];
end
%c_mat = confusionmat(testTmp(:,end),a);
mat = zeros(2,2);
for i = 1:size(c_mat,2)
    mat = mat + cell2mat(c_mat(i));
end
mat = ceil(mat/size(c_mat,2));
figure;
confusionchart(mat);

end