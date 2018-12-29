function out = optWrapper(settings)
    
    % function optWrapper
    
    % input:
    
    % settings: run specific settings (initialized in initparams.m) 
    % + actual divergence measure used in the fitness function
    tic
    
    settings.gaoptions.UseParallel = true;
    settings.gaoptions.OutputFcns = @myOutputFcn;
%     settings.gaoptions.PlotInterval = 1;
%     settings.gaoptions.PlotFcns= @gaplotbestf;
    global global_best;
    global global_mean;
    [optResult,fval,exitflag,output,population,scores] = ga(eval(settings.divObject),settings.no_params,settings.A,settings.b,[],[],settings.lb,settings.ub,[],settings.gaoptions);
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














