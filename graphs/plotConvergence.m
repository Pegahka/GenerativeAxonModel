function plotConvergence(path)
% path : The path of the folder containing 'gaResultFull.mat' as a string.
if path(end)=='/'
    path(end)=[];
end
oldpath=cd(path);
if exist('Optimized parameters/gaResultFull.mat','file')
    load('Optimized parameters/gaResultFull.mat');
else
    display('Convergence could not be plotted: ''gaResultFull.mat'' could not be found in provided path.');
    cd(oldpath);
    return;
end
if isfield(results_full.js,'best_thru_iterations') && isfield(results_full.js,'mean_thru_iterations')
    best=results_full.js.best_thru_iterations;
    mean=results_full.js.mean_thru_iterations;
else
    display('Convergence could not be plotted: Related fields could not be found in ''gaResultFull.mat''. GA output might be an older version.')
    cd(oldpath);
    return;
end
figure;
plot(0:(length(best)-1),best,'LineWidth',2);
hold on;
plot(0:(length(mean)-1),mean,'LineWidth',2);
title({'Convergence of Genetic Algorithm'; ['Final Iteration: Best Solution = ' num2str(best(end)) ' , Mean Solution= ' num2str(mean(end))]},'FontSize', 24)
xlabel('Number of Generations','FontSize', 24);
ylabel('Jensen-Shannon Divergence','FontSize', 24);
axis([0 (max(length(best),length(mean))-1) 0 ceil(10*max(best))/10]);
%legend('Lowest Divergence of Iteration','Mean Divergence of Iteration');

legend({'Lowest Divergence of Iteration','Mean Divergence of Iteration'},'FontSize',14)
if exist([path '/Convergence'],'dir')
    rmdir([path '/Convergence'],'s');
end;
mkdir([path '/Convergence']);
cd ..
cd ..
cd graphs
cd common
cd export_fig
if exist('export_fig.m')
    export_fig([path '/Convergence/convergence.pdf'],'-nofontswap');
    export_fig([path '/Convergence/convergence.fig'],'-nofontswap');
else
    display('Convergence plot could not be exported: ''export_fig.m'' could not be found.');
end
close all
cd(oldpath);
end