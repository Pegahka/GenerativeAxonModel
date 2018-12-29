function confidence_interval(targetpath,no_real,Bestx)
mfile_name          = mfilename('fullpath');
[rootpath,name,ext]  = fileparts(mfile_name);
oldpath=cd(rootpath);
addpath(genpath([rootpath '/common/']));


load([targetpath '/Optimized Parameters/settings.mat']);
load([targetpath '/Optimized Parameters/gaResultFull.mat']);

%% perfloret & visualisation
cd([rootpath '/visualization']);

divId = {'js'};
divName = {'JS'};
divFun = {'@(x,y) shannonjensen(x,y)'};

for i = 1:length(divId)
    
    full_result = results_full.(divId{i});
    
    [scores, indices] = sort(full_result.scores,'ascend');
    population = full_result.population(indices,:);
    
    gp.version = settings.generator_version;
    gp.gen_distr = settings.gen_distr;
    gp.res_distr = settings.res_distr;
    gp.no_florets = settings.no_florets; %426
    
    %PlotNSets
    gaResult=population(1:Bestx,:);
    
    cd([rootpath '/perfloret']);
    real_data_perfloret2 = extractFeaturesSegments('XY_floret_dendrogram.xml');
    real_data_perfloret = get_data(real_data_perfloret2);
    cd([rootpath '/visualization']);
    
    %[xOrigTmp,xOrigTmpBinCenters] = estimate_bins(options.real_data);
    X=settings.real_data;
    binWidth = 5;
    noBins = floor(max(X)-min(X))/binWidth;
    [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);
    if isempty(bincenters)
        noBins = 30;
        [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);
    end
    xOrigTmp = f_temp / (bincenters(2)-bincenters(1));
    xOrigTmpBinCenters=bincenters;
    
    plot_data_real_visualisation=[xOrigTmpBinCenters ; xOrigTmp];
    
    for param_ind = 1:size(gaResult,1)
        for i = 1:settings.no_params
            gp.(settings.params{i,1}) = gaResult(param_ind,i);
        end
        
        titletext_perfloret{param_ind} = 'Floretwise statistics for the floret generator with';
        if gp.retract_p1 > 0
            titletext_perfloret{param_ind} = [titletext_perfloret{param_ind} ' retraction '];
        else
            titletext_perfloret{param_ind} = [titletext_perfloret{param_ind} 'out retraction '];
        end
        if gp.pl_growth > 0
            titletext_perfloret{param_ind} = [titletext_perfloret{param_ind} 'and PL' sprintf('(%2.2f)', gp.pl_growth)];
        end
        
        
        for realization=1:no_real
            
            gen_data = generateMultipleFlorets(gp);
            
            cd([rootpath '/perfloret']);
            gen_data_perfloret{param_ind,realization}=get_data(gen_data);
            cd([rootpath '/visualization']);
            %         if testData(gen_data{param_ind})
            if ((size(gen_data,1) <= settings.no_florets) || (std(gen_data(:,2)) < 0.1e-3))
                continue
            end
            
            %[x1tmp, bincenters] = estimate_bins(gen_data{param_ind}(:,2));
            X=gen_data(:,2);
            binWidth = 5;
            noBins = floor(max(X)-min(X))/binWidth;
            [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);
            if isempty(bincenters)
                noBins = 30;
                [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);
            end
            x1tmp = f_temp / (bincenters(2)-bincenters(1));
            
            plot_data_gen_visualisation{param_ind,realization}=[bincenters ; x1tmp];
        end
    end
    
    
end

close all;
clearvars -except oldpath titletext_perfloret Bestx no_real targetpath rootpath resSetList resSetList_i resSetDir gen_data_perfloret real_data_perfloret resSetList_ordered plot_data_gen_visualisation plot_data_real_visualisation settings results_full;

if exist([targetpath '/Confidence Interval'],'dir')
    rmdir([targetpath '/Confidence Interval'],'s');
end;
mkdir([targetpath '/Confidence Interval']);

%PLOT INITIALIZATION
cd(rootpath);
no_plots=Bestx;
font_scale = 0.8;
nrow_fl=4;
ncol_fl=3;

