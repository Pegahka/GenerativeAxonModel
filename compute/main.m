% delete(gcp('nocreate'));
% cluster = parpool('local', 8);

tic
disp('Computations started...');
%% params
no_gaalg = 1; %level of consistency check. Number of times the algorithm is run.


brutusWD = '../out/'; %% absolute path of the directory in which the scripts are
addpath(brutusWD);

%% params for GA
%% match parameters from divergenceWrapper
load('init.mat'); % loading algorithm settings. This can be reinitialized with the initparams.m script
settings = init;
settings.no_florets = no_florets_given;
settings.gaoptions.Generations = no_generations_given;
%% fitness functions

%% initializing fitness functions with different divergence metrics
    
jsObject =  '@(param) divergenceWrapper(param,settings,@(x,y) shannonjensen(x,y))';


%% js
settings.divObject = jsObject;

%% waiting for results, saving results
res = cell(6,2);
results_full = struct;

res{1,1} = '';
results_full.kl = struct;
res{1,2} = 'KL Simple';

res{2,1} = '';
results_full.klrev = struct;
res{2,2} = 'KL Reverse';

output = optWrapper(settings);
res{3,1} = output.optResult;
results_full.js = output;
res{3,2} = 'JS';
display(['Achieved value is ' num2str(output.fval) '.']);


%% saving results

timeStamp = datestr(now,30); % getting timestamp as unique identifier of the run

folder_name = [settings.title timeStamp]; % saving toghether with the title set in initparams.m

mkdir(brutusWD, folder_name); %
mkdir([brutusWD folder_name],'Optimized parameters');
save([brutusWD folder_name '/Optimized parameters/gaResult'],'res'); % saving the results
save([brutusWD folder_name '/Optimized parameters/gaResultFull'],'results_full'); % saving the results
save([brutusWD folder_name '/Optimized parameters/settings'],'settings'); % saving the run parameters. This will important when creating plots


%%%matlabpool close force BrutusLSF8h % closing matlab pool
disp('Computations finished');
toc % measuring time...