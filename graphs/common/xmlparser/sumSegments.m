function data = sumSegments(data)
    
    noDescendants = zeros(size(data,1),1);
    i = 1;
    
    while i < size(data,1) 
        if data(i,1) >= data(i+1,1) 
            noDescendants(i) = 0;
        end
        
        subfloretSize = 1;
        
        while ((subfloretSize + i -1 < size(data,1)) && (data(i,1) < data(i + subfloretSize,1)))
            subfloretSize = subfloretSize + 1;
        end
        
        noDescendants(i) = sum(data(i:i + subfloretSize - 1,1) == data(i,1)+1);
        
        if noDescendants(i) == 1
            data(i + 1:i + subfloretSize - 1,1) = data(i + 1:i + subfloretSize - 1,1) - 1;
            data(i,2) = data(i,2) + data(i+1,2);
            data = [data(1:i,:); data(i+2:end,:)];
        else 
            i = i + 1;
        end
    end


    