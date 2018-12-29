function [x1tmp_Set, Plot_data_set, gen_data]=plotNSets(options,gaResult,nrow,ncol, DIV, div_function)

    font_scale = 0.8;

%     foldername = sprintf('floret_%d',options.generator_version); 
%     
% %     for i=1:options.no_params
% %         foldername = [foldername sprintf('_%.2f-%.2f',min(gaResult(:,i)),max(gaResult(:,i)))];
% %     end
% %     
%     foldername = [foldername '_' DIV];
    
    foldername=DIV;
    mkdir(foldername);
    
    textFile = fopen([pwd '/' foldername '/report.txt'], 'w');
    
    gen_data = cell(nrow*ncol,1);
    
    
    divResult = zeros(nrow*ncol,1);    
    
    function bool = testData(X)
        bool = 0;
        
        if size(X,1) <= options.no_florets
            bool = 1;
            return;
        end
        
        if std(X(:,2)) < 0.1e-3;
            bool = 1;
            return;
        end
    end
    
    function [frequency, bincenters] = estimate_bins(X) 
        binWidth = 5;
        noBins = floor(max(X)-min(X))/binWidth;
        [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);
        
        if isempty(bincenters)
            noBins = 30;
            [f_temp, bincenters] = hist(X,noBins); f_temp = f_temp/length(X);
        end
        
        frequency = f_temp / (bincenters(2)-bincenters(1));
    end

    function index = string_ind_cell(str) 
        indCell = strfind(options.params,str);
        index = find(not(cellfun('isempty', indCell)));
    end
    
    [xOrigTmp,xOrigTmpBinCenters] = estimate_bins(options.real_data);
    Plot_data_set=[xOrigTmpBinCenters ; xOrigTmp];
    log3fitR = zeros(size(gaResult,1),3);
    log3gafitR = zeros(size(gaResult,1),3);
    
    
    %additional parameter to be set
    gp.version = options.generator_version;
    gp.gen_distr = options.gen_distr_short;
    gp.res_distr = options.res_distr_short;
       
    gp.no_florets = options.no_florets;  
    
    for param_ind = 1:size(gaResult,1)      
        for i = 1:options.no_params 
            gp.(options.params{i,1}) = gaResult(param_ind,i);
        end      
   
        gen_data{param_ind} = generateMultipleFlorets(gp);
        
        if testData(gen_data{param_ind})
            continue
        end
    
        
        divResult(param_ind) = div_function(options.real_data,gen_data{param_ind}(:,2));
        
