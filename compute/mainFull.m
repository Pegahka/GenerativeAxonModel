clear;
initSetList = dir('../in');
numSetList = length(initSetList)-2;     % number of sub-folders in the input folder 'in'
if exist('../in/.DS_Store','file')
    numSetList=numSetList-1;
end
modelName = cell(1,numSetList);      
count = 1;
for i = 1:length(initSetList)
    initSetDir = initSetList(i).name;
    if ((strcmp(initSetDir,'.') ~= 0) || (strcmp(initSetDir,'..') ~= 0) || (strcmp(initSetDir,'.DS_Store') ~= 0))
        continue;
    else
        modelName{count} = initSetDir;  % get name of all models
        count = count + 1;
    end
end

m = 'y';
while (ischar(m) && (m == 'y'))
    fprintf('Please choose a model by entering a number between 1 to %d, where \n', numSetList);
    for i=1:numSetList
        fprintf(' %d stands for the model: %s \n',i, modelName{i});
    end
    n = input('Enter a number: ');
    count = 1;
    while (~isnumeric(n) || ~isinf(n))
        if (floor(n) == n) && (n>=1) && (n<=numSetList)
            fprintf('You have chosen the *%s* model for computation\n', modelName{n});
            break;
        else
            fprintf('Wrong value!! Please enter an integer in range [1, %d]:',numSetList);
            n = input('');
            count = count + 1;
            if mod(count,3) == 0
                disp('Please note that:')
                for i=1:numSetList
                    fprintf('    enter %d for selecting the model: %s \n',i, modelName{i});
                end
            end
        end
    end
    
    no_florets_given = input('Specify the number of florets: ');
    while 1
        if (floor(no_florets_given) == no_florets_given) && (no_florets_given>=1)
            break;
        else
            display('The number of florets should be a positive integer');
            no_florets_given = input('Specify the number of florets: ');
        end
    end
    
    no_generations_given = input('Specify the number of GA iterations: ');
    while 1
        if (floor(no_generations_given) == no_generations_given) && (no_generations_given>=1)
            break;
        else
            display('The number of GA iterations should be a positive integer');
            no_generations_given = input('Specify the number of GA iterations: ');
        end
    end
       
    
    if (~exist('../out','dir')) % check whether '../out' folder is existed to create
        mkdir('../out');
    end
    if (exist('init.mat', 'file') == 2) % check whether 'init.mat' file is existed to delete
        delete('init.mat');
    end
    copyfile(sprintf('../in/%s/init.mat',modelName{n}),'init.mat');
    main();
    fprintf('Finished computing the *%s* model!\n', modelName{n});
    m = input('Would you like to compute another model? Type y for YES, and n for NO: ','s');
    while ischar(m)
        if (string(m) == 'y' || string(m) == 'n')
            break;
        else
            m = input('Wrong value!! Please enter y for YES, and n for NO: ', 's');
        end
    end
%     close all;
    if (char(m) == 'n')
        disp('********************** Computation finished **********************');
        break;
    else
        disp('************* Compute another model *************');
    end
end
clearvars;

