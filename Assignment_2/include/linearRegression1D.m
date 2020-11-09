function varargout = linearRegression1D(set)
if min(size(set)) ~= 2
    msg = 'Wrong size of dataset, must be nx2';
    error(msg)
end
    x = set(:,1);
    t = set(:,2);
    
    if nargout == 1
        
        [row, ~] = find(set == 0);
        
        x(row) = [];
        t(row) = [];
        
        w_1 = sum(x .* t)/ sum(x.^2);
        varargout{1} = w_1;
        
    elseif nargout == 2
        x_bar = mean(set(:,1));
        t_bar = mean(set(:,2));
        
        w_1 = sum((x - x_bar).* (t - t_bar))/ sum((x - x_bar).^2);
        w_0 = t_bar - w_1 * x_bar;
        
        varargout{1} = w_0;
        varargout{2} = w_1;
        
    elseif nargout > 2
        msg = 'Too many output argument';
        error(msg);
    end
    

end