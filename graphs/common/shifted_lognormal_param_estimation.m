function [meanq, varq, shiftq] = shifted_lognormal_param_estimation(points)

    global points_all;
    points_all = points;

    options = gaoptimset(@ga);
    options.PopulationSize = 400;
    options.Generations = 200;

    xx = ga(@slnp_minimze, 3, [], [], [], [], [-Inf 0.0001 -Inf], [Inf Inf min(points_all)*0.99], [], options);


    meanq = xx(1);
    varq = xx(2);
    shiftq = xx(3);
end