%         fprintf(textFile,sprintf('================== %s =================\n \n', DIV));    
%         fprintf(textFile,'============================================= \n \n');
%         
%         for i=1:options.no_params
%             fprintf(textFile, [options.params{i,2} ' ']);          
%         end
%         
%         fprintf(textFile, '\n');
%         
%         for i=1:options.no_params
%             fprintf(textFile,sprintf('%2.2f ',gaResult(param_ind,i)));
%         end
%         fprintf(textFile,'============================================= \n \n');
% 
%         fprintf(textFile,'Resource in expectation: %2.3f \n \n',mean(options.gen_distr(gaResult(param_ind, string_ind_cell('r_shape')), ...
%             gaResult(param_ind, string_ind_cell('r_scale')),1000,1)));
% 
%         fprintf(textFile,'mean Real data: %2.3f \n',mean(options.real_data));
%         fprintf(textFile,'mean Generated data: %2.3f \n \n',mean(gen_data{param_ind}(:,2)));
% 
%         fprintf(textFile,'std Real data: %.2f \n',std(options.real_data));
%         fprintf(textFile,'std Generated data: %.2f \n \n',std(gen_data{param_ind}(:,2)));
% 
%         fprintf(textFile,'skewnes Real data: %.2f \n',skewness(options.real_data));
%         fprintf(textFile,'skewnes Generated data: %.2f \n \n',skewness(gen_data{param_ind}(:,2)));
% 
%         log3fitRreal = log3fit(options.real_data(options.real_data > 0));
%         fprintf(textFile,'log3fit Real data: %.2f %.2f %.2f \n',log3fitRreal(1),log3fitRreal(2),log3fitRreal(3));
% 
%         log3fitR(param_ind,:) = log3fit(gen_data{param_ind}(:,2));
%         fprintf(textFile,'log3fit Generated data: %.2f %.2f %.2f \n \n',log3fitR(1),log3fitR(2),log3fitR(3));
% 
% 
%         [log3fitR1real, log3fitR2real, log3fitR3real] = shifted_lognormal_param_estimation(options.real_data(options.real_data > 0));
%         fprintf(textFile,'log3fit GA Real data: %.2f %.2f %.2f \n',log3fitR1real,log3fitR2real,log3fitR3real);
% 
%         [log3gafitR(param_ind,1), log3gafitR(param_ind,2), log3gafitR(param_ind,3)] = shifted_lognormal_param_estimation(gen_data{param_ind}(:,2));
%         fprintf(textFile,'log3fit GA Generated data: %.2f %.2f %.2f \n \n',log3gafitR(param_ind,1),log3gafitR(param_ind,2),log3gafitR(param_ind,3));
% %         
%         if isfield(gp,'retract_p1')
%             retract_param = 'retract';
%         else 
%             retract_param = 'growth';
%         end
% 
%         fprintf(textFile,'Expected retraction: %.2f \n \n', ...
%            mean(options.gen_distr(gaResult(param_ind, string_ind_cell([retract_param '_p1'])), ...
%             gaResult(param_ind, string_ind_cell([retract_param '_p2'])),2066,1)));
%         
%         disp(mean(options.gen_distr(gaResult(param_ind, string_ind_cell([retract_param '_p1'])), ...
%             gaResult(param_ind, string_ind_cell([retract_param '_p2'])),2066,1)));
% 
%         fprintf(textFile,'Expected growth noise: %.2f \n \n', ...
%            mean(options.gen_distr(gaResult(param_ind, string_ind_cell('growth_p1')), ...
%             gaResult(param_ind, string_ind_cell('growth_p2')),2066,1)));
% 
% 
%         fprintf(textFile,'Divergence result: %.5f \n \n', divResult(param_ind));
% 
%         [x1tmp, bincenters] = estimate_bins(gen_data{param_ind}(:,2));
%         
%         [~, indMaxGen] = max(x1tmp);
%         [~, indMaxReal] = max(xOrigTmp);
% 
%         fprintf(textFile,'Center of the highest bin, biological data: %.2f \n \n', ...
%             xOrigTmpBinCenters(indMaxReal));
%         fprintf(textFile,'Center of the highest bin, generated data: %.2f \n \n', ...
%             bincenters(indMaxGen));
% 
%         fprintf(textFile,'============================================= \n \n');
%             
    end

    if length(divResult) > 1
    
        divResultWider = 0:1/(length(divResult)-1):1;
        divResultWider = divResultWider';

        [~, ind] = sort(divResult);

        tmpDivResults = zeros(size(divResult));
        for i=1:length(divResult)
            tmpDivResults(ind(i)) = divResultWider(i);
        end
        divResultWider = tmpDivResults;
    
    else
        divResultWider = 1;
    end
 
    colors = sort(divResultWider);
    hFig = figure(1);
    set(hFig, 'Position', [0 0 1400 nrow*500],'visible','off');

    hFigLogn = figure(3);
    set(hFigLogn, 'Position', [0 0 1400 nrow*500],'visible','off');
   
    hFigLognGA = figure(4);
    set(hFigLognGA, 'Position', [0 0 1400 nrow*500],'visible','off');
    
    
    
    for param_ind = 1:size(gaResult,1)
        
        
        if testData(gen_data{param_ind})
            continue
        end
        
        
        
        figure(hFig);
        subplot(nrow,ncol,param_ind);               
        
        [x1tmp, bincenters] = estimate_bins(gen_data{param_ind}(:,2));
        x1tmp_Set{1,param_ind}=[bincenters ; x1tmp];
        
       ax =  plot(bincenters, x1tmp,'Color',[divResultWider(param_ind) 0 1-divResultWider(param_ind)], 'LineWidth',1.6);
 	xlabel('Segment-length [um]','FontSize',16*font_scale); ylabel('Density','FontSize',16*font_scale);   
        hold on;       
        ax2 = plot(xOrigTmpBinCenters, xOrigTmp, 'Color',[0 0.5 0], 'LineWidth',1.6);
         xlabel('Segment-length [um]','FontSize',16*font_scale); ylabel('Density','FontSize',16*font_scale);   

        hFigTmp = figure(5);
        set(hFigTmp, 'Position', [0 0 600 800],'visible','off');
        figure(hFigTmp);
        ay2 = plot(bincenters, x1tmp,'Color','b', 'LineWidth',1.6);
	 xlabel('Segment-length [um]','FontSize',16); ylabel('Density','FontSize',16*font_scale);   
        hold on;
      	ay =plot(xOrigTmpBinCenters, xOrigTmp, 'Color',[0 0.5 0], 'LineWidth',1.6);
        axis([0 600 0 0.035]);
        axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');        
                
        %% TITLESTRING HERE
        variation = '';
        if gaResult(1,1) == 0 && gaResult(1,end) == 0
            variation = 'random';
        elseif gaResult(1,1) >= 5
            variation = 'PL';
        elseif gaResult(1,end) >= 1
            variation = 'offset';
        end

        if isempty(variation)
            variation = 'error';
        end;

        ret_ver = '';
        if gaResult(1,end-2) > 0
            ret_ver = 'with retraction';
        else 
            ret_ver = 'without retraction';
        end
        
        if isempty(ret_ver)
            ret_ver = 'error';
        end;
        
        title_text = ['Generated data with the ' variation '-variation ' sprintf('\n')];
        title_text = [title_text ' ' ret_ver ', ' DIV ': ' sprintf('%.3f',divResult(param_ind))];
