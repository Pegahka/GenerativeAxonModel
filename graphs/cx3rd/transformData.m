function data = transformData(data)  

if (size(data,1) > 2)
        i = 1;                                      
        
        while i < size(data,1) + 1
            if data(i,2) == -1
                if data(i-1,1) == (data(i,1) - 1)
                    j = i + 1;
                    if data(j,2) == -1 
                        data(i:i+1,:) = [];
                    else                        
                        
                        first = 1;
                        while j < size(data,1) && (data(i+1,1) < data(j,1) || first)
                            first = 0;
                            j = j + 1;
                        end
                        
                        if data(i + 1,1) >= data(j,1) 
                            j = j - 1;
                        end
                        
                        data(i-1,2) = data(i-1,2) + data(i+1,2);
                        data(i:j,1) = data(i:j,1) - 1;
                        data(i:i+1,:) = []; 
                    end
                else
                    j = i - 1;
                    if data(j,2) == -1
                        data(i-1:i,:) = [];
                    else                        
                        while data(j,1) ~= data(i,1)
                            j = j - 1;
                        end
                    end
                    
                    data(j-1,2) = data(j - 1,2) + data(j,2);
                    data(j:i,1) = data(j:i,1) - 1;
                    data(i,:) = []; data(j,:) = [];
                end
                
                i = i - 1;
            else            
                i = i + 1;
            end
        end        
    end
    
    if data(end,2) == -1
        data(end,:) = [];
    end
end