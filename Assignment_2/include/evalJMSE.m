function error = evalJMSE(t, y)
    error = sum((t - y).^2)/max(size(t));
end