%         for ii=1:options.no_params
%             title_text = [title_text ' ' sprintf('%s: %.2f',options.params{ii,3}, gaResult(param_ind,ii))];
%             if mod(ii,4) == 0
%                 title_text = [title_text ' ' sprintf('\n')];
%             end                        
%         end
%         
%         title_text = [title_text ' (' DIV ') ']; 
	% title('Generated data with the variation pure random', 'FontSize', 14,'FontWeight','bold') %,'HorizontalAlignment' ,'center','VerticalAlignment', 'top')
      text(0.5, 1,title_text,'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontSize', 14*font_scale,'FontWeight','bold');
        
      %  xlabel('branch lengths','FontSize',16); ylabel('branchlength frequency','FontSize',16); 
	 xlabel('Segment-length [um]','FontSize',16); ylabel('Density','FontSize',16*font_scale);         
	hL0 = legend([ay,ay2],'string',{'Biological data','Generated data'});
        set(hL0,'Location','NorthEast' ,'Units', 'normalized', 'FontSize',13*font_scale,'FontWeight', 'bold');	

        filename = sprintf('lengthFrequencies_%d',param_ind);
        filenameRelPath = [foldername '/' filename '.pdf'];
        filenameRelPathfig = [foldername '/' filename '.fig'];
        set(gcf, 'color', [1 1 1]);
        export_fig(filenameRelPath,'-nofontswap');
        export_fig(filenameRelPathfig,'-nofontswap');
        close(hFigTmp,'reset');






	fprintf(textFile,sprintf('================== lengthfrequencies %d =================\n \n', param_ind));    
        fprintf(textFile,'=========================================================== \n \n');
        
        fprintf(textFile,'\\begin{tabular}{| c | c | c | c | c | c | c | c | c | c | c | c |} \n');
        fprintf(textFile,'\\hline \n');
        fprintf(textFile,'plg  &   plr  &   gSh    &    gSc   &   rSh   &    rSc    &     rsSh   &   rsSc    &   gf     &   rf   &   b       &   os   \\\\ \n');
        fprintf(textFile,'\\hline \n');
        fprintf(textFile,'%.2f    &    %.2f   &  %.2f &  %.2f  &  %.2f    &     %.2f   &   %.2f &   %.2f  &   %.2f  &   %.2f  &  %.2f  &   %.2f  \\\\ \n', ...
                           gaResult(param_ind,1),gaResult(param_ind,2),gaResult(param_ind,3),gaResult(param_ind,4),gaResult(param_ind,5), ...
                           gaResult(param_ind,6),gaResult(param_ind,7),gaResult(param_ind,8),gaResult(param_ind,9),gaResult(param_ind,10), ...
                           gaResult(param_ind,11),gaResult(param_ind,12));
                           
        fprintf(textFile,'\\hline \n');
        fprintf(textFile,'\\end{tabular} \n');








        
