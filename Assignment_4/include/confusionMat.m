%% Confusion matrix builder
function [c_mat] = confusionMat(testTmp,c_mat,a,labels)
for k=1:size(testTmp,1)
    for i=1:size(labels,1)
        for j=1:size(labels,1)
            if testTmp(k,end) == labels(i) && a(k) ==labels(j)
                c_mat(i,j) = c_mat(i,j)+1;
            end
        end
    end
end