


gp.gen_distr = @(p1,p2) gamrnd(p1,p2);
gp.res_distr = @(p1,p2) identityFunction(p1,p2);
gp.no_florets = 500;
gp.pl_growth = 1;
gp.pl_retract = 0;
gp.growth_p1 = 1;
gp.growth_p2 = 1;
gp.retract_p1 = 0;
gp.retract_p2 = 0;
gp.resource = 1000;
gp.g_factor = 0.5;
gp.r_factor = 0;
gp.version = 2;

asymmetries = [];

bias = 0.01:0.01:1;

for param_ind = 1:100
    
    gp.bias = bias(param_ind);

    data = generateMultipleFlorets(gp);

    U = unique(data(:,3));
    asym = [];

    for k=1:length(U)
        act_floret = data(data(:,3) == U(k),1);            
        if length(act_floret) > 3 
            asym = [asym; asymmetry(act_floret)];       
        end
    end
%             
%             noBins = 50;
%             [f_temp, bincenters] = hist(asym,noBins); f_temp = f_temp/length(asym);
%             frequency = f_temp / (bincenters(2)-bincenters(1));
    if ~isempty(asym)
        asymmetries = [asymmetries; [mean(asym), bias(param_ind)]];
    end
end


