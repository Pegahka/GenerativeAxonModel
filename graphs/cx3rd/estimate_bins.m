function [frequency, bincenters] = estimate_bins(X) 
    binWidth = 5;
    noBins = floor(max(X)-min(X))/binWidth;
    [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);
    frequency = f_temp / (bincenters(2)-bincenters(1));
end