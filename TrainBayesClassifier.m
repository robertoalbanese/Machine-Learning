function [P_xw, P_w]= TrainBayesClassifier (tr_set, test_set, arg_levNum)
%% Dimensional check

%Check if dimension of sets are correct (columns of test set at least equal
%to column of training set - 1
if (size(test_set, 2) < (size(tr_set, 2)-1))
    error('Data set dimensions not valid');
end

%Check that no entry in any of the two data sets is <1
if (~isempty(find(tr_set<1, 1)) || ~isempty(find(test_set<1, 1)))
    error("Some data in the datasets is <1");
end

%% Inizialization

%Get size of training set
[r, c] = size(tr_set);

% N_w (k) = occurrencies of clasess in the observations
% k = classes
N_w = zeros(1:arg_levNum(c));

% P_wx {i}(j;k) =    vectors of matrices containing the probabilities of each
%                   level of the attributes
% i = attributes
% j = levels
% k = classes

% N_t {i}(j;k) = occurrencies of each level of each attributes on each class
% i = attributes
% j = levels
% k = classes

for i=1:c     %variable
    for j=1:arg_levNum(i)   %variable level
        for k=1:arg_levNum(c)    %class
            P_xw{i}=zeros(j,k);
            N_t{i}=zeros(j,k);
        end
    end
end

%% Evaluation of N_w and N_t

for o=1:r   %observation
    for k=1:arg_levNum(c)    %class
        if ((tr_set(o,c)==k))
            N_w(k)= N_w(k) +1; %Evaluating N_w
        end
        for i=1:c-1      %variable
            for j=1:arg_levNum(i)   %variable level
                if((tr_set(o,i)== j && tr_set(o,c)== k))
                    N_t{i}(j,k) = N_t{i}(j,k) + 1;  %Evaluating N_t
                end
            end
        end
    end
end

%% Evaluation of P_xw

for i=1:c     %variable
    for j=1:arg_levNum(i)   %variable level
        for k=1:arg_levNum(c)    %class
            P_xw{i}(j,k) = N_t{i}(j,k)/N_w(k);
        end
    end
end

%% Evaluation of P_w
P_w = N_w / r;

end