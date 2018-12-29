function mainReal
    addpath(genpath('../common/'));
    
                   
    %% params
    real_data = extractFeaturesSegments('XY_floret_dendrogram.xml');
    real_data = get_data(real_data); 

    titletext = 'Floretwise statistics for the real data  ';
    
    %% plots

    folder_name = sprintf('perfloret_Real');
    title = 'Std of segment length'; xlabeltext = 'std of segment length/floret';
    ax = plot_data_real(real_data(:,1), title,4,4,1,xlabeltext);
    title = 'Mean of segment length'; xlabeltext = 'mean of segment length/floret'; 
    plot_data_real(real_data(:,2), title,4,4,2,xlabeltext);
    title = 'Mean of fitted distribution'; xlabeltext = 'mean of fitted lognormal/floret';
    plot_data_real(real_data(:,3), title,4,4,3,xlabeltext);
    title = 'Std of fitted distribution'; xlabeltext = 'std of fitted lognormal/floret';
    plot_data_real(real_data(:,4), title,4,4,4,xlabeltext);        
    title = 'Number of branches'; xlabeltext = 'number of branches/floret';
    plot_data_real(real_data(:,5), title,4,4,5,xlabeltext);
    title = sprintf('Asymmetry'); xlabeltext = 'asymmmetry index/floret';
    plot_data_real(real_data(:,6), title,4,4,6,xlabeltext);
    title = 'Average depth of florets'; xlabeltext = 'average depth/floret';
    plot_data_real(real_data(:,7), title,4,4,7,xlabeltext);
    title = 'Maximal depth of florets'; xlabeltext = 'maximal depth/floret';
    plot_data_real(real_data(:,8), title,4,4,8,xlabeltext);
    title = 'Asymmetry and maximal depth'; ylabeltext = 'maximal depth/floret'; xlabeltext = 'asymmetry index/floret';
    plot_data_real([real_data(:,6) real_data(:,8)], title,4,4,9,xlabeltext,ylabeltext);
    hFig = figure(1);
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units',...
        'normalized', 'clipping' , 'off');
    text(0.5, 1,titletext,'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 18);            
    set(gcf, 'color', [1 1 1]);     
    set(hFig, 'Position', [0 0 1400 900]);

    mkdir(folder_name);
    filename_rel_path = [folder_name '/' sprintf([folder_name '_%REAL']) '.jpeg'];
    export_fig(filename_rel_path);
    saveas(gcf, [folder_name '/' folder_name '.fig'], 'fig');

    clf;
 
end