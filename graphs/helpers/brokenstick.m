s = 1000;

p = zeros(s,1);

for i=1:s
    for j=0:s-i
        p(i) = p(i) + 1/(s-j);
    end
end

p = p/s;

subplot(3,1,1);
plot(p)

a = geornd(0.5,1000,1);
a = a / max(a);
a = sort(a);
b = [0; a];
c = [a; 0];

d = c - b; d=d(2:end-1);
subplot(3,1,2);
sum(d)
d = sort(d,'descend');
plot(d);

for jj = 1:3

    d = []; d(1) = 1;
    for i=1:1000
        ind = unidrnd(length(d));
        val = d(ind);
        r = unifrnd(0,1);
        d(ind) = r* val;
        d = [d; val*(1-r)];
    end

    subplot(3,1,3);
    d = sort(d,'descend');
    plot(d);
    
end
