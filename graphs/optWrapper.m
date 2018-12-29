function out = optWrapper(settings)
    
    % function optWrapper
    
    % input:
    
    % settings: run specific settings (initialized in initparams.m) 
    % + actual divergence measure used in the fitness function
    tic
    
    [optResult,fval,exitflag,output,population,scores] = ga(eval(settings.divObject),settings.no_params,settings.A,settings.b,[],[],settings.lb,settings.ub,[],settings.gaoptions);
    out = struct;
    
    out.optResult = optResult;
    out.fval = fval;
    out.exitflag = exitflag;
    out.output = output;
    out.population = population;
    out.scores = scores; 
    
    time = toc;
    out.time = time;
    
end














