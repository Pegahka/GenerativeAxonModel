function [data,ret] = divergenceresult(parameters)

    % function divergenceresult
    
    % input:
    
    % parameters: structure containing parameter values and generator
    % specific settings.
    
    % generating multiple florets
    data = generateMultipleFlorets(rmfield(parameters,'real_data'));
    
    % returning fitness value.
    ret = parameters.divergence_fn(parameters.real_data,data(:,2));    