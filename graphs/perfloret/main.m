function main                 
    addpath(genpath('../common/'));
    addpath(genpath('../matfiles/'));
    
    
    load('settings.mat');
    load('gaResult.mat');             
    
    % divergence

    for divergence = 1:size(res,1)     
           
        
        gaResult = res{divergence,1};
        DIV = res{divergence,2};

        gp.version = settings.generator_version;                
            
        %gp.gen_distr = @(p1,p2) unifrnd(p1,p2);    
        %gp.gen_distr = @(p1,p2) gamrnd(p1,p2);    
        gp.no_florets = 426;


        %% params
        real_data = extractFeaturesSegments('XY_floret_dendrogram.xml');
        real_data = get_data(real_data); 


        for param_ind = 1:size(gaResult,1)
            for i = 1:settings.no_params 
                gp.(settings.params{i,1}) = gaResult(param_ind,i);
            end
            
            titletext = 'Floretwise statistics for generator with';
    
            gp.res_distr = settings.res_distr;
            gp.gen_distr = settings.gen_distr;
            if gp.retract_p1 > 0
                titletext = [titletext ' retraction '];
                %gp.res_distr = @(p1,p2) gamrnd(p1,p2);
            else
                titletext = [titletext 'out retraction '];
                %gp.res_distr = @(p1,p2) identityFunction(p1,p2);
            end
            
            if gp.pl_growth > 0
                titletext = [titletext 'and PL' sprintf('(%2.2f)', gp.pl_growth)];
            else
                titletext = [titletext ' retraction '];
            end

            gen_data_res = generateMultipleFlorets(gp);
            asymmetry(gen_data_res(:,1))
            %distfitres{param_ind} = allfitdist(gen_data_res(:,2),'NLogL');
            %kstest((log(gen_data_res(:,2)) - mean(log(gen_data_res(:,2))))/std(log(gen_data_res(:,2))));                

            gen_data = get_data(gen_data_res);


            %% plots

            folder_name = sprintf('perfloret_%d',param_ind);
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
            hL = legend(ax,{'real data','generated data'});
            set(hL,'Position',  [0.5 0.12 0.1 0.1] ,'Units', 'normalized');
            axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units',...
                'normalized', 'clipping' , 'off');
            text(0.5, 1,titletext,'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 14);            
            set(gcf, 'color', [1 1 1]);           
                                   
            mkdir(folder_name);
            filename_rel_path = [folder_name '/' sprintf([folder_name '_%s'],DIV) '.pdf'];
            export_fig(filename_rel_path,'-nofontswap');
            saveas(gcf, [folder_name '/' folder_name '.fig'], 'fig');
        
            clf;
        end
    end
end