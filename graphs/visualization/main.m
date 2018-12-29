nrow = 1;
ncol = 1; 



addpath(genpath('../common/'));
addpath(genpath('../matfiles/'));

load('settings.mat');
load('gaResult.mat');

settings.gen_distr_short = settings.gen_distr;
settings.res_distr_short = settings.res_distr;
settings.res_distr = @(p1,p2,p3,p4) gamrnd(p1,p2,p3,p4);
settings.gen_distr = @(p1,p2,p3,p4) gamrnd(p1,p2,p3,p4);

%% visualization

for i=1:size(res,1)
    plot_results(i,settings,nrow,ncol);
end
