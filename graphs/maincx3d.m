function maincx3d                
    addpath(genpath('../common/'));
    addpath(genpath('../matfiles/'));
                                       
    gp.no_florets = 500;
    gp.gen_distr = '@(p1,p2) gamrnd(p1,p2)';
    gp.res_distr = '@(p1,p2) gamrnd(p1,p2)';
    gp.pl_growth = 5;
    gp.pl_retract = 5;
    gp.growth_p1 = 6;
    gp.growth_p2 = 6;
    gp.retract_p1 = 6;
    gp.retract_p2 = 6;
    gp.r_shape = 10;
    gp.r_scale = 10;
    gp.bias = 0.6;
    gp.g_factor = 0.5;
    gp.r_factor = 0.3;
    gp.version = 2;
    gp.offset = 0.0;
    gp.no_florets = 5000;

    titletext = 'Comparison of the floretwise statistics from CX3D and MATLAB \n (version with retraction)';

    
    gen_data_res = generateMultipleFlorets(gp);    
    %distfitres{param_ind} = allfitdist(gen_data_res(:,2),'NLogL');
    %kstest((log(gen_data_res(:,2)) - mean(log(gen_data_res(:,2))))/std(log(gen_data_res(:,2))));                

    gen_data = get_data(gen_data_res);
%     
    load out_big.csv
    out = out_big;
    gen_data_cx3d  = get_data(out);
%     gen_data_cx3d = generateMultipleFlorets(gp);
%     gen_data_cx3d = get_data(gen_data_cx3d); 


    %% plots    
    title = 'Std of segment length'; xlabeltext = 'std of segment length/floret';
    ax = plot_data(gen_data_cx3d(:,1),gen_data(:,1), title,4,4,1,xlabeltext);
    title = 'Mean of segment length'; xlabeltext = 'mean of segment length/floret'; 
    plot_data(gen_data_cx3d(:,2),gen_data(:,2), title,4,4,2,xlabeltext);
    title = 'Mean of fitted distribution'; xlabeltext = 'mean of fitted lognormal/floret';
    plot_data(gen_data_cx3d(:,3),gen_data(:,3), title,4,4,3,xlabeltext);
    title = 'Std of fitted distribution'; xlabeltext = 'std of fitted lognormal/floret';
    plot_data(gen_data_cx3d(:,4),gen_data(:,4), title,4,4,4,xlabeltext);        
    title = 'Number of branches'; xlabeltext = 'number of branches/floret';
    plot_data(gen_data_cx3d(:,5),gen_data(:,5), title,4,4,5,xlabeltext);
    title = sprintf('Asymmetry'); xlabeltext = 'asymmmetry index/floret';
    plot_data(gen_data_cx3d(:,6),gen_data(:,6), title,4,4,6,xlabeltext);
    title = 'Average depth of florets'; xlabeltext = 'average depth/floret';
    plot_data(gen_data_cx3d(:,7),gen_data(:,7), title,4,4,7,xlabeltext);
    title = 'Maximal depth of florets'; xlabeltext = 'maximal depth/floret';
    plot_data(gen_data_cx3d(:,8),gen_data(:,8), title,4,4,8,xlabeltext);
    title = 'Asymmetry and maximal depth'; ylabeltext = 'maximal depth/floret'; xlabeltext = 'asymmetry index/floret';
    plot_data([gen_data_cx3d(:,6) gen_data_cx3d(:,8)],[gen_data(:,6) gen_data(:,8)], title,4,4,9,xlabeltext,ylabeltext);
    hFig = figure(1);
    set(hFig, 'Position', [0 0 1400 900]);
    hL = legend(ax,{'cx3d data','matlab data'});
    set(hL,'Position',  [0.5 0.12 0.1 0.1] ,'Units', 'normalized');
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units',...
        'normalized', 'clipping' , 'off');
    text(0.5, 1,sprintf(titletext),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 14);            
    set(gcf, 'color', [1 1 1]);           

    folder_name = 'Comparison of matlab and cx3d';
    mkdir(folder_name);
    filename_rel_path = [folder_name '/comparison_ret.pdf'];
    export_fig(filename_rel_path);

    clf;
end