function [data,ret] = divergenceresult(parameters)

    % function divergenceresult

    % input:
    % parameters: structure containing parameter values and generator
    % specific settings.

    % generating multiple florets
    data = generateMultipleFlorets(rmfield(parameters,'real_data'));

    if size(data) > 0
    % returning fitness value.
        ret = parameters.divergence_fn(parameters.real_data,data(:,2));
    else
        ret = 1/1.0e-7;
    end