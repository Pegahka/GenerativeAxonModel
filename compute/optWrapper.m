function out = optWrapper(settings)
    
    % function optWrapper
    
    % input:
    
    % settings: run specific settings (initialized in initparams.m) 
    % + actual divergence measure used in the fitness function
    tic
    
    settings.gaoptions.UseParallel = true; %This settings.gaoptions is something predefined for GA. There is a certain format of it. We can change somethings in it but we must stay in line with the format. Details can be found on internet.
    settings.gaoptions.OutputFcns = @myOutputFcn; % Set <main>/compute/myOutputFcn.m as output function of GA. It is visited after every iteration of GA. It is used to show the user which iteration the GA in. That way, the user knows that GA is running actually while waiting.
                                                   % output function is
                                                   % also used to take
                                                   % convergence
                                                   % information.
%     settings.gaoptions.PlotInterval = 1; % another way of plotting
%     convergence but it is not preferred.
%     settings.gaoptions.PlotFcns= @gaplotbestf; % another way of plotting
%     convergence but it is not preferred.
    global global_best; % they are about convergence plot. GA has a separate workspace. Global variables are a way to pass variables between different workspaces.
    global global_mean;
    
    %GA is actually called here. Input output format can be found on
    %internet. As it is seen, inputs are all from 'settings' struct. Some
    %of them were predefined in init.m and some of them are taken from the
    %user interface.
    [optResult,fval,exitflag,output,population,scores] = ga(eval(settings.divObject),settings.no_params,settings.A,settings.b,[],[],settings.lb,settings.ub,[],settings.gaoptions);
    
    %Outputs are saved to 'out' struct below and outputted from this function (<main>/compute/optWrapper.m) to
    %the caller function <main>/compute/main.m
    
    out = struct;
    
    out.optResult = optResult;
    out.fval = fval;
    out.exitflag = exitflag;
    out.output = output;
    out.population = population;
    out.scores = scores; 
    out.best_thru_iterations=global_best;
    out.mean_thru_iterations=global_mean;
    
    time = toc;
    out.time = time;
    
    clear global global_best;
    clear global global_mean;
end














