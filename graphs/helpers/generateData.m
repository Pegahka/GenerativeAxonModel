function gen_data_res = generateData(divergence, param_ind)

    addpath(genpath('../common/'));
    addpath(genpath('../matfiles/'));

    load('settings.mat');
    load('gaResult.mat');             

    gaResult = res{divergence,1};


    gp.version = settings.generator_version;    
    gp.gen_distr = settings.gen_distr;
    gp.no_florets = 500;

    for i = 1:settings.no_params 
        gp.(settings.params{i,1}) = gaResult(param_ind,i);
    end                        

    if gp.r_scale > 0

        gp.res_distr = @(p1,p2) gamrnd(p1,p2);
    else

        gp.res_distr = @(p1,p2) identityFunction(p1,p2);
    end

    gen_data_res = generateMultipleFlorets(gp);
end
