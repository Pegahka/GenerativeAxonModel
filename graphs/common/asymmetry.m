function ret = asymmetry(floret)
    
% function asymmetry

% computes the asymetry of the floret

% floret is the array containing the depth of the branches
    
ret = 0;

weighted = size(floret,2) == 2;

if weighted 
    lengths = floret(:,2);
    floret = floret(:,1);
end

if length(floret) < 4
    return
end

for i = 1:length(floret) - 1;
    j = i + 1;
    
    if j < length(floret) && floret(j) == floret(i) + 1                
        
        if weighted
            wr = 0;
            wr = wr+ lengths(j); 
        end
        j = j + 1;
        
        while j < length(floret) && floret(j) > floret(i + 1)
            if weighted
                wr = wr + lengths(j);  
            end
            j = j + 1;
        end
        
        if weighted             
            wr = wr/(j - i - 1);
        end
        
        r = (j - i) / 2;        
        
        k = j;
        
        if weighted
            ws = lengths(k);
        end
        
        while k < length(floret) && floret(k) > floret(i)
            k = k + 1;
            if weighted
                ws = ws + lengths(k);
            end                        
        end
        
        if k == length(floret)
            
            if weighted
                ws = ws/(k - j + 1);
            end
            
            s = (k - j + 2)/2;
            
        else
            if weighted 
                ws(end) = [];
                ws = ws/(k - j);
            end
            
            s = (k - j + 1)/2;
            
        end
        
        if (s + r > 2)
            if (weighted)
                ret = ret + abs(ws*s - wr*r)/ ((ws + wr)/2 * (s + r - 2));
            else
                ret = ret + abs(s - r)/ (s + r - 2);
            end
        end
    end
end

ret = 2 * ret / (length(floret) - 1);