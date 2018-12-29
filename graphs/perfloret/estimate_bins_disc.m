function [freq, bincenters] = estimate_bins_disc(X)
    a = min(X); b = max(X);
    bincenters = a:b;
    
    freq = zeros(size(bincenters));
    for i=1:length(bincenters)
        freq(i) = sum(X == bincenters(i));
    end
    
    freq = freq/sum(freq);
    ind = freq == 0;
    freq(ind) = [];
    bincenters(ind) = [];
end