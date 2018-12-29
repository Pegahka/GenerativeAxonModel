
    %% PLOT AND SAVE DATA
    
    function ax = plot_data(data_real,data_gen, titletext, subploti, subplotj,sp, ...
        xlabeltext,ylabeltext)
                    
        font_scale = 0.7;
    
        if length(data_gen) < 3
            return
        end                            
            
        
    
       yltext = 'density';
          
       ax = subplot(subploti,subplotj-1,sp);
       if exist('ylabeltext','var')
         yltext = ylabeltext;
         y = data_real(:,1);
         x = data_real(:,2);
       else
        if strcmp(titletext,'Number of branches') || strcmp(titletext,'Maximal depth of florets')
            [x,y] = estimate_bins_disc(data_real);
        else
           [x,y] = estimate_bins(data_real);
        end
       end
       
       figure(1);
       if exist('ylabeltext','var')
        plot(y,x,'.','Color',[0 0.5 0],'LineWidth' ,1.3);
       else           
        plot(y,x,'Color',[0 0.5 0],'LineWidth' ,1.3);
       end
       hold on;
       set(gca,'FontSize',6 * font_scale);
       title(titletext,'FontSize',10 * font_scale);
       xlabel(xlabeltext,'FontSize',8 * font_scale); ylabel(yltext,'FontSize',7 * font_scale);
       
       if exist('ylabeltext','var')
         y = data_gen(:,1);
         x = data_gen(:,2);
       else
        if strcmp(titletext,'Number of branches') || strcmp(titletext,'Maximal depth of florets')
            [x,y] = estimate_bins_disc(data_gen);
        else
           [x,y] = estimate_bins(data_gen);
        end
       end
       
       if exist('ylabeltext','var')
        plot(y,x,'.b', 'LineWidth' ,1.3);
       else           
        plot(y,x,'b','LineWidth' ,1.3);
       end
       
