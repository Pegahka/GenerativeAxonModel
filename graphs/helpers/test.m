n = 50000;
g = 0.9;

x = [];

for i=1:n
    k = 0;
    while unifrnd(0,1) < g        
        k = k + 1;       
    end
    
    b = 0;
    for j = 1:k
        b = b + 1.6 + gamrnd(1.6,2.2);
    end
    
    if b ~= 0
        x = [x, b];
    end
end

binWidth = 5;
noBins = floor(max(x)-min(x))/binWidth;
[f_temp, bincenters] = hist(x,noBins); f_temp = f_temp/length(x);
frequency = f_temp / (bincenters(2)-bincenters(1));

plot(bincenters,frequency,'b');
hold on;
mu = mean(log(x));
sigma = std(log(x));

y = lognrnd(mu,sigma,15000,1);

binWidth = 5;
noBins = floor(max(y)-min(y))/binWidth;
[f_temp, bincenters] = hist(y,noBins); f_temp = f_temp/length(y);
frequency = f_temp / (bincenters(2)-bincenters(1));

plot(bincenters,frequency,'r');