%SEGMENT-LENGTH PLOTS
for plot_i=1:no_plots
    x{plot_i}=[];
    for real_i=1:no_real
        x_pseudo{plot_i,real_i}=plot_data_gen_visualisation{plot_i,real_i}(1,:);
        y_pseudo{plot_i,real_i}=plot_data_gen_visualisation{plot_i,real_i}(2,:);
        x{plot_i}=[x{plot_i} x_pseudo{plot_i,real_i}];
    end
    x{plot_i}=sort(x{plot_i},'ascend');
    x{plot_i}=unique(x{plot_i});
    for real_i=1:no_real
        y_fitted{plot_i}(real_i,:)=interp1(x_pseudo{plot_i,real_i},y_pseudo{plot_i,real_i},x{plot_i},'linear',0);
    end
    y_fitted{plot_i}=(y_fitted{plot_i}>0).*y_fitted{plot_i};
    mu=mean(y_fitted{plot_i});
    sigma=sqrt(var(y_fitted{plot_i}));
    
    sigma=interp1(x{plot_i},sigma,linspace(min(x{plot_i}),max(x{plot_i}),1000),'linear',0);
    mu=interp1(x{plot_i},mu,linspace(min(x{plot_i}),max(x{plot_i}),1000),'linear',0);
    x{plot_i}=linspace(min(x{plot_i}),max(x{plot_i}),1000);
    N_LPF=21; %odd number
    sigma=conv(sigma,ones(1,N_LPF)/N_LPF,'same');
    
    y_U{plot_i}=mu+sigma;
    y_L{plot_i}=max(mu-sigma,0);
    
    figure;
    h = fill([x{plot_i} flip(x{plot_i})],[y_L{plot_i} flip(y_U{plot_i})],'b');
    set(h,'facealpha',.5);
    set(h,'LineStyle','none')
    hold on;
    plot(plot_data_real_visualisation(1,:),plot_data_real_visualisation(2,:), 'Color',[0 0.5 0], 'LineWidth',1.6);
    xlabel('Segment-length [um]','FontSize',16*font_scale);
    ylabel('Density','FontSize',16*font_scale);
    legend({'Generated data','Biological data'});
    title('Segment-length distribution based on optimized parameters obtained by GA', 'FontWeight', 'bold', 'FontSize', 14 * 0.7, 'FontUnits', 'normalized');
    set(gcf, 'color', [1 1 1]);
    cd common/export_fig
    if exist('export_fig.m')
        if no_plots==1
            export_fig([targetpath '/Confidence Interval/CI_lengthFrequencies-' num2str(no_real) '_realizations.pdf'],'-nofontswap');
            export_fig([targetpath '/Confidence Interval/CI_lengthFrequencies-' num2str(no_real) '_realizations.fig'],'-nofontswap');
        else
            export_fig([targetpath '/Confidence Interval/CI_lengthFrequencies_' num2str(plot_i) '-' num2str(no_real) '_realizations.pdf'],'-nofontswap');
            export_fig([targetpath '/Confidence Interval/CI_lengthFrequencies_' num2str(plot_i) '-' num2str(no_real) '_realizations.fig'],'-nofontswap');
        end
    else
        display('Plot could not be exported: ''export_fig.m'' could not be found.');
    end
    close all
    cd ../..
end


% PERFLORET PLOTS
cd([rootpath '/perfloret']);
font_scale = 0.7;
for plot_i=1:no_plots
    
    for real_i=1:no_real
        for fl_i=1:8
            if fl_i==5 || fl_i==8
                [fl_y_gen_pseudo{plot_i,fl_i,real_i},fl_x_gen_pseudo{plot_i,fl_i,real_i}]= estimate_bins_disc(gen_data_perfloret{plot_i,real_i}(:,fl_i));
            else
                [fl_y_gen_pseudo{plot_i,fl_i,real_i},fl_x_gen_pseudo{plot_i,fl_i,real_i}]= estimate_bins(gen_data_perfloret{plot_i,real_i}(:,fl_i));
            end
        end
    end
    
end

for fl_i=1:8
    if fl_i==5 || fl_i==8
        [fl_y_real{fl_i},fl_x_real{fl_i}]= estimate_bins_disc(real_data_perfloret(:,fl_i));
    else
        [fl_y_real{fl_i},fl_x_real{fl_i}]= estimate_bins(real_data_perfloret(:,fl_i));
    end
end

titletext={'Std of segment length'; 'Mean of segment length'; 'Mean of fitted distribution';...
    'Std of fitted distribution';'Number of branches'; 'Asymmetry';...
    'Average depth of florets'; 'Maximal depth of florets'; 'Asymmetry and maximal depth'};
xlabeltext={'std of segment length/floret';'mean of segment length/floret'; 'mean of fitted lognormal/floret';...
    'std of fitted lognormal/floret'; 'number of branches/floret'; 'asymmmetry index/floret'; ...
    'average depth/floret'; 'maximal depth/floret'; 'asymmetry index/floret';};
yltext={'density'; 'density'; 'density'; 'density'; 'density'; 'density'; 'density'; 'density'; 'maximal depth/floret'};



