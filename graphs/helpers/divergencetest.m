function divergencetest

    addpath(genpath('../common'));

    rd = mvnrnd([0 0]', [1 1; 1 2],2000);
    
    fun = @(x) fitness(x);
    
    s = ga(fun,1,[],[],[1],[100]);
    
    function ret = fitness(x)
        ret = kldivergenceNew(rd, mvnrnd([0 0]', [x 1; 1 x],2000));
    end

    data1 = mvnrnd([0 0]', [1 1; 1 2],500);
    data2 = mvnrnd([0 0]', [s 1; s 2],500);
    
    
    plot(data1(:,1),data2(:,2),'. ');
    hold on;
    plot(data1(:,1),data2(:,2),'r.');
    
end
