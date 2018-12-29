n = 100000; 

x = unifrnd(0,1,n,1);

lb = min(x);
ub = max(x);

j = 1;
for i = lb:(ub-lb)/(n-1):ub    
    xi(j) = i;
    fxi(j) = unifpdf(i,0,1);
    j = j + 1;    
end

[fxks, xks] = ksdensity(x);

A = 0; B = 0; C = 0; D = 0;

tic 
for i=1:length(fxks)-1
%    A = A + abs(fxks(i+1)-fxks(i)) * abs(xks(i+1)-xks(i)) + ...
        min(fxks(i),fxks(i+1)) * abs(xks(i+1)-xks(i));
    
    mean([fxks(i+1),fxks(i)]) 
    
    B = B + mean([fxks(i+1),fxks(i)]) * abs(xks(i+1) - xks(i));
    
%    C = C + min([fxks(i+1),fxks(i)]) * abs(xks(i+1) - xks(i));
    
%    D = D + max([fxks(i+1),fxks(i)]) * abs(xks(i+1) - xks(i));
end
toc
tic
k1 = zeros(length(fxks)+1,1);
k2 = zeros(length(fxks)+1,1);

k1(2:end) = fxks; 
k2(1:end-1) = fxks;

k = (k2+k1)/2;



j1 = zeros(length(xks)+1,1);
j2 = zeros(length(xks)+1,1);

j1(2:end) = xks; 
j2(1:end-1) = xks;

j = abs(j2-j1);

E = k(2:end-1)'*j(2:end-1);


toc



plot(xks, fxks);
hold on;
plot(xi,fxi,'g');