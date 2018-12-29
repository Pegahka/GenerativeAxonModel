
limit = 101;

x = zeros(limit,1);


m = 100:200;

acc = 10;

b = treegenerator(m, 0.5);
asymmetry(b)
for i=1:limit; 
    
    b = treegenerator(m(i), 0.5);
    tic;
    for j=1:acc
        asymmetry(b)
    end
    x(i) = toc; x(i) = x(i)/acc;
end

plot(m',x,'green'); title('Performance'); xlabel(' depth / 10'); ylabel('time'); 