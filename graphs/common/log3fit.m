function paramHat = log3fit(x)

% function log3fit
% estimates the parameters of the dislocated lognormal model by minimazing
% the weighted squared distance between the cumulative distribution functions

% Input:

% x - data set
% paramHat - the estimated parameters
    n = length(x);
    x = sort(x);
    pEmp = ((1:n)-0.5)' ./ n;
    wgt = 1 ./ sqrt(pEmp.*(1-pEmp));
    LN3obj = @(params) sum(wgt.*(logncdf(x-params(3),params(1),exp(params(2)))-pEmp).^2);
    c0 = .99*min(x);
    mu0 = mean(log(x-c0)); sigma0 = std(log(x-c0));
    paramHat = fminsearch(LN3obj,[mu0,log(sigma0),c0]);
    paramHat(2) = exp(paramHat(2));