% delete(gcp('nocreate'));
% cluster = parpool('local', 8); % They were commented out because they were closing and opening the cluster. If it is already open, it wastes time in vain. 
                                    %GA algorithm opens a new parallel
                                    %cluster anyways because it is opted in
                                    %settings provided to it.

tic
disp('Computations started...');
%% params
no_gaalg = 1; %(Old comment: level of consistency check. Number of times the algorithm is run.) It has no use


brutusWD = '../out/'; %% (Old comment: absolute path of the directory in which the scripts are) takes the <main>/out to brutusWD as script. It will be used while saving the results .
addpath(brutusWD); % this adds <main>/out folder to pathlist of MATLAB. That way, scripts in <main>/out can be called even if <main>/out is not the 'current folder'

%% params for GA
%% match parameters from divergenceWrapper
load('init.mat'); %(Old comment: loading algorithm settings. This can be reinitialized with the initparams.m script) An init.mat file was copied in <main>/compute before (in mainFull.m script). It is loaded the workspace now. The old comment says init.m can be reinitialized by initparams.m script but it is seemingly written long time ago and lacks new things added.
settings = init; % just the name changed. settings (what is loaded from init.mat) contains model settings
settings.no_florets = no_florets_given; % we apply number of florets and generations (what is inputted by user in user interface in mainFull.m) into the settings
settings.gaoptions.Generations = no_generations_given;
%% fitness functions

%% initializing fitness functions with different divergence metrics
    
jsObject =  '@(param) divergenceWrapper(param,settings,@(x,y) shannonjensen(x,y))'; % GA fitness function. It will be given to GA as a parameter. The script is in <main>/compute folder.


%% js
settings.divObject = jsObject; % fitness function is added to 'settings' struct.

%% waiting for results, saving results
res = cell(6,2); % It will be an output. It will contain only the very best solution's parameters.
results_full = struct; % It will be another output. It will contain everything about the GA algorithm performed.
%They are seemingly meant to contain KL Simple, KL Reverse and JS (I think
%they are divergence types) but only JS is used in this code. KL types are
%empty.
res{1,1} = '';
results_full.kl = struct;
res{1,2} = 'KL Simple';

res{2,1} = '';
results_full.klrev = struct;
res{2,2} = 'KL Reverse';

output = optWrapper(settings); %call optWrapper.m script in <main>/compute folder with settings parameter. There, GA will be run.
res{3,1} = output.optResult; 
results_full.js = output;
res{3,2} = 'JS';
display(['Achieved value is ' num2str(output.fval) '.']); %show the score: 'output.fval': it is what is tried to be minimized. The smaller, the better.


%% saving results

timeStamp = datestr(now,30); % getting timestamp as unique identifier of the run

folder_name = [settings.title timeStamp]; % saving together with the title set in model setting (in init.m file)

mkdir(brutusWD, folder_name); % Make a folder with the name of the model and timestamp. We are sure that there is no folder there with the same name because of the time identifier.
mkdir([brutusWD folder_name],'Optimized parameters'); % make a folder inside it and save the outputs there (below)
save([brutusWD folder_name '/Optimized parameters/gaResult'],'res'); % saving the results
save([brutusWD folder_name '/Optimized parameters/gaResultFull'],'results_full'); % saving the results
save([brutusWD folder_name '/Optimized parameters/settings'],'settings'); % saving the run parameters. This will important when creating plots


%%%matlabpool close force BrutusLSF8h % closing matlab pool
disp('Computations finished');
toc % measuring time...