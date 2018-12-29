
d = []; d(1) = 1;
for i=1:1000
    ind = unidrnd(length(d));
    val = d(ind);
    r = unifrnd(0,1);
    d(ind) = r* val;
    d = [d; val*(1-r)];
end

x = log(d);

mu = mean(x);
std_ = std(x);

y = normrnd(mu,std_, 1000,1);
ksdensity(x);
hold on; 
ksdensity(y);
    

