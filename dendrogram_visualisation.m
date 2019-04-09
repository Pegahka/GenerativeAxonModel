clear;
close all;
mfile_name          = mfilename('fullpath');
[pathstr,name,ext]  = fileparts(mfile_name); %pathstr contains the address of the folder containing this script (dendrogram_visualisation.m) as a string.
                                             %pathstr will be mentioned as
                                             %'<main>' in comments from now
                                             %on
path_old=cd(pathstr); %cd to <main>. old cd is held in path_old. It will be returned at the end of this script.

initSetList = dir('out'); % contents of the folder <main>/out in initSetlist as a struct. It has fields such as 'name', 'isdir' for each folder/file in <main>/out
count = 0; %effective counter of folders which are optimized models created by compute.m . For others; counter will not increment.
for i = 1:length(initSetList)
    initSetDir = initSetList(i).name; % take the name of the related folder/file to be checked if it is a model or not
    if ~initSetList(i).isdir || ((strcmp(initSetDir,'.') ~= 0) || (strcmp(initSetDir,'..') ~= 0) || (strcmp(initSetDir,'.DS_Store') ~= 0)) % if it is NOT a model
        continue; % do nothing
    else % if it is a model
        count = count + 1;  
        outputName{count} = initSetDir;  % get the name of model
    end
end
numSetList=length(outputName); % the number of models equals to the length of outputName
display('Please choose an optimized model or biological data:'); %List the options and ask user to select one
fprintf(' 0 stands for biological data \n'); 
for i=1:numSetList
    fprintf(' %d stands for the model: %s \n',i, outputName{i});
end

modelInput = input('Enter a number: '); %ask user to select one
while (~isnumeric(modelInput) || ~isinf(modelInput)) % ask again until it is proper and until the break command below
    if (floor(modelInput) == modelInput) && (modelInput<=numSetList) && (modelInput>=0) % If the user input is proper
        if modelInput==0
            display('You have chosen the biological data for visualisation');
        else
            fprintf('You have chosen the *%s* model for visualisation\n', outputName{modelInput});
        end
        break; % exit the while loop because a proper input is achieved
    else % If the user input is not proper; ask again
        fprintf('Wrong value!! Please enter an integer in range [0, %d]:',numSetList);
        modelInput = input('');
    end
end

display('Please choose a file format:'); % ask the file format
display(' 1 stands for .fig');
display(' 2 stands for .jpg');
display(' 3 stands for .pdf');
type = input('Enter a number: '); % wait an input. 
while 1 % ask again until it is proper and until the break command below
    if isnumeric(type) && (floor(type)==type) && (type>=1) && (type<=3) % If the input is proper, exit the while loop with break command
        if type==1
            typestr='fig'; % typestr will be used as user selection later. It is actually needed in string format, so it is held in string format
        elseif type==2
            typestr='jpg';
        elseif type==3
            typestr='pdf';
        end
        display(['You have chosen .' typestr]);
        break;
    else % If the input is not proper, ask again
        display('Wrong value!! Try again.');
        type = input('');
    end
end

addpath(genpath('graphs/common/')); % To be able to use extractFeaturesSegments.m in <main>/graphs/common

