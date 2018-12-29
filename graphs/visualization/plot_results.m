function plot_results(divergence, options, nrow, ncol)

    load('gaResult.mat');

    gaResult = res{divergence,1};
    DIV = res{divergence,2};
    
    div_function = -1;
    
    switch DIV
        case 'KL Simple'
            div_function = @(x,y) kldivergence(x,y);
        case 'KL Reverse'
            div_function = @(x,y) kldivergence(y,x);
        case 'JS'
            div_function = @(x,y) shannonjensen(x,y); 
        case 'KL Ks'
            div_function = @(x,y) kldivergenceks(x,y); 
        case 'KL Ks reverse'
            div_function = @(x,y) kldivergenceks(y,x); 
        case 'JS Ks'
            div_function = @(x,y) shannonjensenks(x,y);
    end

    plotNSets(options,gaResult,nrow,ncol,DIV,div_function);
