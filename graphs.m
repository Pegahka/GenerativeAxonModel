clear;
close all;
mfile_name          = mfilename('fullpath');
[pathstr,name,ext]  = fileparts(mfile_name);
cd(pathstr);
no_plots_given = input('Specify the number of solutions to plot: ');
while 1
    if (floor(no_plots_given) == no_plots_given) && (no_plots_given>=1)
        break;
    else
        display('The number of plots should be a positive integer');
        no_plots_given = input('Specify the number of plots: ');
    end
end
no_real = input('Specify the number of realizations for the Confidence interval (at least 2) : ');
while 1
    if (floor(no_real) == no_real) && (no_real>1)
        break;
    else
        display('The number of realizations should be an integer greater than 1');
        no_real = input('Specify the number of realizations for the Confidence interval: ');
    end
end
if exist('out/.DS_Store','file')
    delete('out/.DS_Store');
end;
cd 'graphs';
if ~exist('matfiles','dir')
    mkdir('matfiles');
end
resSetList = dir('../out');
resSetList_ordered=0;
for resSetList_i = 1:length(resSetList)
    resSetDir = resSetList(resSetList_i).name;
    if ((strcmp(resSetDir,'.') ~= 0) || (strcmp(resSetDir,'..') ~= 0))
        continue;
    end;
    resSetList_ordered=resSetList_ordered+1;
    display(['Producing graphs for the solution: ' resSetDir]);
    delete('matfiles/gaResult.mat');
    delete('matfiles/gaResultFull.mat');
    delete('matfiles/settings.mat');
    copyfile(strcat('../out/',resSetDir,'/Optimized parameters/gaResult.mat'),'matfiles/gaResult.mat');
    copyfile(strcat('../out/',resSetDir,'/Optimized parameters/gaResultFull.mat'),'matfiles/gaResultFull.mat');
    copyfile(strcat('../out/',resSetDir,'/Optimized parameters/settings.mat'),'matfiles/settings.mat');
    cd 'perfloret';
    if exist('JS','dir')
        rmdir('JS','s');
    end;
    mainFull;
    if ~exist(strcat('../../out/',resSetDir,'/perfloret'),'dir')
        mkdir (strcat('../../out/',resSetDir,'/perfloret/'));
    end
    if exist(strcat('../../out/',resSetDir,'/perfloret/JS'),'dir')
        rmdir(strcat('../../out/',resSetDir,'/perfloret/JS'),'s');
    end;
    mkdir (strcat('../../out/',resSetDir,'/perfloret/JS'));
    copyfile('JS',strcat('../../out/',resSetDir,'/perfloret/JS'));
    close all;
    clearvars -except no_real pathstr no_plots_given resSetList resSetList_i resSetDir gen_distributions gen_data_perfloret real_data_perfloret resSetList_ordered plot_data_gen_visualisation plot_data_real_visualisation;
    cd '..';
    cd 'visualization';
    delDirs = dir;
    for delDir_i = 1:length(delDirs)
        if ((delDirs(delDir_i).isdir==1) && ~strcmp(delDirs(delDir_i).name,'.') && ~strcmp(delDirs(delDir_i).name,'..'))
            rmdir(delDirs(delDir_i).name,'s');
        end
    end
    mainFull;
    if exist(strcat('../../out/',resSetDir,'/Segment-length distribution'),'dir')
        rmdir(strcat('../../out/',resSetDir,'/Segment-length distribution'),'s');
    end
    mkdir (strcat('../../out/',resSetDir,'/Segment-length distribution/'));
    
    delDirs = dir;
    for delDir_i = 1:length(delDirs)
        if ((delDirs(delDir_i).isdir==1) && ~strcmp(delDirs(delDir_i).name,'.') && ~strcmp(delDirs(delDir_i).name,'..'))
            copyfile(delDirs(delDir_i).name,strcat('../../out/',resSetDir,'/Segment-length distribution/'));
        end
    end
    save(['../../out/' resSetDir '/Optimized Parameters/gen_distributions'],'gen_distributions');
    close all
    cd ..;
    plotConvergence([pathstr '/out/' resSetDir]);
    close all
    confidence_interval([pathstr '/out/' resSetDir],no_real,no_plots_given);
    close all;
    clearvars -except no_real pathstr no_plots_given resSetList resSetList_i resSetDir gen_data_perfloret real_data_perfloret resSetList_ordered plot_data_gen_visualisation plot_data_real_visualisation;
end
cd '..';
