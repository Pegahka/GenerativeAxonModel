function data = generateMultipleFlorets(parameters)

    % function generateMultipleFlorets
    
    % input: 
    
    % parameters: structure containing parameter values and generator
    % specific settings.
    
    % output:
    
    % data: 
    
    % n x 3 matrix, containing no_florets number of concatenated florets
    % 1st column: depth, 2nd column: length, 3rd colum: Floret ID
    
    data = [];
    
    gp = parameters;
   
    % checking if 2 parameter distribution is used for resource instead of
    % fixed resource value.
    
    if isfield(parameters,'r_shape')
        gp = rmfield(gp,'r_shape');
        gp = rmfield(gp,'r_scale');
    end
    
    res_distr = eval(gp.res_distr);

    for i = 1: parameters.no_florets
        
        % sampling resource from a prespecified 2 parameter distribution if
        % necessary. 1 resource value per floret is sampled.
        
        if isfield(parameters,'r_shape')
            gp.resource = res_distr(parameters.r_shape, parameters.r_scale);
        end
        
        % generating florets
        
        generated_data = generateFloret(gp); %generate Floret generates one floret with depth and segment length information. 
        generated_data = [generated_data, i * ones(size(generated_data,1),1)]; %Floret ID is added to these
        data = [data; generated_data]; % and multiple florets are concatenated in 'data' matrix 
    end