%         figure(hFigLogn);
%         subplot(nrow,ncol,param_ind);
%         plot(bincenters, x1tmp,'Color','b', 'LineWidth',1.6);
%         hold on;
%        
%         xlog3 = lognrnd(log3fitR(param_ind,1),log3fitR(param_ind,2),2000,1) + log3fitR(param_ind,3);
%         noBins = floor(max(xlog3)-min(xlog3))/binWidth;
%         [xlog3Tmp, xlog3TmpBinCenters] = hist(xlog3,noBins); xlog3Tmp = xlog3Tmp/length(xlog3);
%         xlog3Tmp = xlog3Tmp / (xlog3TmpBinCenters(2)-xlog3TmpBinCenters(1));
%         plot(xlog3TmpBinCenters, xlog3Tmp, 'g');
%         axis([0 600 0 0.025]);
%         title(sprintf('mu: %.2f s: %.2f, shift %.2f',log3fitR(param_ind,1),log3fitR(param_ind,2),log3fitR(param_ind,3)));
%         xlabel('branch lengths','FontSize',16); ylabel('branchlength frequency','FontSize',16); 
%         
%         figure(hFigLognGA);
%         subplot(nrow,ncol,param_ind);
%         plot(bincenters, x1tmp,'Color','b');
%         hold on;
%         
%         xlog3ga = lognrnd(log3gafitR(param_ind,1),log3gafitR(param_ind,2),2000,1) + log3gafitR(param_ind,3);
%         noBins = floor(max(xlog3ga)-min(xlog3ga))/binWidth;
%         [xlog3gaTmp, xlog3gaTmpBinCenters] = hist(xlog3ga,noBins); xlog3gaTmp = xlog3gaTmp/length(xlog3ga);
%         xlog3gaTmp = xlog3gaTmp / (xlog3gaTmpBinCenters(2)-xlog3gaTmpBinCenters(1));
%         plot(xlog3gaTmpBinCenters, xlog3gaTmp, 'g');
%         axis([0 600 0 0.03]);
%         title(sprintf('mu: %.2f s: %.2f, shift %.2f',log3gafitR(param_ind,1),log3gafitR(param_ind,2),log3gafitR(param_ind,3)));
%         xlabel('branch lengths','FontSize',16); ylabel('branchlength frequency','FontSize',16); 
        
        
        figure(hFig);
        title_string = '';
        for ii=1:options.no_params
            if abs(ii-options.no_params/2) < 1 && ...
                    ((ii>=options.no_params/2 && mod(ii,2) == 0) || ((ii>options.no_params/2 && mod(ii,2) == 1))) 
                title_string = [title_string ' ' options.params{ii,2} ' ' sprintf('%.3f \n',gaResult(param_ind,ii))];
            else
                title_string = [title_string ' ' options.params{ii,2} ' ' sprintf('%.3f',gaResult(param_ind,ii))];
            end
        end
        title_string = [title_string ' ' DIV ': ' sprintf('%.3f',divResult(param_ind))];
       % title(title_string);
        % xlabel('branch lengths','FontSize',16); ylabel('branchlength frequency','FontSize',16);         
  	 xlabel('Segment-length [um]','FontSize',16*font_scale); ylabel('Density','FontSize',16*font_scale);    
    end
    
    if length(divResult) > 1
        axes('Position', [0.03 0.1 0.93 0.8], 'Visible', 'off');
        %cbh = colorbar('YGrid','on');
        cbh = colorbar();
        caxis([min(divResult) max(divResult)]);
        colormap([colors zeros(length(divResult),1) 1-colors]);
        set(cbh,'location','EastOutside');
        set(get(cbh,'ylabel'),'String','Divergence measure');
    end
    
    axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,sprintf('Segment-length distribution based on optimized parameters obtained by GA'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 24*font_scale)
	hL = legend([ax2,ax],'string',{'Biological data','Generated data'});
        set(hL,'Position',  [0.85 0.04 0.12 0.05] ,'Units', 'normalized', 'FontSize',13*font_scale,'FontWeight', 'bold');	  
	h2 = get(hL,'children') ;
%	delete(h2(2)) ;

    set(gcf, 'color', [1 1 1]);
    
    filename = sprintf('lengthFrequencies');
    filenameRelPath = [foldername '/' filename '.pdf'];
%     filenameRelPathfig = [foldername '/' filename '.fig'];
    export_fig(filenameRelPath,'-nofontswap');
%     export_fig(filenameRelPathfig,'-nofontswap');
	saveas(gcf, [foldername '/' filename '.fig'], 'fig');
    clf('reset');
    
%     figure(hFigLogn);
%     axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%     text(0.5, 1,sprintf('Generated data and the fitted 3 parameter lognormal distribution'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 24);
%     filename = sprintf('lengthFrequenciesLog3');
%     filenameRelPath = [foldername '/' filename '.pdf'];
%     export_fig(filenameRelPath);
% 	saveas(gcf, [foldername '/' filename '.fig'], 'fig');
%     clf;
%     
%     figure(hFigLognGA);
%     axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%     text(0.5, 1,sprintf('Generated data and the fitted 3 parameter lognormal distribution with GA'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', 'FontWeight', 'bold', 'FontSize', 24);
%     filename = sprintf('lengthFrequenciesLog3GA');
%     filenameRelPath = [foldername '/' filename '.pdf'];
%     export_fig(filenameRelPath);
% 	saveas(gcf, [foldername '/' filename '.fig'], 'fig');
%     clf;


	fclose(textFile);


end