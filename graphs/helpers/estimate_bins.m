function [frequency, bincenters] = estimate_bins(X, noBins) 
            
    if ~exist('noBins','var')
        noBins = 30;
    end

    [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);    
    frequency = f_temp / (bincenters(2)-bincenters(1));
end