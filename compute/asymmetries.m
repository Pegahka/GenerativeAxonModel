function asym = asymmetries(data,weighted)

    if exist('weighted','var')
        range = 1:2;
    else
        range = 1;
    end

    U = unique(data(:,3));
    asym = zeros(length(U),1);
    
    for i=1:length(U)
        act_floret = data(data(:,3) == U(i),range);
        asym(i) = asymmetry(act_floret);
    end

end