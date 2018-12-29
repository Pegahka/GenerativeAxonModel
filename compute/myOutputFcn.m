function [state,options,optchanged] = myOutputFcn(options,state,flag,interval)
if ~strcmp(flag,'done')
    g_number = state.Generation ; %get current generation number
    if g_number
        disp(['Genetic Algorithm Iteration: ' num2str(g_number)]);
    end
    global global_best; %#ok<*TLEV>
    global global_mean;
    global_best(1,g_number+1)= min(state.Score);
    global_mean(1,g_number+1)=mean(state.Score);
end
optchanged = false;
end