if modelInput==0 % If the user wants real (biological) data
    real_data = extractFeaturesSegments('XY_floret_dendrogram.xml'); % real data is taken. Its columns are depth-SegmentLength-FloretID
    floretIDs=unique(real_data(:,3)); % Unique FloretID's are taken. length of floretIDs is equal to number of biological florets (trees). 
    display(['There are ' num2str(length(floretIDs)) ' florets:']);
    display(' 1. Draw all'); % we can draw all 
    display(' 2. I will select one'); % or we can ask user to select one
    all_or_1=input('Enter 1 or 2: '); % user must input 1 or 2
    while 1
        if (all_or_1==1) || (all_or_1==2) % if user input 1 or 2, it is ok, exit the while loop
            break;
        else % if user didnt input 1 or 2, it is not ok, ask again
            all_or_1=input('Enter 1 or 2: ');
        end
    end
    
    if (all_or_1==1) %this block is for selecting 'floretIDs_selected'. Later, florets whose IDs are present in this array will be drawn.
        display('All florets will be drawn.')
        floretIDs_selected=floretIDs;
    elseif (all_or_1==2)
        display(['Available Floret IDs : ' num2str(floretIDs')]); % list all the floret ID's available. (they are not sorted, there are empty numbers, so we should list them)
        floretIDs_selected = input('Select a Floret ID: '); % ask the floret ID if user wanted to select one
        while 1 % ask again until the input is ok
            if ismember(floretIDs_selected,floretIDs) % If user inputs an ID which is in the list of available IDs; it is ok, exit the while loop
                display(['Floret ' num2str(floretIDs_selected) ' is selected.']);
                break;
            else % If the user inputs an unavailable ID, ask again.
                display('This ID is not available!');
                floretIDs_selected = input('Select a Floret ID: ');
            end
        end
    end
    
    for k=1:length(floretIDs_selected) % floret information ( depth-segment length) is concatenated vertically in real_data. We take selected florets and put it in the cells of 'd' separately. 
        d{1,k}=real_data( real_data(:,3)==floretIDs_selected(k) ,:); %d{1,k}=rows of real_data whose 3rd column is equal to floretIDs_selected(k) (that is; information (depth&segmentLength) of ONE floret)
        % later we will give each cell of 'd' one by one to a code that draws one floret
    end
else % If the user wants one of the optimized models (generated data)
    load([pathstr '/out/' outputName{modelInput} '/Optimized parameters/gen_distributions.mat']); %<main>/out/<model>/Optimized parameters/gen_distributions.mat
    % 'gen_distributions' contains the florets generated and used in Segment Lengths
    % plots. ( So for this script to work, graphs.m must be run first).
    % 'gen_distributions' includes fields as Solution_1, Solution_2 until
    % the solution number the user inputted in the begining of graphs.m. We
    % will try to find how many solutions there are first. To do this,
    % number of fields could have been counted but it would be wrong if 
    % later some new information is decided to be saved as a field in
    % graphs.m. So we will try something more detailed.
    fl_nm_gen_distr=fieldnames(gen_distributions); % take the list of fields 
    M=numel(fl_nm_gen_distr); % number of fields
    solutions=[]; 
    for m=1:M % for each field
        if strfind(fl_nm_gen_distr{m},'Solution_')==1 % If the field starts with 'Solution_'
            m_=str2num(fl_nm_gen_distr{m}(10:end)); % take the number coming after as a solution number
            if length(m_)==1 % If what is coming after is actually a number (otherwise it would be 0)
                solutions=[solutions m_]; % add it to the solutions list.
            end
        end
    end
    clear m
    clear m_
    no_solns=length(solutions); % 'solutions' contains solution numbers available as [1 2 3 ...]
    soln_selected= input(['Select a solution: ' num2str(solutions) ' are available: ']); % User selects a solution
    while 1
        if ismember(soln_selected,solutions) % If ok, exit the while loop
            display(['Solution ' num2str(soln_selected) ' is selected.']);
            break;
        else % If not ok, ask again
            display('It is not available!');
            soln_selected= input(['Select a solution: ' num2str(solutions) ' are available: ']);
        end
    end
    if isfield(gen_distributions.(['Solution_' num2str(soln_selected)]),'Gen_tree_vis') % If Gen_tree_vis is there or not. It is added recently so an older version of graphs.m might not create this field.
        d_temp=gen_distributions.(['Solution_' num2str(soln_selected)]).Gen_tree_vis;
    else
        error('Related information could not be found. Selected optimization might be from an older version.');
    end
    floretIDs=unique(d_temp(:,3)); % d_temp contains floret info (depth-segment Length-floretID). 'floretIDs' contains available floret IDs 
    display(['There are ' num2str(length(floretIDs)) ' florets:']);
    display(' 1. Draw all');
    display(' 2. I will select one');
    all_or_1=input('Enter 1 or 2: ');
    while 1
        if (all_or_1==1) || (all_or_1==2)
            break;
        else % If user didnt input 1 or 2, ask again
            all_or_1=input('Enter 1 or 2: ');
        end
    end
    
    if (all_or_1==1) %this block is to create 'floretIDs_selected'. the florets whose IDs are in this array will be drawn
        display('All florets will be drawn.')
        floretIDs_selected=floretIDs; % all available ones will be drawn
    elseif (all_or_1==2)
        display(['Available Floret IDs : ' num2str(floretIDs')]); % list the available IDs
        floretIDs_selected = input('Select a Floret ID: ');
        while 1
            if ismember(floretIDs_selected,floretIDs) % If user input one of the available IDs
                display(['Floret ' num2str(floretIDs_selected) ' is selected.']);
                break;
            else % If user input an unavailable ID, ask again
                display('This ID is not available!');
                floretIDs_selected = input('Select a Floret ID: ');
            end
        end
    end
    
    for k=1:length(floretIDs_selected) % floret information ( depth-segment length) is concatenated vertically in 'd_temp'. We take selected florets and put it in the cells of 'd' separately.
        d{1,k}=d_temp( d_temp(:,3)==floretIDs_selected(k) ,:); %d{1,k}=rows of 'd_temp' whose 3rd column is equal to floretIDs_selected(k) (that is; information (depth&segmentLength) of ONE floret)
        % later we will give each cell of 'd' one by one to a code that draws one floret
    end
end

% the cell 'd' is actual output of the whole thing above. It will be
% processed later.

% Prepare the target folders for output.
if modelInput==0 % If real data. Create folders one by one if they dont exist.
    % dendrograms will be outputted in
    % <main>/graphs/BiologicalDendrograms/fig folder for example ( if the
    % format selection is fig)
    if ~exist([pathstr '/graphs/BiologicalDendrograms'],'dir')
        mkdir([pathstr '/graphs/BiologicalDendrograms']);
    end
    if ~exist([pathstr '/graphs/BiologicalDendrograms/' typestr],'dir')
        mkdir([pathstr '/graphs/BiologicalDendrograms/' typestr]);
    end
else % If one of the optimized models. Create folders one by one if they dont exist.
    % Dendrograms will be outputted in
    % <main>/out/<model>/Dendrograms/Solution_x/fig folder for example ( if the
    % format selection is fig)
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

% Dendrograms are drawn in the block below.
% There is one dendrogram in each cell of 'd'
fig=figure;
for floret=1:size(d,2) % size(d,2) is number of florets( or trees or dendrograms)
    clf(fig,'reset'); % For multiple dendrograms, the same figure will be used again and again instead of closing and reopening because it is faster. So we should clear the previous one first. 
    hold on;
    d_=d{1,floret}; % d_ is the info of one dendrogram (depth-SegmentLength-floretID) (floretID is all same because it is one dendrogram)
    A=zeros(size(d_,1),size(d_,1)); % A is a binary matrix ( 1 or 0) indicating parent-child relation of segments ( each row of d_ is a segment)
    for k=2:size(d_,1)
        c=find(d_(1:k,1)==(d_(k)-1)); 
        e=max(c);
        A(k,e)=1; % segment e is parent of segment k. There is no parent of segment 1 so the for loop started from 2. 
    end
    
    maxdepth=max(d_(:,1));
    up=1;
    down=-1;
    plot([0 d_(1,2)], [0 0],'k'); % Segment 1. The main one. (d_(x,2) is the length of xth segment). Plot a horizontal line with the length of the segment.
    segmentends=[d_(1,2) 0]; % hold the x,y of the end of the segment one so that childs could could be added there. ('segmentends' will contain xth segment's x,y in its xth column)
    for k=2:size(d_,1);
        m=find(A(k,:)); % find the parent of the segment (there could be only one)
        if sum(A(1:(k-1),m))==1 % If the segment is the 2. child of the parent, bifurcate down.
            dir=down;
        else % If the segment is the 1. child of the parent, bifurcate up.
            dir=up;
        end
        dir=dir*2^(maxdepth+1-d_(k,1)); % Dendrogram gets crowded towards higher depths. In each depth, bifurcations should be wide enough so that higher depths fit in without any crossing
        plot([1 1]*segmentends(m,1), [0 dir]+segmentends(m,2),'k'); % go up or down from the end of the parent ( bifurcate)
        plot([0 d_(k,2)]+segmentends(m,1), [dir dir]+segmentends(m,2),'k'); % go right with the length of segmentLength from the end of bifurcation (actual segment)
        segmentends(k,:)=[d_(k,2)+segmentends(m,1) dir+segmentends(m,2)]; % hold the segment end for childs
    end
    
    set(gca,'ytick',[]) % delete yticks (they dont mean anything)
    ylength=max(1,1.1*max(abs(segmentends(:,2)))); % take the max vertical occupation
    axis([0 inf -ylength ylength]); % it makes the main segment ( 1st one ) start from exactly the vertical midpoint
    title(['Floret ' num2str(floretIDs_selected(floret))]);
    xlabel('Length (microns)');
    %Save
    if modelInput==0 % If real data, save in the folder prepared before (above)
        saveas(gcf,[pathstr '/graphs/BiologicalDendrograms/' typestr '/' num2str(floretIDs_selected(floret)) '.' typestr]);
    else % If generated data, save in the folder prepared before (above)
        saveas(gcf,[pathstr '/out/' outputName{modelInput} '/Dendrograms/Solution_' num2str(soln_selected) '/' typestr '/' num2str(floretIDs_selected(floret)) '.' typestr]);
    end
end

if size(d,2)==1 % Inform the user where the dendrograms are saved
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
cd(path_old); % cd back to the old one