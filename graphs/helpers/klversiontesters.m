addpath(genpath('../common'));

x = extractFeaturesSegments('XY_floret_dendrogram.xml');
x = x(:,2);
x = x(x>=1);
x = log(x);

for i = 1:100
    tic
    y = generateData(1,1);
    t(i) = toc
    y = y(:,2);
    y = log(y);
    tic
    klo(i) = kldivergence(x,y);
    %jso(i) = shannonjensen(x,y);
    toi(i) = toc;
    

    tic
    kln(i) = kldivergenceNew(x,y);
    %jsn(i) = shannonjensenNew(x,y);
    tn(i) = toc;

end

subplot(1,2,1);
plot(klo,'b');
%plot(jso,'b');
hold on;
plot(kln,'g');
%plot(jsn,'g');
plot(1:100,ones(1,100)/2);
xlabel('NUMBER OF DATAPOINTS');
ylabel('DIVERGENCE RESULT');

subplot(1,2,2);

plot(toi,'b');
hold on;
plot(tn,'g');
xlabel('NUMBER OF DATAPOINTS');
ylabel('RUNNING TIME');