for plot_i=1:no_plots
    fig=figure(no_plots+plot_i);
    for fl_i=1:8
        
        fl_x_gen{plot_i,fl_i}=[];
        for real_i=1:no_real
            fl_x_gen{plot_i,fl_i}=[fl_x_gen{plot_i,fl_i} fl_x_gen_pseudo{plot_i,fl_i,real_i}];
        end
        fl_x_gen{plot_i,fl_i}=sort(fl_x_gen{plot_i,fl_i},'ascend');
        fl_x_gen{plot_i,fl_i}=unique(fl_x_gen{plot_i,fl_i});
        for real_i=1:no_real
            fl_y_gen_fitted{plot_i,fl_i}(real_i,:)=interp1(fl_x_gen_pseudo{plot_i,fl_i,real_i},fl_y_gen_pseudo{plot_i,fl_i,real_i},fl_x_gen{plot_i,fl_i},'linear',0);
        end
        
        fl_y_gen_fitted{plot_i,fl_i}=((fl_y_gen_fitted{plot_i,fl_i})>0).*fl_y_gen_fitted{plot_i,fl_i};
        
        mu=mean(fl_y_gen_fitted{plot_i,fl_i});
        sigma=sqrt(var(fl_y_gen_fitted{plot_i,fl_i}));
        
        sigma=interp1(fl_x_gen{plot_i,fl_i},sigma,linspace(min(fl_x_gen{plot_i,fl_i}),max(fl_x_gen{plot_i,fl_i}),1000),'linear',0);
        mu=interp1(fl_x_gen{plot_i,fl_i},mu,linspace(min(fl_x_gen{plot_i,fl_i}),max(fl_x_gen{plot_i,fl_i}),1000),'linear',0);
        fl_x_gen{plot_i,fl_i}=linspace(min(fl_x_gen{plot_i,fl_i}),max(fl_x_gen{plot_i,fl_i}),1000);
        N_LPF=21; %odd number
        sigma=conv(sigma,ones(1,N_LPF)/N_LPF,'same');
        %     fl_y_U{plot_i,fl_i}=min(mu+sigma,max(fl_y_gen_fitted{plot_i,fl_i}));
        %     fl_y_L{plot_i,fl_i}=max(mu-sigma,min(fl_y_gen_fitted{plot_i,fl_i}));
        fl_y_U{plot_i,fl_i}=mu+sigma;
        fl_y_L{plot_i,fl_i}=max(mu-sigma,0);
        figure(fig);
        subplot(nrow_fl,ncol_fl,fl_i);
        h = fill([fl_x_gen{plot_i,fl_i} flip(fl_x_gen{plot_i,fl_i})],[fl_y_L{plot_i,fl_i} flip(fl_y_U{plot_i,fl_i})],'b');
        set(h,'facealpha',.5)
        set(h,'LineStyle','none')
        hold on;
        plot(fl_x_real{fl_i},fl_y_real{fl_i}, 'Color',[0 0.5 0], 'LineWidth',1.6);
        
        set(gca,'FontSize',6 * font_scale);
        title(titletext{fl_i},'FontSize',10 * font_scale);
        xlabel(xlabeltext{fl_i},'FontSize',8 * font_scale); ylabel(yltext{fl_i},'FontSize',7 * font_scale);
    end
    figure(fig);
    hL = legend({'Generated data','Biological data'});
    set(hL,'Position',  [0.5 0.12 0.1 0.1] ,'Units', 'normalized');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units',...
        'normalized', 'clipping' , 'off');
    text(0.5, 1,titletext_perfloret{plot_i},'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 14 * 0.7, 'FontUnits', 'normalized');
    set(gcf, 'color', [1 1 1]);
    cd([rootpath '/common/export_fig']);
    if exist('export_fig.m')
        if no_plots==1
            export_fig([targetpath '/Confidence Interval/CI_floretwise-' num2str(no_real) '_realizations.pdf'],'-nofontswap');
            export_fig([targetpath '/Confidence Interval/CI_floretwise-' num2str(no_real) '_realizations.fig'],'-nofontswap');
        else
            export_fig([targetpath '/Confidence Interval/CI_floretwise_' num2str(plot_i) '-' num2str(no_real) '_realizations.pdf'],'-nofontswap');
            export_fig([targetpath '/Confidence Interval/CI_floretwise_' num2str(plot_i) '-' num2str(no_real) '_realizations.fig'],'-nofontswap');
        end
    else
        display('Plot could not be exported: ''export_fig.m'' could not be found.');
    end
    cd([rootpath '/perfloret']);
    close all
end
cd(oldpath)
end

