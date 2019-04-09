noPlots = no_plots_given;
noPlotsRoot = ceil(sqrt(noPlots));
addpath(genpath('../common/'));     %<main>/graphs/common
addpath(genpath('../matfiles/'));   %<main>/graphs/mathfiles

load('settings.mat');       % <main>/graphs/matfiles/settings.mat with name 'settings' (struct)
load('gaResultFull.mat');   % <main>/graphs/matfiles/gaResultFull.mat with name 'results_full' (struct)
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
        full_result = results_full.(divId{i}); %results_full came from gaResultFull.mat load

        [scores, indices] = sort(full_result.scores,'ascend');
        population = full_result.population(indices,:); %Sort parameters according to their scores. (Smaller is better)

        %plotNSets function : <main>/graphs/visualization/plotNSets.m
        %plotNSets generates florets with given optimized parameters (best 'noPlots' of them) (taken
        %from settings.mat), and plots histograms of real and generated
        %segment lengths
        [plot_data_gen_visualisation{resSetList_ordered}, plot_data_real_visualisation{resSetList_ordered},gen_data]=plotNSets(settings,population(popFilter{i},:),noPlotsRoot,noPlotsRoot,divName{i},eval(divFun{i}));
        for soln=1:noPlots %Generated data is saved.
            gen_distributions.(['Solution_' num2str(soln)]).SegmentLengths=sort(gen_data{soln}(:,2)); %Only segment lengths (sorted)
            gen_distributions.(['Solution_' num2str(soln)]).Gen_tree_vis=gen_data{soln}; % for dendrogram visualisation (level-segmentlength-floretID)
        end
    end    
end