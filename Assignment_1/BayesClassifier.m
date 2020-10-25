function [decision, e] =  BayesClassifier(ts_set, P_xw, P_w, arg_levNum)

%Get size of test set
[r, c] = size(ts_set);

%% Inizialization

P_wx = zeros(1,arg_levNum(c));
temp = zeros(1,c-1);
max_prob=zeros(1,r);
decision=zeros(1,r);

for o=1:r   %observation
    for k=1:arg_levNum(c)   %class
        for i=1:c-1      %variable
            temp(i)=P_xw{i}(ts_set(o,i),k);
        end
        P_wx(k)=prod(temp);
    end
    P_wx = (P_wx.*P_w);
    P_wx = P_wx / sum(P_wx);
    
    [max_prob(o), index] = max(P_wx);
    decision(o) = index;
end

%% Validation

e = sum(decision ~= ts_set(1:r,c)')/r;


end
