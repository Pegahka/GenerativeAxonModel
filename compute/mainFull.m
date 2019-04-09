clear;
initSetList = dir('../in'); % current folder was <main>/compute. Take the list of what is inside <main>/in into 'initSetList'. It will be a struct. 
numSetList = length(initSetList)-2;     % number of sub-folders in the input folder '<main>/in' excluding '.' and '..' folders
if exist('../in/.DS_Store','file')
    numSetList=numSetList-1; % If there is .DS_Store (A file created by Linux I think), it is not a model also. So exclude it.
end
modelName = cell(1,numSetList); % We will take the names of the models in modelName cell
count = 1;
for i = 1:length(initSetList) % Check folders one by one if they are model names or not
    initSetDir = initSetList(i).name; % Take the 'name' field of the struct. ( take the name of the candidate)
    if ((strcmp(initSetDir,'.') ~= 0) || (strcmp(initSetDir,'..') ~= 0) || (strcmp(initSetDir,'.DS_Store') ~= 0)) % If it is NOT a model, pass, do nothing
        continue; 
    else % If it is a model get the name of it
        modelName{count} = initSetDir;  % get the name of the model
        count = count + 1;
    end
end

m = 'y'; % this is a flag created for multiple use of the code. It is attained as 'y' for the sake of first use. After each use, the user is asked if it use the code again. If the answer is 'y' (yes), the code repeats. If the answer is 'n' (no) the code stops.
while (ischar(m) && (m == 'y'))
    fprintf('Please choose a model by entering a number between 1 to %d, where \n', numSetList); %We list the model names Which we took into 'modelName' cell before.
    for i=1:numSetList
        fprintf(' %d stands for the model: %s \n',i, modelName{i});
    end
    n = input('Enter a number: '); % the code waits for the user to enter something
    count = 1;
    while (~isnumeric(n) || ~isinf(n)) % If the user input is not 'appropriate', ask it again and again
        if (floor(n) == n) && (n>=1) && (n<=numSetList) % If the user input is 'appropriate'
            fprintf('You have chosen the *%s* model for computation\n', modelName{n}); % user chose the model without problem
            break; % exit while loop
        else % If the user input is not 'appropriate', prompt the user to enter a proper input. If the input is proper or not will be decided in next 'while' turn
            fprintf('Wrong value!! Please enter an integer in range [1, %d]:',numSetList);
            n = input(''); % wait for a new input
            count = count + 1;
            if mod(count,3) == 0 %This part is for excessive inappropriate inputs. 
                disp('Please note that:')
                for i=1:numSetList
                    fprintf('    enter %d for selecting the model: %s \n',i, modelName{i});
                end
            end
        end
    end % the model is selected and its index is in the variable 'n'
    
    no_florets_given = input('Specify the number of florets: '); % take the number of florets generated for the each individual (member) of generations in GA. It is similar to model input above.
    while 1 % until break, ask again and again.
        if (floor(no_florets_given) == no_florets_given) && (no_florets_given>=1) % If the input is appropriate.
            break; % exit from the while loop and continue
        else % the input is not proper
            display('The number of florets should be a positive integer'); % A warning message.
            no_florets_given = input('Specify the number of florets: '); % Wait for a new input
        end
    end 
    
    no_generations_given = input('Specify the number of GA iterations: '); % take the number of generations for Genetic Algorithm (GA). Similar. 
    while 1
        if (floor(no_generations_given) == no_generations_given) && (no_generations_given>=1)
            break;
        else
            display('The number of GA iterations should be a positive integer');
            no_generations_given = input('Specify the number of GA iterations: ');
        end
    end
       
    
    if (~exist('../out','dir')) % If '<main>/out' folder doesnt exist, create
        mkdir('../out');
    end
    if (exist('init.mat', 'file') == 2) % If there is init.mat in <main>/compute folder, delete it (it is from previous uses), because we will use a new one according to selected options above.
        delete('init.mat');
    end
    copyfile(sprintf('../in/%s/init.mat',modelName{n}),'init.mat'); % Take (copy) the new init.mat file from <main>/in/'modelSelected'/ to the <main>/compute
    main(); %Call <main>/compute/main.m. Computations will be made and results will be saved there.
    fprintf('Finished computing the *%s* model!\n', modelName{n}); %Inform the user that computation is finished.
    m = input('Would you like to compute another model? Type y for YES, and n for NO: ','s'); %Ask the user if it use the code again. If he wants, while loop goes on.
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