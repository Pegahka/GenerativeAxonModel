clear;
close all;
mfile_name          = mfilename('fullpath');
[pathstr,name,ext]  = fileparts(mfile_name);
path_old=cd(pathstr);

initSetList = dir('out');
count = 0;
for i = 1:length(initSetList)
    initSetDir = initSetList(i).name;
    if ~initSetList(i).isdir || ((strcmp(initSetDir,'.') ~= 0) || (strcmp(initSetDir,'..') ~= 0) || (strcmp(initSetDir,'.DS_Store') ~= 0))
        continue;
    else
        count = count + 1;
        outputName{count} = initSetDir;  % get name of all models
    end
end
numSetList=length(outputName);
display('Please choose an optimized model or biological data:');
fprintf(' 0 stands for biological data \n');
for i=1:numSetList
    fprintf(' %d stands for the model: %s \n',i, outputName{i});
end
modelInput = input('Enter a number: ');

while (~isnumeric(modelInput) || ~isinf(modelInput))
    if (floor(modelInput) == modelInput) && (modelInput<=numSetList) && (modelInput>=0)
        if modelInput==0
            display('You have chosen the biological data for visualisation');
        else
            fprintf('You have chosen the *%s* model for visualisation\n', outputName{modelInput});
        end
        break;
    else
        fprintf('Wrong value!! Please enter an integer in range [0, %d]:',numSetList);
        modelInput = input('');
    end
end

display('Please choose a file format:');
display(' 1 stands for .fig');
display(' 2 stands for .jpg');
display(' 3 stands for .pdf');
type = input('Enter a number: ');
while 1
    if isnumeric(type) && (floor(type)==type) && (type>=1) && (type<=3)
        if type==1
            typestr='fig';
        elseif type==2
            typestr='jpg';
        elseif type==3
            typestr='pdf';
        end
        display(['You have chosen .' typestr]);
        break;
    else
        display('Wrong value!! Try again.');
        type = input('');
    end
end

addpath(genpath('graphs/common/'));

