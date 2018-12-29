directories = dir('./plots');
asymmetries = [];

for i=1:length(directories)
    
    if strcmp(directories(i).name,'.') || strcmp(directories(i).name, '..') || strcmp(directories(i).name(1),'.')
        continue;
    end
    
    addpath(['./plots/' directories(i).name]);
    
    load('gaResult.mat');
    load('settings.mat');
    
    for ii=1:3
        gaResultTmp = res{ii};

        gaResult = zeros(size(res{1}{1}));

        for j=1:length(gaResultTmp)
            gaResult(j,:) = gaResultTmp{j};
        end

        gp.version = settings.generator_version;
        gp.gen_distr = @(p1,p2) gamrnd(p1,p2);
        
        
        gp.no_florets = 500;
        
        for param_ind = 1:size(gaResult,1)
            for k = 1:settings.no_params 
                gp.(settings.params{k,1}) = gaResult(param_ind,k);
            end
            
            if gp.r_shape == 0
                gp.res_distr = @(p1,p2) identityFunction(p1,p2);
            else
                gp.res_distr = @(p1,p2) gamrnd(p1,p2);
            end

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
                asymmetries = [asymmetries; [mean(asym), gaResult(end)]];
            end
        end

    end
   
    rmpath(['./plots/' directories(i).name]);
    clear('res','settings','gaResultTmp','gaResult');
end 

plot(asymmetries(:,2),asymmetries(:,1),'.');
xlabel('bias'); ylabel('asymmetry');
title('Relation between asymmetry (mean) and bias');
