gp.gen_distr = '@(p1,p2) gamrnd(p1,p2)';
gp.res_distr = '@(p1,p2) gamrnd(p1,p2)';
gp.pl_growth = 5;
gp.pl_retract = 5;
gp.growth_p1 = 6;
gp.growth_p2 = 6;
gp.retract_p1 = 6;
gp.retract_p2 = 6;
gp.r_shape = 10;
gp.r_scale = 10;
gp.bias = 0.6;
gp.g_factor = 0.5;
gp.r_factor = 0.0; %0.3 with ;  0.0 without retraction
gp.version = 2;
gp.offset = 0.0;
gp.no_florets = 500;

addpath(genpath('../common'));
outM = generateMultipleFlorets(gp);
% load out_ret.csv
 load out.csv
%out = out_ret;

hFig = figure(1);
[Fj, Xj] = estimate_bins(out(:,2));
[Fm, Xm] = estimate_bins(outM(:,2));

plot(Xj, Fj,'b'); hold on;
plot(Xm, Fm,'g'); 

legend({'cx3d','matlab'});

set(hFig, 'Position', [0 0 1400 900], 'FontSize',10);
set(gcf, 'color', [1 1 1]);
xlabel('branch lengths'); ylabel('frequency');

title(sprintf('Comparison of the estimated segment-length densities from CX3D and MATLAB \n (version without retraction)'),'FontSize',16,'FontWeight','bold');
export_fig('comparedensities.pdf');
export_fig('comparedensities.png');