if modelInput==0
    real_data = extractFeaturesSegments('XY_floret_dendrogram.xml');
    floretIDs=unique(real_data(:,3));
    display(['There are ' num2str(length(floretIDs)) ' florets:']);
    display(' 1. Draw all');
    display(' 2. I will select one');
    all_or_1=input('Enter 1 or 2: ');
    while 1
        if (all_or_1==1) || (all_or_1==2)
            break;
        else
            all_or_1=input('Enter 1 or 2: ');
        end
    end
    
    if (all_or_1==1)
        display('All florets will be drawn.')
        floretIDs_selected=floretIDs;
    elseif (all_or_1==2)
        display(['Available Floret IDs : ' num2str(floretIDs')]);
        floretIDs_selected = input('Select a Floret ID: ');
        while 1
            if ismember(floretIDs_selected,floretIDs)
                display(['Floret ' num2str(floretIDs_selected) ' is selected.']);
                break;
            else
                display('This ID is not available!');
                floretIDs_selected = input('Select a Floret ID: ');
            end
        end
    end
    
    for k=1:length(floretIDs_selected)
        d{1,k}=real_data( real_data(:,3)==floretIDs_selected(k) ,:);
    end
else
    load([pathstr '\out\' outputName{modelInput} '\Optimized parameters\gen_distributions.mat']);
    fl_nm_gen_distr=fieldnames(gen_distributions);
    M=numel(fl_nm_gen_distr);
    solutions=[];
    for m=1:M
        if strfind(fl_nm_gen_distr{m},'Solution_')==1
            m_=str2num(fl_nm_gen_distr{m}(10:end));
            if length(m_)==1
                solutions=[solutions m_];
            end
        end
    end
    clear m
    clear m_
    no_solns=length(solutions);
    soln_selected= input(['Select a solution: ' num2str(solutions) ' are available: ']);
    while 1
        if ismember(soln_selected,solutions)
            display(['Solution ' num2str(soln_selected) ' is selected.']);
            break;
        else
            display('It is not available!');
            soln_selected= input(['Select a solution: ' num2str(solutions) ' are available: ']);
        end
    end
    if isfield(gen_distributions.(['Solution_' num2str(soln_selected)]),'Gen_tree_vis')
        d_temp=gen_distributions.(['Solution_' num2str(soln_selected)]).Gen_tree_vis;
    else
        error('Related information could not be found. Selected optimization might be from an older version.');
    end
    floretIDs=unique(d_temp(:,3));
    display(['There are ' num2str(length(floretIDs)) ' florets:']);
    display(' 1. Draw all');
    display(' 2. I will select one');
    all_or_1=input('Enter 1 or 2: ');
    while 1
        if (all_or_1==1) || (all_or_1==2)
            break;
        else
            all_or_1=input('Enter 1 or 2: ');
        end
    end
    
    if (all_or_1==1)
        display('All florets will be drawn.')
        floretIDs_selected=floretIDs;
    elseif (all_or_1==2)
        display(['Available Floret IDs : ' num2str(floretIDs')]);
        floretIDs_selected = input('Select a Floret ID: ');
        while 1
            if ismember(floretIDs_selected,floretIDs)
                display(['Floret ' num2str(floretIDs_selected) ' is selected.']);
                break;
            else
                display('This ID is not available!');
                floretIDs_selected = input('Select a Floret ID: ');
            end
        end
    end
    
    for k=1:length(floretIDs_selected)
        d{1,k}=d_temp( d_temp(:,3)==floretIDs_selected(k) ,:);
    end
end

if modelInput==0
    if ~exist([pathstr '/graphs/BiologicalDendrograms'],'dir')
        mkdir([pathstr '/graphs/BiologicalDendrograms']);
    end
    if ~exist([pathstr '/graphs/BiologicalDendrograms/' typestr],'dir')
        mkdir([pathstr '/graphs/BiologicalDendrograms/' typestr]);
    end
else
    if ~exist([pathstr '/out/' outputName{modelInput} '/Dendrograms'],'dir')
        mkdir([pathstr '/out/' outputName{modelInput} '/Dendrograms']);
    end
    if ~exist([pathstr '/out/' outputName{modelInput} '/Dendrograms/Solution_' num2str(soln_selected)],'dir')
        mkdir([pathstr '/out/' outputName{modelInput} '/Dendrograms/Solution_' num2str(soln_selected)]);
    end
    if ~exist([pathstr '/out/' outputName{modelInput} '/Dendrograms/Solution_' num2str(soln_selected) '/' typestr],'dir')
        mkdir([pathstr '/out/' outputName{modelInput} '/Dendrograms/Solution_' num2str(soln_selected) '/' typestr]);
    end
end


fig=figure;
for floret=1:size(d,2)
    clf(fig,'reset');
    hold on;
    d_=d{1,floret};
    A=zeros(size(d_,1),size(d_,1));
    for k=2:size(d_,1)
        c=find(d_(1:k,1)==(d_(k)-1));
        e=max(c);
        A(k,e)=1;
    end
    
    maxdepth=max(d_(:,1));
    up=1;
    down=-1;
    plot([0 d_(1,2)], [0 0],'k');
    segmentends=[d_(1,2) 0];
    for k=2:size(d_,1);
        m=find(A(k,:));
        if sum(A(1:(k-1),m))==1
            dir=down;
        else
            dir=up;
        end
        dir=dir*2^(maxdepth+1-d_(k,1));
        plot([1 1]*segmentends(m,1), [0 dir]+segmentends(m,2),'k');
        plot([0 d_(k,2)]+segmentends(m,1), [dir dir]+segmentends(m,2),'k');
        segmentends(k,:)=[d_(k,2)+segmentends(m,1) dir+segmentends(m,2)];
    end
    
    set(gca,'ytick',[])
    ylength=max(1,1.1*max(abs(segmentends(:,2))));
    axis([0 inf -ylength ylength]);
    title(['Floret ' num2str(floretIDs_selected(floret))]);
    xlabel('Length (microns)');
    %Save
    if modelInput==0
        saveas(gcf,[pathstr '/graphs/BiologicalDendrograms/' typestr '/' num2str(floretIDs_selected(floret)) '.' typestr]);
    else
        saveas(gcf,[pathstr '/out/' outputName{modelInput} '/Dendrograms/Solution_' num2str(soln_selected) '/' typestr '/' num2str(floretIDs_selected(floret)) '.' typestr]);
    end
end

if size(d,2)==1
    if modelInput==0
        display(['Saved as "' pathstr '/graphs/BiologicalDendrograms/' typestr '/' num2str(floretIDs_selected(floret)) '.' typestr '"']);
    else
        display(['Saved as "' pathstr '/out/' outputName{modelInput} '/Dendrograms/Solution_' num2str(soln_selected) '/' typestr '/' num2str(floretIDs_selected(floret)) '.' typestr '"']);
    end    
else
    if modelInput==0
        display(['Saved in "' pathstr '/graphs/BiologicalDendrograms/' typestr '"']);
    else
        display(['Saved in "' pathstr '/out/' outputName{modelInput} '/Dendrograms/Solution_' num2str(soln_selected) '/' typestr '"']);
    end
    close(fig);
end
cd(path_old);