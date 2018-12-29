function klresult = kldivergenceks(data1,data2)

    eps = 1.0e-7;

    infinum = min([data1; data2]);
    sup = max([data1; data2]);
    
    n = 200;            
        
    bincenters = infinum:(sup-infinum)/(n-1):sup;
        
    density1 = ksdensity(data1,bincenters)';
    density1 = density1/(sum(density1));
    
    density1_zeros = density1;
    density1(density1 == 0) = eps;
    
    
    density2 = ksdensity(data2,bincenters)';
    density2 = density2/sum(density2);
    
    density2 = (density2 + eps)/(1 + length(density2) * eps);
    
    klresult = log(density1./density2)' * density1_zeros;
end
