% gp.gen_distr = '@(p1,p2) gamrnd(p1,p2)';
% gp.res_distr = '@(p1,p2) gamrnd(p1,p2)';
% gp.pl_growth = 0;
% gp.pl_retract = 0;
% gp.growth_p1 = 6;
% gp.growth_p2 = 2;
% gp.retract_p1 = 6;
% gp.retract_p2 = 6;
% gp.r_shape = 10;
% gp.r_scale = 10;
% gp.bias = 0.5;
% gp.g_factor = 0.5;
% gp.r_factor = 0.5;
% gp.version = 2;
% gp.offset = 1.0;
% gp.no_florets = 1;
% 
% addpath(genpath('../common'));
% floret = generateMultipleFlorets(gp);
% 
addpath(genpath('../common'));

data = extractFeaturesSegments('XY_floret_dendrogram.xml');

U = unique(data(:,3));

symf = [];
asymf = [];

for i=1:length(U)
    floret = data(data(:,3) == U(i),:);    
%     if length(floret) > 5 && asymmetry(floret) < 0.3
%         symf = [symf; floret];
%     elseif length(floret) > 10 && asymmetry(floret) > 0.7
%         asymf = [asymf; floret];
%     end

    if length(floret(:,2)) < 10 && length(floret(:,2)) > 5
        cool_floret = floret;
        break;
    end
end
h = gca;
set(h,'Box','off','Visible','off');
plot_tree_dendrogram(cool_floret, 100, 100,'');
%title(sprintf('Asymmetry: %.2f', asymmetry(symfnew)),'FontSize',14, 'FontWeight', 'bold');


% 
% symfnew = symf(1:7,:);
% asymfnew = asymf(31:41,:);
% 
% ax(1) = subplot(1,2,1);
% set(ax(1),'Box','off','Visible','off');
% plot_tree_dendrogram(symfnew, 100, 100);
% 
% title(sprintf('Asymmetry: %.2f', asymmetry(symfnew)),'FontSize',14, 'FontWeight', 'bold');
% ax(2) = subplot(1,2,2);
% set(ax(2),'Box','off','Visible','off');
% plot_tree_dendrogram(asymfnew, 100, 100);
% title(sprintf('Asymmetry: %.2f', asymmetry(asymfnew)),'FontSize',14, 'FontWeight', 'bold');
% 
% axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%         text(0.3, 0.85,sprintf('Asymmetry: %.2f', asymmetry(symfnew)),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', ...
%             'FontWeight', 'bold', 'FontSize', 16);
%         
% axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%         text(0.7, 0.85,sprintf('Asymmetry: %.2f', asymmetry(asymfnew)),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', ...
%             'FontWeight', 'bold', 'FontSize', 16);
        
hFig = figure(1);
%set(hFig, 'Position', [0 0 1400 900]);
set(gcf, 'color', [1 1 1]);

export_fig('dendrogram_segment_depths.pdf');
