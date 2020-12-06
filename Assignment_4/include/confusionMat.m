function [c_mat] = confusionMat(testTmp,c_mat,a)
for k=1:size(testTmp,1)
    switch(testTmp(k,end))
        case 1
            if testTmp(k,end) == a(k)
                c_mat(1,1) = c_mat(1,1)+1;
            else
                c_mat(1,2) = c_mat(1,2)+1;
            end
        case -1
            if testTmp(k,end) == a(k)
                c_mat(2,2) = c_mat(2,2)+1;
            else
                c_mat(2,1) = c_mat(1,2)+1;
            end
        case 0
            if testTmp(k,end) == a(k)
                c_mat(2,2) = c_mat(2,2)+1;
            else
                c_mat(2,1) = c_mat(1,2)+1;
            end
        otherwise
            error('Something went wrong');
    end
end
end