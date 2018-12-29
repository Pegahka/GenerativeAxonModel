function ret = kldivanalytic(mu1,mu2,std1,std2)
% analytic kl for normal / lognormal
%http://stats.stackexchange.com/questions/7440/kl-divergence-between-two-univariate-gaussians

ret = ((mu1-mu2)^2)/(2*std1) + 0.5 * (std1^2/std2^2 - 1 - log(std1) - log(std2));

end