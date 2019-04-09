noPlots = no_plots_given;

addpath(genpath('../common/'));     %<main>/graphs/common
addpath(genpath('../matfiles/'));   %<main>/graphs/matfiles

load('settings.mat');       % <main>/graphs/matfiles/settings.mat with name 'settings' (struct)
load('gaResultFull.mat');   % <main>/graphs/matfiles/gaResultFull.mat with name 'results_full' (struct)

%% visualization

%divId = {'kl';'klrev';'js'};
%divName = {'KL Simple';'KL Reverse';'JS'};
%divFun = {'@(x,y) kldivergence(x,y)';'@(x,y) kldivergence(y,x)'; ...
%    '@(x,y) shannonjensen(x,y)'};
divId = {'js'};
divName = {'JS'};
divFun = {'@(x,y) shannonjensen(x,y)'};

for i = 1:length(divId)
    foldername = divName{i};
    mkdir(foldername); % create a folder <main>/graphs/perfloret/JS (It was deleted in graphs.m before calling this script)
            
%    full_result = results_full.(divId{i}){1};
    full_result = results_full.(divId{i}); %results_full came from gaResultFull.mat load
    
    [scores, indices] = sort(full_result.scores,'ascend');
    population = full_result.population(indices,:); %Sort parameters according to their scores. (Smaller is better)            
    
    gp.version = settings.generator_version;
    gp.no_florets = 426;

    %% params
    real_data = extractFeaturesSegments('XY_floret_dendrogram.xml'); %Real florets are outputted (level-segmentlength-floretID)
    real_data = get_data(real_data); % Get the statistics of real florets (mean, variance etc)
    real_data_perfloret = real_data;
    gaResult = population(1:noPlots,:); % Take the best <noPlots> optimized parameters

    for param_ind = 1:size(gaResult,1)
        for i = 1:settings.no_params 
            gp.(settings.params{i,1}) = gaResult(param_ind,i); %parameters are passed to 'gp' struct with their names as field name. gp.ParameterName=ParameterValue
        end

        titletext = 'Floretwise statistics for the floret generator with';

        gp.res_distr = settings.res_distr;
        gp.gen_distr = settings.gen_distr;
        if gp.retract_p1 > 0 %Title details are being set
            titletext = [titletext ' retraction '];            
        else
            titletext = [titletext 'out retraction '];            
        end

        if gp.pl_growth > 0
            titletext = [titletext 'and PL' sprintf('(%2.2f)', gp.pl_growth)];
        end
        
        gen_data_res = generateMultipleFlorets(gp); % <main>/graphs/common/generator/generateMultipleFlorets.m. 
                                                    % 426 (set above) florets are generated and outputted (level-segmentlength-floretID)
        asymmetry(gen_data_res(:,1)); 
        %distfitres{param_ind} = allfitdist(gen_data_res(:,2),'NLogL');
        %kstest((log(gen_data_res(:,2)) - mean(log(gen_data_res(:,2))))/std(log(gen_data_res(:,2))));                

        gen_data = get_data(gen_data_res); % Get the statistics of generated florets
        gen_data_perfloret{resSetList_ordered,param_ind}=gen_data;
        gen_distributions.(['Solution_' num2str(param_ind)]).Statistics=[gen_data(:,9) gen_data(:,1:8)]; % Statistics of generated florets are hold and will be saved in gen_distributions.mat later
        %% plots       
        % Each column of real_data and gen_data is one type of statistics.
        % They are plotted and compared in subplots
        title = 'Std of segment length'; xlabeltext = 'std of segment length/floret';
        ax = plot_data(real_data(:,1),gen_data(:,1), title,4,4,1,xlabeltext);
        title = 'Mean of segment length'; xlabeltext = 'mean of segment length/floret'; 
        plot_data(real_data(:,2),gen_data(:,2), title,4,4,2,xlabeltext);
        title = 'Mean of fitted distribution'; xlabeltext = 'mean of fitted lognormal/floret';
        plot_data(real_data(:,3),gen_data(:,3), title,4,4,3,xlabeltext);
        title = 'Std of fitted distribution'; xlabeltext = 'std of fitted lognormal/floret';
        plot_data(real_data(:,4),gen_data(:,4), title,4,4,4,xlabeltext);        
        title = 'Number of branches'; xlabeltext = 'number of branches/floret';
        plot_data(real_data(:,5),gen_data(:,5), title,4,4,5,xlabeltext);
        title = sprintf('Asymmetry'); xlabeltext = 'asymmmetry index/floret';
        plot_data(real_data(:,6),gen_data(:,6), title,4,4,6,xlabeltext);
        title = 'Average depth of florets'; xlabeltext = 'average depth/floret';
        plot_data(real_data(:,7),gen_data(:,7), title,4,4,7,xlabeltext);
        title = 'Maximal depth of florets'; xlabeltext = 'maximal depth/floret';
        plot_data(real_data(:,8),gen_data(:,8), title,4,4,8,xlabeltext);
        title = 'Asymmetry and maximal depth'; ylabeltext = 'maximal depth/floret'; xlabeltext = 'asymmetry index/floret';
        plot_data([real_data(:,6) real_data(:,8)],[gen_data(:,6) gen_data(:,8)], title,4,4,9,xlabeltext,ylabeltext);
        figure(1);
        hL = legend(ax,{'biological data','generated data'});
        set(hL,'Position',  [0.5 0.12 0.1 0.1] ,'Units', 'normalized');
        % axes() and text() below are for a general title. There is no explicit
        % method to set a general title in figures with subplots. title()
        % command adds title to the current subplot.
        axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units',...
            'normalized', 'clipping' , 'off');
        text(0.5, 1,titletext,'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 14 * 0.7, 'FontUnits', 'normalized');
        set(gcf, 'color', [1 1 1]);           
       
        filename_rel_path = [foldername '/' sprintf(['floretwise' '_%d'],param_ind) '.pdf']; 
        filename_rel_path_fig = [foldername '/' sprintf(['floretwise' '_%d'],param_ind) '.fig'];
        export_fig(filename_rel_path,'-nofontswap'); % save the figure as <main>/graphs/perfloret/JS/floretwise_x.pdf. This command uses a 3rd party tool
        export_fig(filename_rel_path_fig,'-nofontswap'); % save the figure as <main>/graphs/perfloret/JS/floretwise_x.fig. This command uses a 3rd party tool
        clf('reset'); % Reset the figure and reuse it instead of closing and opening a new one. This is faster.
    end    
end

