tic
disp('Started...');
%% params
no_gaalg = 1; %level of consistency check. Number of times the algorithm is run.

addpath(genpath('./common'));

% parallel.importProfile('/cluster/apps/matlab/support/BrutusLSF8h.settings'); %% import the the matlab cluster settings recommended bz brutus
% cluster = parcluster('BrutusLSF8h'); 
% cluster.SubmitArguments = '-W "30:00" -R "rusage[mem=3000]"'; %% overriding some settings: runtime limit and memory usage limit
% matlabpool(cluster,6,'AttachedFiles',{brutusWD}); %% requesting 10 workers. There's a worker for every fitness function. Each workers executes no_gaalg tasks.

%% params for GA
%% match parameters from divergenceWrapper
load('init.mat'); % loading algorithm settings. This can be reinitialized with the initparams.m script
settings = init;
%% fitness functions

%% initializing fitness functions with different divergence metrics

klObject = '@(param) divergenceWrapper(param,settings,@(x,y) kldivergence(x,y))';
klRevObject =  '@(param) divergenceWrapper(param,settings,@(x,y) kldivergence(y,x))';
jsObject =  '@(param) divergenceWrapper(param,settings,@(x,y) shannonjensen(x,y))';
klksObject = '@(param) divergenceWrapper(param,settings,@(x,y) kldivergenceks(x,y))';
klksrevObject = '@(param) divergenceWrapper(param,settings,@(x,y) kldivergenceks(y,x))';
jsksObject =  '@(param) divergenceWrapper(param,settings,@(x,y) shannonjensenks(x,y))';

%%%%%%%%%%%
%% local env
settings.divObject = jsksObject;
settings.gaoptions.UseParallel = 'never'
res = optWrapper(settings);
return

%%%%%%%%%%%
%% js ks
settings.divObject = jsksObject;
jobJSks = createJob(cluster,'AttachedFiles',{brutusWD});
for i=2*no_gaalg + 1:3*no_gaalg
    createTask(jobJSks, @optWrapper,1,{settings});
end
submit(jobJSks);


%% kl ks rev
settings.divObject = klksrevObject;
jobKLKSrev = createJob(cluster,'AttachedFiles',{brutusWD});
for i=no_gaalg + 1:2*no_gaalg
    createTask(jobKLKSrev, @optWrapper,1,{settings});
end
submit(jobKLKSrev);

%% kl ks
settings.divObject = klksObject;
jobKLKS = createJob(cluster,'AttachedFiles',{brutusWD});
for i=no_gaalg + 1:2*no_gaalg
    createTask(jobKLKS, @optWrapper,1,{settings});
end
submit(jobKLKS);

%% kl simple
settings.divObject = klObject; 
jobKL = createJob(cluster,'AttachedFiles',{brutusWD}); %creating job with KL 
for i=1:no_gaalg
    createTask(jobKL, @optWrapper,1,{settings}); % adding tasks to job. The number of tasks corresponds to the number of repetitions
end
submit(jobKL); % submitting job to worker
 
%% kl reverse
settings.divObject = klRevObject;
jobKLRev = createJob(cluster,'AttachedFiles',{brutusWD});
for i=no_gaalg + 1:2*no_gaalg
    createTask(jobKLRev, @optWrapper,1,{settings});
end
submit(jobKLRev);


%% js
settings.divObject = jsObject;
jobJS = createJob(cluster,'AttachedFiles',{brutusWD});
for i=2*no_gaalg + 1:3*no_gaalg
    createTask(jobJS, @optWrapper,1,{settings});
end
submit(jobJS)


%% waiting for results, saving results
res = cell(6,2);
results_full = struct;


wait(jobKL,'finished'); % the script stops here until 'jobKL' finishes
output = fetchOutputs(jobKL); %jobKL finished fetching the results
res{1,1} = output{1}.optResult;
res{1,2} = 'KL Simple';
results_full.kl = output;

wait(jobKLRev,'finished');
output = fetchOutputs(jobKLRev);
res{2,1} = output{1}.optResult;
results_full.klrev = output;
res{2,2} = 'KL Reverse';

wait(jobJS,'finished');
output = fetchOutputs(jobJS);
res{3,1} = output{1}.optResult;
results_full.js = output;
res{3,2} = 'JS';

wait(jobKLKS,'finished'); 
output = fetchOutputs(jobKLKS); 
res{4,1} = output{1}.optResult;
res{4,2} = 'KL Ks';
results_full.klks = output;

wait(jobKLKSrev,'finished');
output = fetchOutputs(jobKLKSrev);
res{5,1} = output{1}.optResult;
resuts_full.klrevks = output;
res{5,2} = 'KL Ks reverse';

wait(jobJSks,'finished');
output = fetchOutputs(jobJSks);
res{6,1} = output{1}.optResult;
results_full.jsks = output;
res{6,2} = 'JS Ks';

%% saving results

timeStamp = datestr(now,30); % getting timestamp as unique identifier of the run 

folder_name = [settings.title timeStamp]; % saving toghether with the title set in initparams.m

mkdir(brutusWD,folder_name); %

save([brutusWD folder_name '/gaResult'],'res'); % saving the results 
save([brutusWD folder_name '/gaResultFull'],'results_full'); % saving the results 
save([brutusWD folder_name '/settings'],'settings'); % saving the run parameters. This will important when creating plots
delete(jobKL); % deleting jobs
delete(jobKLRev);
delete(jobKLKS);
delete(jobKLKSrev);
delete(jobJSks);
delete(jobJS);

matlabpool close force BrutusLSF8h % closing matlab pool 
toc % measuring time...
