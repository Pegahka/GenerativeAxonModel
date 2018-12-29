function data = treegenerator(n,treshold)

data = [];
generator(1,n);

    function generator(depth,n)
        data = [data depth];
        %ratio = unifrnd(treshold,1);
        ratio = treshold;
        if n > 1/ratio + 1   
            generator(depth + 1, floor(n*ratio));
            generator(depth + 1, n-floor(n*ratio) - 1);
        end
        
    end
end