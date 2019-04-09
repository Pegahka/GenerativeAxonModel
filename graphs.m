clear;
close all;
mfile_name          = mfilename('fullpath');
[pathstr,name,ext]  = fileparts(mfile_name); % the address of the folder 
                                    % containing this script (graphs.m)
                                    % is taken in 'pathstr' as string. For
                                    % example, It might be
                                    % 'C:/users/someone/somefolder'. This
                                    % address will be called '<main>' in 
                                    % comments from now on.
cd(pathstr); % make <main> current folder
no_plots_given = input('Specify the number of solutions to plot: '); % User will enter number of solutions. User input will be attained to no_plots_given.
while 1
    if (floor(no_plots_given) == no_plots_given) && (no_plots_given>=1) % If input is proper, break out while loop and go on with the user input.
        break;
    else % If the input is not proper, then ask again and again until it is proper and meets the break command above.
        display('The number of plots should be a positive integer');
        no_plots_given = input('Specify the number of plots: ');
    end
end
no_real = input('Specify the number of realizations for the Confidence interval (at least 2) : '); % Similar user input
while 1
    if (floor(no_real) == no_real) && (no_real>1)
        break;
    else
        display('The number of realizations should be an integer greater than 1');
        no_real = input('Specify the number of realizations for the Confidence interval: ');
    end
end
if exist('out/.DS_Store','file') % If there is <main>/out/.DS_Store, delete it.
    delete('out/.DS_Store');
end;
cd 'graphs'; % Make <main>/graphs folder as current folder. This means function calls will be searched in this folder.
if ~exist('matfiles','dir') % If there is no <main>/graphs/matfiles folder, create it.
    mkdir('matfiles');
end
resSetList = dir('../out'); % Take the list of contents of <main>/out folder. They are optimizations performed and saved for different models and at different times. They include optimized parameters
resSetList_ordered=0; % An effective ( there will be some folders passed) counter of folders
for resSetList_i = 1:length(resSetList) % For all optimizations in out folder
    resSetDir = resSetList(resSetList_i).name;
    if ((strcmp(resSetDir,'.') ~= 0) || (strcmp(resSetDir,'..') ~= 0)) % These are folders we are not interested in. 
        continue;
    end;
    resSetList_ordered=resSetList_ordered+1;
    display(['Producing graphs for the solution: ' resSetDir]);
    delete('matfiles/gaResult.mat'); % delete what is inside <main>/graphs/matfiles folder (probably from previous runs)  
    delete('matfiles/gaResultFull.mat'); % and copy the .mat files of our interested optimization
    delete('matfiles/settings.mat'); % from '<main>/out/<model>/Optimized parameters/' to '<main>/graphs/matfiles'. From there, the code will go on.
    copyfile(strcat('../out/',resSetDir,'/Optimized parameters/gaResult.mat'),'matfiles/gaResult.mat');
    copyfile(strcat('../out/',resSetDir,'/Optimized parameters/gaResultFull.mat'),'matfiles/gaResultFull.mat');
    copyfile(strcat('../out/',resSetDir,'/Optimized parameters/settings.mat'),'matfiles/settings.mat');
    cd 'perfloret'; % change the current folder as <main>/graphs/perfloret
    if exist('JS','dir') % If there is JS folder in <main>/graphs/perfloret, delete it.
        rmdir('JS','s');
    end
    mainFull;  % Call <main>/graphs/perfloret/mainFull.m
    if ~exist(strcat('../../out/',resSetDir,'/perfloret'),'dir') % create <main>/out/<model>/perfloret folder if it doesnt exist
        mkdir (strcat('../../out/',resSetDir,'/perfloret/'));
    end
    if exist(strcat('../../out/',resSetDir,'/perfloret/JS'),'dir') % delete <main>/out/<model>/perfloret/JS folder if there is
        rmdir(strcat('../../out/',resSetDir,'/perfloret/JS'),'s');
    end;
    mkdir (strcat('../../out/',resSetDir,'/perfloret/JS')); % create <main>/out/<model>/perfloret/JS folder
    copyfile('JS',strcat('../../out/',resSetDir,'/perfloret/JS')); % copy <main>/graphs/perfloret/JS (outputs of mainFull.m) to <main>/out/<model>/perfloret/JS
    close all;
    clearvars -except no_real pathstr no_plots_given resSetList resSetList_i resSetDir gen_distributions gen_data_perfloret real_data_perfloret resSetList_ordered plot_data_gen_visualisation plot_data_real_visualisation;
    cd '..';
    cd 'visualization'; %change current folder to <main>/graphs/visualization
    delDirs = dir; %contents of current folder into delDirs
    for delDir_i = 1:length(delDirs) %delete folders in <main>/graphs/visualization
        if ((delDirs(delDir_i).isdir==1) && ~strcmp(delDirs(delDir_i).name,'.') && ~strcmp(delDirs(delDir_i).name,'..'))
            rmdir(delDirs(delDir_i).name,'s');
        end
    end
    mainFull; % Call <main>/graphs/visualization/mainFull.m
    if exist(strcat('../../out/',resSetDir,'/Segment-length distribution'),'dir')
        rmdir(strcat('../../out/',resSetDir,'/Segment-length distribution'),'s');
    end
    mkdir (strcat('../../out/',resSetDir,'/Segment-length distribution/')); % (delete if exists and then) create an empty '<main>/out/<model>/Segment-length distribution' folder
    
    delDirs = dir;
    for delDir_i = 1:length(delDirs) % copy folders in <main>/graphs/visualization (fresh outputs of visualization/mainFull.m) into '<main>/out/<model>/Segment-length distribution' folder
        if ((delDirs(delDir_i).isdir==1) && ~strcmp(delDirs(delDir_i).name,'.') && ~strcmp(delDirs(delDir_i).name,'..'))
            copyfile(delDirs(delDir_i).name,strcat('../../out/',resSetDir,'/Segment-length distribution/'));
        end
    end
    save(['../../out/' resSetDir '/Optimized Parameters/gen_distributions'],'gen_distributions'); %Save 'gen_distributions' struct ( created by perfloret/mainFull.m and visualization/mainFull.m) in '<main>/out/<model>/Optimized parameters/' folder as 'gen_distributions.mat'
    close all
    cd ..; % Change the current folder  to <main>/graphs
    plotConvergence([pathstr '/out/' resSetDir]); % Call <main>/graphs/plotConvergence.m with parameter '<main>/out/<modelFolder>'
    close all
    confidence_interval([pathstr '/out/' resSetDir],no_real,no_plots_given); % Call <main>/graphs/confidence_interval.m with parameter '<main>/out/<modelFolder>'
    close all;
    clearvars -except no_real pathstr no_plots_given resSetList resSetList_i resSetDir gen_data_perfloret real_data_perfloret resSetList_ordered plot_data_gen_visualisation plot_data_real_visualisation;
end
cd '..';
