function dummy = BayesClassifier (tr_set, test_set)

    if (size(test_set, 2) < (size(tr_set, 2)-1))
       error('Data set dimensions not valid');
    end
    
    if (~isempty(find(tr_set<1, 1)) || ~isempty(find(test_set<1, 1)))
        error("Some data in the datasets is <1");
    end
    
end