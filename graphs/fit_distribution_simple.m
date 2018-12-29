function fit_distribution_simple

addpath(genpath('../common/'));
X = extractFeaturesSegments('XY_floret_dendrogram.xml');
X = X(:,2);
X(X<1) = [];

% FOR LOG(DATA)
%X = log(X);

foldername = 'fitting_distributions_real_data';
    mkdir(foldername);
    
    function [frequency, bincenters] = estimate_bins(X)         
        [f_temp, bincenters] = hist(X,no_bins); f_temp = f_temp/length(X);
        frequency = f_temp / (bincenters(2)-bincenters(1));
    end    

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
end    