addpath(genpath('../../common'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% analytic vs estimated %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%http://stats.stackexchange.com/questions/7440/kl-divergence-between-two-univariate-gaussians

mu1 = 3; std1 = 1;
mu2 = 4; std2 = 1;


n = 100;
div_res = zeros(n,1);
div_res_log = zeros(n,1);
for i=1:n
    x = lognrnd(mu1,std1,100 * i,1);
    y = lognrnd(mu2,std2,100 * i,1);
    div_res_log(i) = kldivergence(log(x),log(y));
    div_res(i) = kldivergence(x,y);
end


div_result_a = kldivanalytic(mu1,mu2,std1,std2);

plot([1, n], [div_result_a, div_result_a],'g');
hold on;
plot(div_res,'b');
plot(div_res_log,'r');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% real data vs fitted dist %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% gen  data vs fitted dist %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%