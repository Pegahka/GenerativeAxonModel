%% PLOT AND SAVE DATA

function ax = plot_data_real(data_real,titletext, subploti, subplotj,sp, ...
    xlabeltext,ylabeltext)
    yltext = 'frequency';

    ax = subplot(subploti-1,subplotj-1,sp);
    if exist('ylabeltext','var')
        yltext = ylabeltext;
        y = data_real(:,1);
        x = data_real(:,2);
    else        
        [x,y] = estimate_bins(data_real);
    end

    figure(1);
    if exist('ylabeltext','var')
        plot(y,x,'*g','LineWidth',2);
    else           
        plot(y,x,'g','LineWidth',2);
    end
    
    hold on;
    set(gca,'FontSize',10);
    title(titletext,'FontSize',14);
    xlabel(xlabeltext,'FontSize',10); ylabel(yltext,'FontSize',10);
