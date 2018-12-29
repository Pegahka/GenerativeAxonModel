function plotNSetsReal()

    foldername = sprintf('Real data plots'); 
    
    mkdir(foldername);
    
    addpath(genpath('../common'));
    
    if (~exist('real_data','var'))
        real_data = extractFeaturesSegments('XY_floret_dendrogram.xml');
        real_data = real_data(:,2);
    end
    
    function [frequency, bincenters] = estimate_bins(X) 
        binWidth = 5;
        noBins = floor(max(X)-min(X))/binWidth;
        [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);
        frequency = f_temp / (bincenters(2)-bincenters(1));
    end
    
    [xOrigTmp,xOrigTmpBinCenters] = estimate_bins(real_data);
    
    hFig = figure(1);
    hFigLogn = figure(2);
    hFigLognGA = figure(3);
    
    figure(hFig);                               
    plot(xOrigTmpBinCenters, xOrigTmp, 'Color','b');
    xlabel('branch lengths','FontSize',8); ylabel('branchlength frequency','FontSize',8);         
        
    figure(hFigLogn);
    
    plot(xOrigTmpBinCenters, xOrigTmp, 'Color','b');
    hold on;
    
    log3fitR = log3fit(real_data);

    xlog3 = lognrnd(log3fitR(1),log3fitR(2),2000,1) + log3fitR(3);
    noBins = floor(max(xlog3)-min(xlog3))/binWidth;
    [xlog3Tmp, xlog3TmpBinCenters] = hist(xlog3,noBins); xlog3Tmp = xlog3Tmp/length(xlog3);
    xlog3Tmp = xlog3Tmp / (xlog3TmpBinCenters(2)-xlog3TmpBinCenters(1));
    plot(xlog3TmpBinCenters, xlog3Tmp, 'g');
    
    axis([0 600 0 0.025]);
    title(sprintf('mu: %.2f s: %.2f, shift %.2f',log3fitR(1),log3fitR(2),log3fitR(3)));
    xlabel('branch lengths','FontSize',8); ylabel('branchlength frequency','FontSize',8); 

    figure(hFigLognGA);
    plot(xOrigTmpBinCenters, xOrigTmp, 'Color','b');
    hold on;
    
    log3gafitR = zeros(3,1);
    [log3gafitR(1), log3gafitR(2), log3gafitR(3)] = shifted_lognormal_param_estimation(real_data);

    xlog3ga = lognrnd(log3gafitR(1),log3gafitR(2),2000,1) + log3gafitR(3);
    noBins = floor(max(xlog3ga)-min(xlog3ga))/binWidth;
    [xlog3gaTmp, xlog3gaTmpBinCenters] = hist(xlog3ga,noBins); xlog3gaTmp = xlog3gaTmp/length(xlog3ga);
    xlog3gaTmp = xlog3gaTmp / (xlog3gaTmpBinCenters(2)-xlog3gaTmpBinCenters(1));
    plot(xlog3gaTmpBinCenters, xlog3gaTmp, 'g');
    axis([0 600 0 0.03]);
    title(sprintf('mu: %.2f s: %.2f, shift %.2f',log3gafitR(1),log3gafitR(2),log3gafitR(3)));
    xlabel('branch lengths','FontSize',8); ylabel('branchlength frequency','FontSize',8); 

    figure(hFig);
    set(gcf, 'color', [1 1 1]);
     axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
        text(0.5, 1,sprintf('Empirical density function of the real data'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', ...
            'FontWeight', 'bold', 'FontSize', 16);  
    
    filename = sprintf('lengthFrequencies');
    filenameRelPath = [foldername '/' filename '.pdf'];
    export_fig(filenameRelPath);
	saveas(gcf, [foldername '/' filename '.fig'], 'fig');
    clf;
    
    figure(hFigLogn);
    legend({'real data','fitted lognormal'});
    set(gcf, 'color', [1 1 1]);
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,sprintf('Real data and the fitted 3 parameter lognormal distribution'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 14);
    filename = sprintf('lengthFrequenciesLog3');
    filenameRelPath = [foldername '/' filename '.pdf'];
    export_fig(filenameRelPath);
	saveas(gcf, [foldername '/' filename '.fig'], 'fig');
    clf;
    
    figure(hFigLognGA);
    legend({'real data','fitted lognormal'});
    set(gcf, 'color', [1 1 1]);
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,sprintf('Real data and the fitted 3 parameter lognormal distribution with GA'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 14);
    filename = sprintf('lengthFrequenciesLog3GA');
    filenameRelPath = [foldername '/' filename '.pdf'];
    export_fig(filenameRelPath);
	saveas(gcf, [foldername '/' filename '.fig'], 'fig');
    clf;
end