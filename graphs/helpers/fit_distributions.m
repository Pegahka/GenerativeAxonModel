function ret = fit_distributions(X,n, no_bins)    

    if ~exist('no_bins','var')
        no_bins = 200;
    end       
    
    foldername = 'fitting_distributions_real_data';
    mkdir(foldername);
    
    function [frequency, bincenters] = estimate_bins(X)         
        [f_temp, bincenters] = hist(X,no_bins); f_temp = f_temp/length(X);
        frequency = f_temp / (bincenters(2)-bincenters(1));
    end
    
    nrow = 2;
    ncol = floor(n/2) + 1;

    addpath(genpath('../common'))
        
    [ret, PD] = allfitdist(X,'PDF');   
    
    set(gcf, 'color', [1 1 1]);    
     axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
        text(0.5, 1,sprintf('Fitting distributions to the real data'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', ...
            'FontWeight', 'bold', 'FontSize', 16);      
    filename = sprintf('distribuitonsastheyshouldbe');
    filenameRelPath = [foldername '/' filename '.pdf'];
    export_fig(filenameRelPath);
	saveas(gcf, [foldername '/' filename '.fig'], 'fig');
    
    hFig = figure(2);
    clf;
    set(hFig, 'Position', [0 0 1366 768]);
    
    n = min(n,length(PD));
    
    xpdf = linspace(min(X),max(X),no_bins*10);
    
    [real_freq, real_bcenters] = estimate_bins(X);
    
    for i=1:n
        ys = pdf(PD{i}, xpdf);
        
        subplot(nrow,ncol,i);
        plot(xpdf,ys,'b');
        hold on;
        plot(real_bcenters, real_freq,'g');
        
        xlabel('branch lengths','FontSize',8); ylabel('branchlength frequency','FontSize',8);         
        titletext = sprintf('%s : \n',ret(i).DistName);
        
        for j=1:length(ret(i).Params)
            titletext = [titletext [ret(i).ParamNames{j} ': ' sprintf('%.2f, ',ret(i).Params(j))]];
        end
        
        title(titletext);        
    end
    
    set(gcf, 'color', [1 1 1]);
     axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
        text(0.5, 1,sprintf('Fitting distributions to the real data'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', ...
            'FontWeight', 'bold', 'FontSize', 16);  
    
    filename = sprintf('distributionssubplots');
    filenameRelPath = [foldername '/' filename '.pdf'];
    export_fig(filenameRelPath);
	saveas(gcf, [foldername '/' filename '.fig'], 'fig');
end