function initparams()
clear;
addpath(genpath('./common'));

outlier_bound = 700; %the upper limit for branchlength, which are considered in the optimization

% lower and upper bound contraints for the parameters. This should be set
% considering the parameter types set in paramsTmp.
init.lb = [0  0   0   0    0    0    0   0   0  0 0.5  0];
init.ub = [0  0 100 100  100  100   20  20   1  1  1   0];

% number of parameters used for the optimization
init.no_params = length(init.ub);

% setting linear constraints for the genetic algorithm:
% this is useful when imposing constraints like param 1 > param 2
init.A = zeros(init.no_params, init.no_params);
init.A(1,3) = -1;
init.A(1,4) = -1;
% init.A(2,3) = 1;
% init.A(2,5) = -1;
% init.A(3,4) = 1;
% init.A(3,6) = -1;
init.b = [-1 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01];
init.b = init.b';
%init.A = [];
%init.b = [];
init.no_florets = 300;

paramsTmp = cell(init.no_params,2);

% types of parameters
paramsTmp{1,1} = 'pl_growth'; paramsTmp{1,2} = 'plg'; paramsTmp{1,3} = 'pl growth';
paramsTmp{2,1} = 'pl_retract'; paramsTmp{2,2} = 'plr'; paramsTmp{2,3} = 'pl retract';
paramsTmp{3,1} = 'growth_p1'; paramsTmp{3,2} = 'gSh'; paramsTmp{3,3} = 'growth Sh';
paramsTmp{4,1} = 'growth_p2'; paramsTmp{4,2} = 'gSc'; paramsTmp{4,3} = 'growth Sc';
paramsTmp{5,1} = 'retract_p1'; paramsTmp{5,2} = 'rSh'; paramsTmp{5,3} = 'retract Sh';
paramsTmp{6,1} = 'retract_p2'; paramsTmp{6,2} = 'rSc'; paramsTmp{6,3} = 'retract Sc';
paramsTmp{7,1} = 'r_shape'; paramsTmp{7,2} = 'rsSh'; paramsTmp{7,3} = 'resource Sh';
paramsTmp{8,1} = 'r_scale'; paramsTmp{8,2} = 'rsSc'; paramsTmp{8,3} = 'resource Sc';
paramsTmp{9,1} = 'g_factor'; paramsTmp{9,2} = 'gf'; paramsTmp{9,3} = 'g Factor';
paramsTmp{10,1} = 'r_factor'; paramsTmp{10,2} = 'rf'; paramsTmp{10,3} = 'r Factor';
paramsTmp{11,1} = 'bias'; paramsTmp{11,2} = 'b'; paramsTmp{11,3} = 'bias';
paramsTmp{12,1} = 'offset'; paramsTmp{12,2} = 'os'; paramsTmp{12,3} = 'offset';

init.params = paramsTmp;
init.generator_version = 2;

% genetic algorithm specifics settings

init.gaoptions = gaoptimset('PopulationSize',5*init.no_params,'Generations',10*init.no_params, ...
    'UseParallel','always','PopInitRange',[init.lb;init.ub],'EliteCount',5); 

%%data
% preprocess data
originalData = extractFeaturesSegments('XY_floret_dendrogram.xml');

init.weightedasymmetry = 1;

if (isfield(init,'weightedasymmetry'))
    init.asymmetry = asymmetries(originalData,1);
else
    init.asymmetry = asymmetries(originalData);
end

init.alpha = 0.90;

originalData = originalData(originalData(:,2)<outlier_bound,:);
originalData = originalData(originalData(:,2)>=1,:);

init.real_data = originalData(:,2);
init.gen_distr = '@(p1,p2) gamrnd(p1,p2)';
init.res_distr = '@(p1,p2) gamrnd(p1,p2)';


init.title = 'random';

%%save
save('init','init');