X = normrnd(0,1,1000,1);

[fl,xl] = estimate_bins(X,10000);
[fs,xs] = estimate_bins(X,3);
hFig = figure(1);
subplot(1,2,1);
[nl,xl] = hist(X,1000);
bar(xl,nl/(sum(nl)*(xl(2) - xl(1))),(xl(2)-xl(1)),'FaceColor',[0,122,0]/255,'EdgeColor',[0,122,0]/255);
xlabel('events','FontSize',18); ylabel('fequency','FontSize',18); title('Overfitting','FontSize',18);
subplot(1,2,2);
[ns,xs] = hist(X,3);
bar(xs,ns/(sum(ns)*(xs(2) - xs(1))),(xs(2)-xs(1)),'FaceColor',[0,122,0]/255,'EdgeColor',[0,122,0]/255);
xlabel('events','FontSize',18); ylabel('fequency','FontSize',18); title('Underfitting','FontSize',18);
set(gcf, 'color', [1 1 1]);
axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
        text(0.5, 1,sprintf('Illustration of over- and underfitting data when estimating its density'),'HorizontalAlignment' ,'center','VerticalAlignment', 'top', ...
             'FontSize', 20);    
set(hFig, 'Position', [0 0 1400 900]);
export_fig('density_fitting.pdf');