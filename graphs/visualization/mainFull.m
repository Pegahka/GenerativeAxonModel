noPlots = no_plots_given;
noPlotsRoot = ceil(sqrt(noPlots));
addpath(genpath('../common/'));
addpath(genpath('../matfiles/'));

load('settings.mat');
load('gaResultFull.mat');
% 
% settings.gen_distr_short = settings.gen_distr;
% settings.res_distr_short = settings.res_distr;
% settings.res_distr = @(p1,p2,p3,p4) gamrnd(p1,p2,p3,p4);
% settings.gen_distr = @(p1,p2,p3,p4) gamrnd(p1,p2,p3,p4);


settings.gen_distr_short = settings.gen_distr;
settings.res_distr_short = settings.res_distr;
settings.res_distr = @(p1,p2,p3,p4) unifrnd(p1,p2,p3,p4);
settings.gen_distr = @(p1,p2,p3,p4) unifrnd(p1,p2,p3,p4);

%% visualization

divFilter = [1 1 1];
popFilter = {1:noPlots,1:noPlots,1:noPlots};

%divId = {'kl';'klrev';'js'};
%divName = {'KL';'KL reversed';'JS'};
%divFun = {'@(x,y) kldivergence(x,y)';'@(x,y) kldivergence(y,x)'; ...
%    '@(x,y) shannonjensen(x,y)'};
divId = {'js'};
divName = {'JS'};
divFun = {'@(x,y) shannonjensen(x,y)'};


for i = 1:length(divId)    
    if (divFilter(i))
%        full_result = results_full.(divId{i}){1};
        full_result = results_full.(divId{i});

        [scores, indices] = sort(full_result.scores,'ascend');
        population = full_result.population(indices,:);


        [plot_data_gen_visualisation{resSetList_ordered}, plot_data_real_visualisation{resSetList_ordered},gen_data]=plotNSets(settings,population(popFilter{i},:),noPlotsRoot,noPlotsRoot,divName{i},eval(divFun{i}));
        for soln=1:noPlots
            gen_distributions.(['Solution_' num2str(soln)]).SegmentLengths=sort(gen_data{soln}(:,2));
            gen_distributions.(['Solution_' num2str(soln)]).Gen_tree_vis=gen_data{soln};
        end
    end    
end

