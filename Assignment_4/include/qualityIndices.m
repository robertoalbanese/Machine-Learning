function [accuracy,err_freq,sensitivity,specificity,F_measure] = qualityIndices(C,n)

accuracy=trace(C)/n;
err_freq=(n-trace(C))/n;
sensitivity=C(2,2)/(C(2,2)+C(2,1));
specificity=C(1,1)/(C(1,1)+C(1,2));
false_positive_rate = 1 - specificity;
precision=C(2,2)/(C(2,2)+C(1,2));
recall=C(2,2)/(C(2,2)+C(2,1));
F_measure=2*(precision*recall)/(precision+recall);
end